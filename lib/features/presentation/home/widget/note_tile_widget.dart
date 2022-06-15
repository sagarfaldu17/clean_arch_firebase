import 'package:flutter/material.dart';
import 'package:sqflite_example/features/data/model/note_model.dart';

class NoteTile extends StatelessWidget {
  final NoteModel note;
  final VoidCallback? onDelete;

  const NoteTile({
    Key? key,
    required this.note,
    this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 3,
      shadowColor: Colors.grey,
      child: ListTile(
        title: Text(
          note.title ?? "",
          style: const TextStyle(
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        subtitle: Text(
          note.description ?? "",
        ),
        trailing:
            IconButton(icon: const Icon(Icons.delete), onPressed: onDelete),
      ),
    );
  }
}
