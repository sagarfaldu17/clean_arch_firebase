import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sqflite_example/custom_painter.dart';
import 'package:sqflite_example/di/injector.dart';
import 'package:sqflite_example/features/presentation/add_note/bloc/add_note_bloc.dart';
import 'package:sqflite_example/features/presentation/home/bloc/note_list_bloc/note_list_bloc.dart';
import 'package:sqflite_example/features/presentation/home/pages/home_page.dart';

void main() async {
  await runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    await setUpLocator();
    await ScreenUtil.ensureScreenSize();

    runApp(const MyApp());
  }, (error, stack) {});
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => sl<NoteListBloc>()),
            BlocProvider(create: (context) => sl<AddNoteBloc>()),
          ],
          child: const MaterialApp(
            home: HomePage(),
          ),
        );
      },
    );
  }
}
