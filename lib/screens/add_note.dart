// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:notesapp/bloc/notes_bloc.dart';
import 'package:notesapp/classes/note_class.dart';
import 'package:notesapp/components/textfield.dart';

import '../main.dart';

class AddNote extends StatefulWidget {
  const AddNote({Key? key, required this.func, this.editNote})
      : super(key: key);
  final String func;
  final NoteClass? editNote;
  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  final title = TextEditingController();
  final description = TextEditingController();

  @override
  void initState() {
    if (widget.func == 'edit') {
      title.text = widget.editNote!.title;
      description.text = widget.editNote!.description;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.func == 'add' ? 'Add Note' : 'Edit Note',
            style: TextStyle(
              fontSize: 24,
            ),
          ),
          backgroundColor: Colors.black,
        ),
        body: Container(
          padding: EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Title",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              CustomTextfield(controller: title, title: "Enter title"),
              SizedBox(height: 24,),
              Text("Description",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              CustomTextfield(
                  controller: description, title: "Enter description"),
              SizedBox(height: 48,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: () {
    
                        NoteClass note = NoteClass(
                            title: title.text, description: description.text);
                        if (widget.func == 'edit') {
                          print(widget.editNote!.id);
                          note.type = 1;
                          note.id = widget.editNote!.id;
                        }
                        notes.eventSink.add(note);
                        Navigator.of(context).pop();
                      },
                      child: Text(widget.func == 'add' ? "Add" : 'Save',
                        style: TextStyle(
                          fontSize: 24,
                        ),
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
