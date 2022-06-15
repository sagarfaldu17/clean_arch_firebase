import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sqflite_example/core/error/failures.dart';
import 'package:sqflite_example/core/utils/constants.dart';
import 'package:sqflite_example/features/data/model/note_model.dart';
import 'package:sqflite_example/features/data/model/note_request_model.dart';
import 'package:sqflite_example/features/domain/usecases/note_module/delete_note_usecase.dart';
import 'package:sqflite_example/features/domain/usecases/note_module/get_note_usecase.dart';

part 'note_list_event.dart';

part 'note_list_state.dart';

class NoteListBloc extends Bloc<NoteListEvent, NoteListState> {
  final GetNotes getNotesUseCase;
  final DeleteNote deleteNoteUseCase;
  List<NoteModel> noteList = [];

  NoteListBloc(this.getNotesUseCase, this.deleteNoteUseCase)
      : super(NoteListInitialState()) {
    on<GetNoteListEvent>((event, emit) => _getNoteList());
    on<AddNewNoteEvent>((event, emit) => _addNewNote(event.note));
    on<NoteListLoadingEvent>((event, emit) => emit(NoteListLoadingState()));
    on<NoteListEmptyEvent>((event, emit) => emit(NoteListEmptyState()));
    on<NoteListSuccessEvent>((event, emit) => emit(NoteListSuccessState()));
    on<NoteListFailureEvent>((event, emit) => emit(NoteListFailureState()));
    on<DeleteNoteEvent>((event, emit) => _deleteNote(event.noteRequestModel));
  }

  _getNoteList() {
    try {
      add(NoteListLoadingEvent());
      getNotesUseCase().then((result) {
        result.fold((Failure left) {
          add(NoteListFailureEvent(getFailureMessage(left)));
        }, (right) {
          add(NoteListSuccessEvent());
          noteList = right.data;
          if (noteList.isEmpty) {
            add(NoteListEmptyEvent());
          }
        });
      });
    } catch (e) {
      add(NoteListFailureEvent(e.toString()));
    }
  }

  _addNewNote(NoteModel note) {
    Constants.listKey.currentState?.insertItem(noteList.length);
    add(NoteListLoadingEvent());
    noteList.add(note);
    add(NoteListSuccessEvent());
  }

  _deleteNote(NoteRequestModel noteRequestModel) {
    deleteNoteUseCase(noteRequestModel).then((result) {
      result.fold((Failure left) {
        add(NoteListFailureEvent(getFailureMessage(left)));
      }, (right) {
        noteList.removeWhere((element) => element.uid == noteRequestModel.uid);
        if (noteList.isEmpty) {
          add(NoteListEmptyEvent());
        }
      });
    });
  }
}
