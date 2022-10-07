import 'package:flutter/material.dart';

import '../classes/note_class.dart';
import '../main.dart';
import '../screens/add_note.dart';
class NoteCard extends StatelessWidget {
  final NoteClass item;
  const NoteCard({
    Key? key,
    required this.item,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8), color: Colors.green[100]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  item.title,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
              ),
              Row(
                children: [
                  IconButton(
                      onPressed: () =>
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => AddNote(
                                    func: 'edit',
                                    editNote: item,
                                  ))),
                      icon: Icon(Icons.edit, size: 22)),
                  IconButton(
                      onPressed: () {
                        item.type = 2;
                        notes.eventSink.add(item);
                      },
                      icon: Icon(Icons.delete, size: 22))
                ],
              )
            ],
          ),
          Text(
            item.description,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
