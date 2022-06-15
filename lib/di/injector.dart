import 'package:get_it/get_it.dart';
import 'package:sqflite_example/core/firebase/firebase_helper.dart';
import 'package:sqflite_example/features/data/datasource/note_datasource.dart';
import 'package:sqflite_example/features/data/repositories/note_repository_impl.dart';
import 'package:sqflite_example/features/domain/repositories/note_repository.dart';
import 'package:sqflite_example/features/presentation/add_note/bloc/add_note_bloc.dart';
import 'package:sqflite_example/features/presentation/home/bloc/note_list_bloc/note_list_bloc.dart';

import '../features/domain/usecases/note_module/add_note_usescase.dart';
import '../features/domain/usecases/note_module/delete_note_usecase.dart';
import '../features/domain/usecases/note_module/get_note_usecase.dart';
import '../features/domain/usecases/note_module/update_note_usecase.dart';

GetIt sl = GetIt.instance;

Future setUpLocator() async {
  sl.registerSingleton(FirebaseHelper());

  //Bloc
  sl.registerLazySingleton(() => NoteListBloc(sl(), sl()));
  sl.registerLazySingleton(() => AddNoteBloc(sl(), sl()));

  //UseCases
  sl.registerLazySingleton(() => GetNotes(noteRepository: sl()));
  sl.registerLazySingleton(() => AddNote(noteRepository: sl()));
  sl.registerLazySingleton(() => DeleteNote(noteRepository: sl()));
  sl.registerLazySingleton(() => UpdateNote(noteRepository: sl()));

  //Repositories
  sl.registerLazySingleton<NoteRepository>(() => NoteRepositoryImpl(sl()));

  //DataSources
  sl.registerLazySingleton<NoteDataSource>(() => NoteDatasourceImpl(sl()));
}
