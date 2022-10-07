// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:notesapp/screens/home.dart';

import 'bloc/notes_bloc.dart';

void main() {
  runApp(const MyApp());
}
final notes = NotesBloc();
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      title: 'NotesApp',
      theme: ThemeData(
        fontFamily: 'Poppins',
      ),
      home: HomeScreen(),
    );
  }
}

