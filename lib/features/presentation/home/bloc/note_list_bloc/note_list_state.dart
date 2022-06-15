part of 'note_list_bloc.dart';

@immutable
abstract class NoteListState {}

class NoteListInitialState extends NoteListState {}

class NoteListLoadingState extends NoteListState {}

class NoteListSuccessState extends NoteListState {}

class NoteListFailureState extends NoteListState {}

class NoteListEmptyState extends NoteListState {}
