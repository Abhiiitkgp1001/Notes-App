import 'dart:async';

import 'package:notesapp/classes/note_class.dart';

import '../db/notes_database.dart';

class NotesBloc {
  List<NoteClass> _notes = [];
  final _stateStreamController = StreamController<List<NoteClass>>();
  StreamSink<List<NoteClass>> get notesSink {
    return _stateStreamController.sink;
  }

  Stream<List<NoteClass>> get notesStream {
    return _stateStreamController.stream;
  }

  final _eventStreamController = StreamController<NoteClass>();
  StreamSink<NoteClass> get eventSink {
    return _eventStreamController.sink;
  }

  Stream<NoteClass> get eventStream {
    return _eventStreamController.stream;
  }

  Future<List<NoteClass>> getNotes() async {
    _notes = await NotesDatabase.instance.getData();
    return [..._notes];
  }

  NotesBloc() {
    eventStream.listen((event) async {
      if (event.type == 0) {
        print("ADD");

        NoteClass note = await NotesDatabase.instance.insertData(event);
        _notes.add(note);
      } else if (event.type == 1) {
        print("EDIT");
        for (int i = 0; i < _notes.length; i++) {
          if (_notes[i].id == event.id) {
            _notes[i].title = event.title;
            _notes[i].description = event.description;
            break;
          }
        }
        print(event.id);
        await NotesDatabase.instance.update(event);
      } else {
        print("DELETE");
        _notes.removeWhere((element) => element.id == event.id);
        await NotesDatabase.instance.delete(event);
      }
      notesSink.add(_notes);
    });
  }
}
