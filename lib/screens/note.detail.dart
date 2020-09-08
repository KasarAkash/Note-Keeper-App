import 'package:flutter/material.dart';

class NoteDetailScreen extends StatefulWidget {
  final String title;

  const NoteDetailScreen({Key key, this.title}) : super(key: key);
  @override
  _NoteDetailScreenState createState() => _NoteDetailScreenState();
}

class _NoteDetailScreenState extends State<NoteDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title ?? "NoteDetail",
        ),
      ),
    );
  }
}
