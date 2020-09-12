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

enum NoteFilter { All, High, Medium, Low }

class _NoteListScreenState extends State<NoteListScreen> {
  Box<Note> box;
  NoteFilter filter = NoteFilter.All;

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
        actions: [
          PopupMenuButton<String>(
            tooltip: "Filter by Priority",
            itemBuilder: (context) {
              return ["All", "High", "Medium", "Low"].map((option) {
                return PopupMenuItem(
                  child: Padding(
                    padding: EdgeInsets.only(right: 20),
                    child: Text(
                      option,
                      style: MyTextTheme.popButtonTitle,
                    ),
                  ),
                  value: option,
                );
              }).toList();
            },
            onSelected: (value) {
              if (value.compareTo("All") == 0) {
                setState(() {
                  filter = NoteFilter.All;
                });
              } else if (value.compareTo("High") == 0) {
                setState(() {
                  filter = NoteFilter.High;
                });
              } else if (value.compareTo("Medium") == 0) {
                setState(() {
                  filter = NoteFilter.Medium;
                });
              } else {
                setState(() {
                  filter = NoteFilter.Low;
                });
              }
            },
          )
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: box.listenable(),
        builder: (BuildContext context, Box<Note> value, Widget child) {
          List<int> keys;
          if (filter == NoteFilter.All) {
            keys = value.keys.cast<int>().toList();
          } else if (filter == NoteFilter.High) {
            keys = value.keys
                .cast<int>()
                .where((key) => value.get(key).priority == "High")
                .toList();
          } else if (filter == NoteFilter.Medium) {
            keys = value.keys
                .cast<int>()
                .where((key) => value.get(key).priority == "Medium")
                .toList();
          } else {
            keys = value.keys
                .cast<int>()
                .where((key) => value.get(key).priority == "Low")
                .toList();
          }
          return ListView.builder(
            itemCount: keys.length,
            itemBuilder: (context, index) {
              final int key = keys[index];
              final Note note = value.get(key);
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
        },
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 18.0,
        tooltip: "Add New Note",
        child: Icon(
          Icons.create,
          color: Colors.white,
          size: 28.0,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) {
                return NoteDetailScreen(
                  appTitle: "Create New Note",
                  note: Note(),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
