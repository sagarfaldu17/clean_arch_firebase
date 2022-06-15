part of 'add_note_bloc.dart';

@immutable
abstract class AddNoteState {}

class AddNoteInitialState extends AddNoteState {}

class AddNoteLoadingState extends AddNoteState {}

class AddNoteSuccessState extends AddNoteState {}

class AddNoteFailureState extends AddNoteState {
  AddNoteFailureState(this.errorMessage);

  final String errorMessage;
}

class AddNoteSubmitState extends AddNoteState {}
