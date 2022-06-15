import 'package:dartz/dartz.dart';
import 'package:sqflite_example/core/base/base_response.dart';
import 'package:sqflite_example/core/error/failures.dart';
import 'package:sqflite_example/features/data/model/note_model.dart';
import 'package:sqflite_example/features/data/model/note_request_model.dart';

abstract class NoteRepository {
  Future<Either<Failure, BaseResponse>> getNotes();

  Future<Either<Failure, BaseResponse>> addNote(NoteModel noteModel);

  Future<Either<Failure, BaseResponse>> deleteNote(
      NoteRequestModel noteRequestModel);

  Future<Either<Failure, BaseResponse>> updateNote(
      NoteRequestModel noteRequestModel);
}
