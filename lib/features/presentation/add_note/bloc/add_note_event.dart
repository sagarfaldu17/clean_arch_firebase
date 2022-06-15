part of 'add_note_bloc.dart';

@immutable
abstract class AddNoteEvent {}

class AddNoteInitialEvent extends AddNoteEvent {}

class AddNoteLoadingEvent extends AddNoteEvent {}

class AddNoteSuccessEvent extends AddNoteEvent {}

class AddNoteFailureEvent extends AddNoteEvent {
  final String message;

  AddNoteFailureEvent(this.message);
}

class AddNoteSubmitEvent extends AddNoteEvent {
  final NoteModel note;

  AddNoteSubmitEvent(this.note);
}
