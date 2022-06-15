import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sqflite_example/core/base/base_response.dart';
import 'package:sqflite_example/features/data/model/note_model.dart';

class FirebaseHelper {
  FirebaseFirestore fs = FirebaseFirestore.instance;
  static const String collectionNotes = "notes";

  CollectionReference getNotesCollection() {
    return fs.collection(collectionNotes);
  }

  Future<BaseResponse<dynamic>> addNote(NoteModel noteModel) async {
    await getNotesCollection().doc(noteModel.uid).set(noteModel.toJson());
    return BaseResponse();
  }

  Future<BaseResponse> getNotes() async {
    List<NoteModel> noteList = [];
    QuerySnapshot ds = await getNotesCollection().get();
    for (var element in ds.docs) {
      NoteModel note =
          NoteModel.fromJson(element.data() as Map<String, dynamic>);
      if (note.isDeleted == false) {
        noteList.add(note);
      }
    }
    return BaseResponse(data: noteList);
  }

  Future<BaseResponse> deleteNote(String uid) async {
    await fs.collection("notes").doc(uid).update({"isDeleted": true});
    return BaseResponse();
  }
}
