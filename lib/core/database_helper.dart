//TODO: Not in use - just for reference in case if we want to implement sqfLite database
// import 'dart:async';
// import 'dart:io';
// import 'package:sqflite/sqflite.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:sqflite_example/models/priority_util.dart';
// import 'package:sqflite_example/utils/logger.dart';
//
// class DatabaseHelper {
//   static final DatabaseHelper _singleton = DatabaseHelper._internal();
//
//   factory DatabaseHelper() {
//     return _singleton;
//   }
//
//   DatabaseHelper._internal();
//
//   static String noteTable = "note_table";
//   static String colId = "id";
//   static String colUid = "uid";
//   static String colTitle = "title";
//   static String colDescription = "description";
//   static String colPriority = "priority";
//   static String colDate = "date";
//   static String colIsDeleted = "isDeleted";
//   static int databaseVersion = 1;
//
//   static Database? database;
//
//   Future<Database> get getDatabase async {
//     if (database == null) {
//       return await initDatabase();
//     } else {
//       return database!;
//     }
//   }
//
//   Future<Database> initDatabase() async {
//     logger.d("Database service - init");
//     return await openDatabase(
//       await getPath(),
//       version: databaseVersion,
//       onCreate: _onCreate,
//     );
//   }
//
//   Future<String> getPath() async {
//     Directory documentDirectory = await getApplicationDocumentsDirectory();
//     return "${documentDirectory.path}notes.db";
//   }
//
//   void _onCreate(Database db, int newVersion) async {
//     await db.execute(
//         "CREATE TABLE $noteTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colUid TEXT,$colTitle TEXT, $colDescription TEXT, $colPriority INTEGER, $colDate TEXT, $colIsDeleted BOOLEAN)");
//   }
//
//   Future<List<Map<String, dynamic>>> getNoteMapList() async {
//     logger.d("Database service - get note list");
//     Database db = await getDatabase;
//     var result = await db.query(noteTable, orderBy: "$colPriority DESC");
//     return result;
//   }
//
//   Future<int> insertNote(Note note) async {
//     logger.d("Database service - insert note");
//     Database db = await getDatabase;
//     var result = await db.insert(noteTable, note.toMap());
//     return result;
//   }
//
//   Future<int> updateNote(Note note) async {
//     logger.d("Database service - update note");
//     Database db = await getDatabase;
//     var result = await db.update(noteTable, note.toMap(),
//         where: "$colId = ?", whereArgs: [note.id]);
//     return result;
//   }
//
//   Future<void> deleteNote(String uid) async {
//     logger.d("Database service - delete note");
//     Database db = await getDatabase;
//     await db.delete(noteTable, where: "uid = ?", whereArgs: [uid]);
//     // await db.rawDelete("DELETE FROM $noteTable WHERE $colUid = $uid");
//   }
//
//   Future<int> getNoteCounts() async {
//     logger.d("Database service - get note counts");
//     Database db = await getDatabase;
//     List<Map<String, dynamic>> notes =
//         await db.rawQuery("SELECT COUNT (*) from $noteTable");
//     return Sqflite.firstIntValue(notes) ?? 0;
//   }
// }
