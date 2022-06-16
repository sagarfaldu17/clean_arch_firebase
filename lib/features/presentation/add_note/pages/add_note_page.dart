import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sqflite_example/core/utils/constants.dart';
import 'package:sqflite_example/di/injector.dart';
import 'package:sqflite_example/features/data/model/note_model.dart';
import 'package:sqflite_example/features/presentation/add_note/bloc/add_note_bloc.dart';
import 'package:sqflite_example/features/presentation/add_note/widget/success_widget.dart';
import 'package:sqflite_example/features/presentation/add_note/widget/success_widget_2.dart';
import 'package:sqflite_example/features/presentation/add_note/widget/text_field_widget.dart';
import 'package:sqflite_example/core/utils/priority_util.dart';
import 'package:uuid/uuid.dart';

class AddNotePage extends StatefulWidget {
  const AddNotePage({Key? key}) : super(key: key);

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  late AddNoteBloc addNoteBloc;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  Priority? _priority;

  @override
  initState() {
    super.initState();
    addNoteBloc = sl<AddNoteBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add a new note"),
      ),
      body: BlocBuilder(
        bloc: addNoteBloc,
        builder: (context, state) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            child: Column(
              children: [
                TextFieldWidget(
                  controller: titleController,
                  hint: "Send mail",
                  label: "Title",
                ),
                SizedBox(height: 16.h),
                TextFieldWidget(
                  controller: descriptionController,
                  hint: "I will not be able to come office",
                  label: "Description",
                ),
                SizedBox(height: 16.h),
                Row(
                  children: const [Text("Set priority")],
                ),
                SizedBox(height: 16.h),
                ListTile(
                  title: const Text("Low"),
                  leading: Radio<Priority>(
                      value: Priority.low,
                      groupValue: _priority,
                      onChanged: (value) {
                        setState(() {
                          _priority = value;
                        });
                      }),
                ),
                ListTile(
                  title: const Text("Medium"),
                  leading: Radio<Priority>(
                      value: Priority.medium,
                      groupValue: _priority,
                      onChanged: (value) {
                        setState(() {
                          _priority = value;
                        });
                      }),
                ),
                ListTile(
                  title: const Text("High"),
                  leading: Radio<Priority>(
                      value: Priority.high,
                      groupValue: _priority,
                      onChanged: (value) {
                        setState(() {
                          _priority = value;
                        });
                      }),
                ),
                // SuccessWidget(),
                SuccessWidgetTwo()
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addNoteBloc.add(
            AddNoteSubmitEvent(
              NoteModel(
                title: titleController.text,
                description: descriptionController.text,
                date: DateTime.now(),
                uid: const Uuid().v1(),
                priority: PriorityUtil.getPriorityCount(_priority),
              ),
            ),
          );
          // Navigator.pop(context);
        },
        child: const Icon(Icons.check),
      ),
    );
  }
}
