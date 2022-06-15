import 'package:dartz/dartz.dart';
import 'package:sqflite_example/core/error/failures.dart';
import 'package:sqflite_example/features/data/model/note_model.dart';
import 'package:sqflite_example/features/data/model/note_request_model.dart';

abstract class GetNotesUseCase<BaseResponse, Params> {
  Future<Either<Failure, BaseResponse>> call();
}

abstract class AddNoteUseCase<BaseResponse, Params> {
  Future<Either<Failure, BaseResponse>> call(NoteModel noteModel);
}

abstract class DeleteNoteUseCase<BaseResponse, Params> {
  Future<Either<Failure, BaseResponse>> call(NoteRequestModel noteModel);
}

abstract class UpdateNoteUseCase<BaseResponse, Params> {
  Future<Either<Failure, BaseResponse>> call(NoteRequestModel noteModel);
}
