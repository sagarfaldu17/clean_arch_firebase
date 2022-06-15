part of 'note_list_bloc.dart';

@immutable
abstract class NoteListEvent {}

class GetNoteListEvent extends NoteListEvent {}

class AddNewNoteEvent extends NoteListEvent {
  AddNewNoteEvent(this.note);

  final NoteModel note;
}

class DeleteNoteEvent extends NoteListEvent {
  DeleteNoteEvent(this.noteRequestModel);

  final NoteRequestModel noteRequestModel;
}

class NoteListLoadingEvent extends NoteListEvent {}

class NoteListEmptyEvent extends NoteListEvent {}

class NoteListSuccessEvent extends NoteListEvent {}

class NoteListFailureEvent extends NoteListEvent {
  NoteListFailureEvent(this.message);

  final String? message;
}
