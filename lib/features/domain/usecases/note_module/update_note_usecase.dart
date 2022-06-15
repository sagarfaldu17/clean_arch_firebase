import 'package:dartz/dartz.dart';
import 'package:sqflite_example/core/base/base_response.dart';
import 'package:sqflite_example/core/error/failures.dart';
import 'package:sqflite_example/core/usecases/usecase.dart';
import 'package:sqflite_example/features/data/model/note_request_model.dart';
import 'package:sqflite_example/features/domain/repositories/note_repository.dart';

class UpdateNote implements UpdateNoteUseCase<BaseResponse, void> {
  final NoteRepository noteRepository;

  UpdateNote({required this.noteRepository});

  @override
  Future<Either<Failure, BaseResponse>> call(
      NoteRequestModel noteRequestModel) {
    return noteRepository.updateNote(noteRequestModel);
  }
}
