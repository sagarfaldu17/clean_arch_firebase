import 'package:dartz/dartz.dart';
import 'package:sqflite_example/core/base/base_response.dart';
import 'package:sqflite_example/core/base/response_wrapper.dart';
import 'package:sqflite_example/core/error/failures.dart';
import 'package:sqflite_example/features/data/datasource/note_datasource.dart';
import 'package:sqflite_example/features/data/model/note_model.dart';
import 'package:sqflite_example/features/data/model/note_request_model.dart';
import 'package:sqflite_example/features/domain/repositories/note_repository.dart';

class NoteRepositoryImpl implements NoteRepository {
  final NoteDataSource noteDataSource;

  NoteRepositoryImpl(this.noteDataSource);

  @override
  Future<Either<Failure, BaseResponse>> addNote(NoteModel noteModel) async {
    try {
      ResponseWrapper<BaseResponse> baseResponse =
          await noteDataSource.addNote(noteModel);
      if (baseResponse.hasException) {
        return left(ServerFailure(message: baseResponse.getException.message));
      } else {
        return right(baseResponse.getData);
      }
    } catch (e) {
      return left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, BaseResponse>> deleteNote(
      NoteRequestModel noteRequestModel) async {
    try {
      ResponseWrapper<BaseResponse> baseResponse =
          await noteDataSource.deleteNote(noteRequestModel);
      if (baseResponse.hasException) {
        return left(ServerFailure(message: baseResponse.getException.message));
      } else {
        return right(baseResponse.getData);
      }
    } catch (e) {
      return left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, BaseResponse>> getNotes() async {
    try {
      ResponseWrapper<BaseResponse> baseResponse =
          await noteDataSource.getNotes();
      if (baseResponse.hasException) {
        return left(ServerFailure(message: baseResponse.getException.message));
      } else {
        return right(baseResponse.getData);
      }
    } catch (e) {
      return left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, BaseResponse>> updateNote(
      NoteRequestModel noteRequestModel) {
    // TODO: implement updateNote
    throw UnimplementedError();
  }
}
