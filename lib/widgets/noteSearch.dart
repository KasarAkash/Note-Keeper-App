import 'package:NoteKeeperApp/models/note_model.dart';
import 'package:NoteKeeperApp/screens/note.detail.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../main.dart';
import 'NoteTile.dart';

class NoteSearch extends SearchDelegate<Note> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back_ios),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) => null;

  @override
  Widget buildSuggestions(BuildContext context) {
    Box<Note> box;
    box = Hive.box<Note>(boxName);
    List<int> keys;
    keys = box.keys
        .cast<int>()
        .where(
          (key) =>
              box.get(key).title.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();

    if (keys.isEmpty) {
      return Center(
        child: Text(
          "No Note Found",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: Colors.black54,
          ),
        ),
      );
    } else {
      return ListView.builder(
        itemCount: keys.length,
        itemBuilder: (context, index) {
          final int key = keys[index];
          final Note note = box.get(key);
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (BuildContext context) {
                  return NoteDetailScreen(
                    note: note,
                    appTitle: "Edit Note",
                    id: key,
                  );
                }),
              );
            },
            child: NoteTile(
              note: note,
              id: key,
            ),
          );
        },
      );
    }
  }
}
