import 'package:dartz/dartz.dart';
import 'package:sqflite_example/core/base/base_response.dart';
import 'package:sqflite_example/core/error/failures.dart';
import 'package:sqflite_example/core/usecases/usecase.dart';
import 'package:sqflite_example/features/domain/repositories/note_repository.dart';

class GetNotes implements GetNotesUseCase<BaseResponse, void> {
  final NoteRepository noteRepository;

  GetNotes({required this.noteRepository});

  @override
  Future<Either<Failure, BaseResponse>> call() async {
    return await noteRepository.getNotes();
  }
}
