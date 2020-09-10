import 'package:NoteKeeperApp/models/note_model.dart';
import 'package:NoteKeeperApp/screens/note.detail.dart';
import 'package:NoteKeeperApp/themes/textStyle.dart';
import 'package:NoteKeeperApp/widgets/NoteTile.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../main.dart';

class NoteListScreen extends StatefulWidget {
  @override
  _NoteListScreenState createState() => _NoteListScreenState();
}

class _NoteListScreenState extends State<NoteListScreen> {
  Note note;

  Box<Note> box;

  @override
  void initState() {
    box = Hive.box<Note>(boxName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "NoteKeeperApp",
          style: MyTextTheme.appTitle,
        ),
      ),
      body: ValueListenableBuilder(
        valueListenable: box.listenable(),
        builder: (BuildContext context, Box<Note> value, Widget child) {
          List<int> keys = value.keys.cast<int>().toList();
          return ListView.builder(
            itemCount: keys.length,
            itemBuilder: (context, index) {
              int key = keys[index];
              note = value.get(key);
              return NoteTile(
                note: note,
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 18.0,
        tooltip: "Add New Note",
        backgroundColor: Colors.greenAccent,
        child: Icon(
          Icons.create,
          color: Colors.black,
          size: 28.0,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) {
                return NoteDetailScreen(
                  title: "Create New Note",
                );
              },
            ),
          );
        },
      ),
    );
  }
}
