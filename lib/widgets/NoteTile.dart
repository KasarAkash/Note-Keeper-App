import 'package:NoteKeeperApp/models/note_model.dart';
import 'package:NoteKeeperApp/themes/textStyle.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../main.dart';

class NoteTile extends StatefulWidget {
  final Note note;
  final int id;

  const NoteTile({Key key, this.note, this.id}) : super(key: key);
  @override
  _NoteTileState createState() => _NoteTileState();
}

class _NoteTileState extends State<NoteTile> {
  Box<Note> box;

  @override
  void initState() {
    box = Hive.box<Note>(boxName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 12.0,
      color: selectColor(widget.note.color),
      margin: EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(6),
          topLeft: Radius.circular(6),
          topRight: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 16.0),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.only(right: 12.0),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.insert_drive_file,
                    color: selectPriority(widget.note.priority),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    widget.note.title,
                    style: MyTextTheme.noteTitle,
                  ),
                  SizedBox(height: 10),
                  Text(
                    widget.note.description,
                    style: MyTextTheme.noteSubTitle,
                  ),
                  SizedBox(height: 20),
                  Text(
                    widget.note.date,
                    style: MyTextTheme.noteDateTitle,
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    box.delete(widget.id);
                    Scaffold.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "Note is Deleted",
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        duration: Duration(milliseconds: 700),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  selectColor(int index) {
    switch (index) {
      case 0:
        return Colors.lightBlueAccent;
        break;
      case 1:
        return Colors.tealAccent;
        break;
      case 2:
        return Colors.lime;
        break;
      case 3:
        return Colors.cyanAccent;
        break;
      case 4:
        return Colors.deepOrangeAccent;
        break;
      case 5:
        return Colors.indigoAccent;
        break;

      default:
        return Colors.white;
    }
  }

  selectPriority(String s) {
    switch (s) {
      case "High":
        return Colors.red;
        break;
      case "Medium":
        return Colors.orange;
        break;
      case "Low":
        return Colors.amber;
        break;
      default:
        return Colors.amber;
    }
  }
}
