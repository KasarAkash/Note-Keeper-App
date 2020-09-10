import 'package:NoteKeeperApp/models/note_model.dart';
import 'package:NoteKeeperApp/themes/textStyle.dart';
import 'package:flutter/material.dart';

class NoteTile extends StatefulWidget {
  final Note note;

  const NoteTile({Key key, this.note}) : super(key: key);
  @override
  _NoteTileState createState() => _NoteTileState();
}

class _NoteTileState extends State<NoteTile> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 12.0,
      color: widget.note.color,
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
                    color: Colors.amber,
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
                  onPressed: () {},
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
