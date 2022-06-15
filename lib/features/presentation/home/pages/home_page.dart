import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:sqflite_example/features/data/model/note_request_model.dart';
import 'package:sqflite_example/features/presentation/home/widget/add_button_widget.dart';
import 'package:sqflite_example/features/presentation/home/widget/note_tile_widget.dart';
import 'package:sqflite_example/core/utils/constants.dart';
import 'package:sqflite_example/di/injector.dart';
import 'package:sqflite_example/features/data/model/note_model.dart';
import 'package:sqflite_example/features/presentation/home/bloc/note_list_bloc/note_list_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late NoteListBloc noteListBloc;

  @override
  void initState() {
    super.initState();
    noteListBloc = sl<NoteListBloc>();
    noteListBloc.add(GetNoteListEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Screen"),
        actions: [
          IconButton(
              onPressed: () {
                //TODO: Need to implement tween animation on press and refresh the firebase data
              },
              icon: const Icon(Icons.sync)),
          const AddButton(),
        ],
      ),
      body: BlocBuilder<NoteListBloc, NoteListState>(
        bloc: noteListBloc,
        builder: (context, NoteListState state) {
          if (state is NoteListInitialState || state is NoteListLoadingState) {
            return _buildLoadingWidget();
          } else if (state is NoteListEmptyState) {
            return _buildEmptyWidget();
          } else if (state is NoteListSuccessState) {
            return _buildListWidget(noteListBloc.noteList);
          } else if (state is NoteListFailureState) {
            return _buildFailureWidget();
          } else {
            return const Text("Unknown - state");
          }
        },
      ),
    );
  }

  Widget _buildListWidget(List<NoteModel> noteList) {
    return AnimatedList(
      key: Constants.listKey,
      initialItemCount: noteList.length,
      itemBuilder: (context, index, animation) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(-1, 0),
            end: const Offset(0, 0),
          ).animate(animation),
          child: NoteTile(
            key: Key(index.toString()),
            note: noteList[index],
            onDelete: () async {
              //Animate and delete from the database
              Constants.listKey.currentState?.removeItem(
                noteList.indexOf(noteList[index]),
                (_, animation) {
                  return _slide(animation, NoteTile(note: noteList[index]));
                },
                duration: const Duration(milliseconds: 400),
              );
              Future.delayed(const Duration(milliseconds: 500), () {
                noteListBloc.add(
                    DeleteNoteEvent(NoteRequestModel(noteList[index].uid)));
              });
            },
          ),
        );
      },
    );
  }

  SlideTransition _slide(Animation<double> animation, Widget child) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(-2, 0),
        end: const Offset(0.0, 0.0),
      ).animate(animation),
      child: child,
    );
  }

  Widget _buildLoadingWidget() {
    return Center(
      child: Lottie.network(
        Constants.loadingURL,
        height: 160.h,
      ),
    );
  }

  Widget _buildEmptyWidget() {
    return Center(
      child: Lottie.network(
        Constants.emptyURL,
        height: 160.h,
      ),
    );
  }

  Widget _buildFailureWidget() {
    return const Center(child: Text("Sorry, Something went wrong :("));
  }
}
