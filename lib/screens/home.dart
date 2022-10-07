// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:notesapp/bloc/notes_bloc.dart';
import 'package:notesapp/classes/note_class.dart';
import 'package:notesapp/db/notes_database.dart';
import 'package:notesapp/screens/add_note.dart';

import '../components/note_card.dart';
import '../main.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool loading = false;
  late Future<List<NoteClass>>? oldNotes;
  List<NoteClass>? dataList;
  @override
  void initState() {
    setState(() {
      oldNotes = notes.getNotes().then((value) {
        dataList = value;

        return value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: const [
            Text(
              'NotesApp',
              style: TextStyle(
                fontSize: 24,
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Icon(Icons.note_alt_outlined)
          ],
        ),
        backgroundColor: Colors.black,
      ),
      body: Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: FutureBuilder(
            future: oldNotes,
            builder: (context, AsyncSnapshot<List<NoteClass>> snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return Container();
              } else if (snapshot.hasError) {
                return Container();
              } else {
                return SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: StreamBuilder(
                          initialData: dataList,
                          stream: notes.notesStream,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              List<NoteClass> data =
                                  snapshot.data! as List<NoteClass>;
                              return ListView(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                children: data.map((item) {
                                  return Container(
                                    padding: data.indexOf(item) == 0 ? EdgeInsets.only(top: 24) : EdgeInsets.zero,
                                    child: NoteCard(
                                      item: item,
                                    ),
                                  );
                                }).toList(),
                              );
                            } else {
                              return Container();
                            }
                          }),
                );
              }
            }),),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          child: Icon(Icons.add),
          onPressed: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => AddNote(
                    func: 'add',
                  )))),
    );
  }
}
