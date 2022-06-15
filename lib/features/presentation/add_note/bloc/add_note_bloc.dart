import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:sqflite_example/core/error/failures.dart';
import 'package:sqflite_example/features/data/model/note_model.dart';
import 'package:sqflite_example/features/domain/usecases/note_module/add_note_usescase.dart';
import 'package:sqflite_example/features/presentation/home/bloc/note_list_bloc/note_list_bloc.dart';

part 'add_note_event.dart';

part 'add_note_state.dart';

class AddNoteBloc extends Bloc<AddNoteEvent, AddNoteState> {
  final NoteListBloc noteListBloc;
  final AddNote addNote;

  AddNoteBloc(this.addNote, this.noteListBloc) : super(AddNoteInitialState()) {
    on<AddNoteInitialEvent>((event, emit) => emit(AddNoteInitialState()));
    on<AddNoteLoadingEvent>((event, emit) => emit(AddNoteLoadingState()));
    on<AddNoteFailureEvent>(
        (event, emit) => emit(AddNoteFailureState(event.message)));
    on<AddNoteSuccessEvent>((event, emit) => emit(AddNoteSuccessState()));
    on<AddNoteSubmitEvent>((event, emit) => _submitNote(event.note));
  }
}

extension SubmitNote on AddNoteBloc {
  _submitNote(NoteModel note) {
    try {
      add(AddNoteLoadingEvent());
      addNote(note).then((result) {
        result.fold((Failure left) {
          add(AddNoteFailureEvent(getFailureMessage(left)));
        }, (right) {
          noteListBloc.add(AddNewNoteEvent(note));
          add(AddNoteSuccessEvent());
        });
      });
    } catch (e) {
      add(AddNoteFailureEvent(e.toString()));
    }
  }
}
