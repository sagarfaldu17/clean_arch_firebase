import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:sqflite_example/features/data/model/note_request_model.dart';
import 'package:sqflite_example/features/presentation/add_note/widget/success_widget.dart';
import 'package:sqflite_example/features/presentation/add_note/widget/success_widget_2.dart';
import 'package:sqflite_example/features/presentation/home/widget/add_button_widget.dart';
import 'package:sqflite_example/features/presentation/home/widget/loader_widget.dart';
import 'package:sqflite_example/features/presentation/home/widget/note_tile_widget.dart';
import 'package:sqflite_example/core/utils/constants.dart';
import 'package:sqflite_example/di/injector.dart';
import 'package:sqflite_example/features/data/model/note_model.dart';
import 'package:sqflite_example/features/presentation/home/bloc/note_list_bloc/note_list_bloc.dart';
import 'package:sqflite_example/features/presentation/home/widget/refresh_button_widget.dart';

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
          RefreshButtonWidget(
              onPressed: () => noteListBloc.add(GetNoteListEvent())),
          const AddButton(),
        ],
      ),
      body: BlocBuilder<NoteListBloc, NoteListState>(
        bloc: noteListBloc,
        builder: (context, NoteListState state) {
          switch (state.runtimeType) {
            case NoteListInitialState:
              return const LoaderWidget();
            case NoteListLoadingState:
              return const LoaderWidget();
            case NoteListEmptyState:
              return const _BuildEmptyWidget();
            case NoteListSuccessState:
              return _buildListWidget(noteListBloc.noteList);
            case NoteListFailureState:
              return const _BuildFailureEvent();
            default:
              return const Center(child: Text("Unknown - Error"));
          }
        },
      ),
    );
  }

  Widget _buildListWidget(List<NoteModel> noteList) {
    return AnimatedList(
      key: noteListBloc.listKey,
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
              noteListBloc.listKey.currentState?.removeItem(
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
}

class _BuildFailureEvent extends StatelessWidget {
  const _BuildFailureEvent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Sorry, Something went wrong :("));
  }
}

class _BuildEmptyWidget extends StatelessWidget {
  const _BuildEmptyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.network(
        Constants.emptyURL,
        height: 160.h,
      ),
    );
  }
}
