import 'package:NoteKeeperApp/models/note_model.dart';
import 'package:NoteKeeperApp/themes/textStyle.dart';
import 'package:NoteKeeperApp/widgets/circle_dot.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

import '../main.dart';

class NoteDetailScreen extends StatefulWidget {
  final String appTitle;
  Note note;

  final int id;
  NoteDetailScreen({
    Key key,
    this.appTitle,
    this.note,
    this.id,
  }) : super(key: key);
  @override
  _NoteDetailScreenState createState() => _NoteDetailScreenState();
}

class _NoteDetailScreenState extends State<NoteDetailScreen> {
  String priority = "Low";

  TextEditingController titleText;
  TextEditingController descriptionText;

  int selectedIndex = 0;

  Box<Note> box;

  @override
  void initState() {
    super.initState();

    box = Hive.box<Note>(boxName);
    titleText = TextEditingController(text: widget.note.title ?? "");
    descriptionText =
        TextEditingController(text: widget.note.description ?? "");
  }

  @override
  Widget build(BuildContext context) {
    if (widget.id != null) {
      widget.note = box.get(widget.id);

      priority = widget.note.priority;
      selectedIndex = widget.note.color;
    }
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          widget.appTitle ?? "NoteDetail",
          style: MyTextTheme.appTitle,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: ListView(
          children: <Widget>[
            SizedBox(height: 10),
            Tooltip(
              message: "Set Priority of Note",
              child: ListTile(
                title: DropdownButton(
                  hint: Text("Set Priority of Note"),
                  items: ["High", "Medium", "Low"].map((String item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Text(item, style: MyTextTheme.dropDownTitle),
                    );
                  }).toList(),
                  onChanged: (String value) {
                    setState(() {
                      if (widget.note.priority == null) {
                        priority = value;
                      } else {
                        widget.note.priority = value;
                      }
                    });
                  },
                  value: priority,
                ),
              ),
            ),
            SizedBox(height: 18),
            SizedBox(
              height: 50,
              child: ListView(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  CircleDot(
                    color: Colors.lightBlueAccent,
                    isSelected: selectedIndex == 0,
                    onTap: () {
                      onTapFunc(0);
                    },
                  ),
                  CircleDot(
                    color: Colors.greenAccent,
                    isSelected: selectedIndex == 1,
                    onTap: () {
                      onTapFunc(1);
                    },
                  ),
                  CircleDot(
                    color: Colors.amberAccent,
                    isSelected: selectedIndex == 2,
                    onTap: () {
                      onTapFunc(2);
                    },
                  ),
                  CircleDot(
                    color: Colors.lime,
                    isSelected: selectedIndex == 3,
                    onTap: () {
                      onTapFunc(3);
                    },
                  ),
                  CircleDot(
                    color: Colors.cyanAccent,
                    isSelected: selectedIndex == 4,
                    onTap: () {
                      onTapFunc(4);
                    },
                  ),
                  CircleDot(
                    color: Colors.deepOrangeAccent[200],
                    isSelected: selectedIndex == 5,
                    onTap: () {
                      onTapFunc(5);
                    },
                  ),
                  CircleDot(
                    color: Colors.pinkAccent,
                    isSelected: selectedIndex == 6,
                    onTap: () {
                      onTapFunc(6);
                    },
                  ),
                  CircleDot(
                    color: Colors.purpleAccent,
                    isSelected: selectedIndex == 7,
                    onTap: () {
                      onTapFunc(7);
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 18),
            TextField(
              controller: titleText,
              decoration: InputDecoration(
                hintText: "Title",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            SizedBox(height: 12),
            TextField(
              controller: descriptionText,
              maxLines: 7,
              decoration: InputDecoration(
                hintText: "Description",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            SizedBox(height: 40),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: RaisedButton(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Text(
                        "SAVE",
                        style: MyTextTheme.buttonTitle,
                      ),
                    ),
                    color: Colors.blue,
                    elevation: 0,
                    onPressed: () {
                      Note value = Note(
                        title: titleText.text,

                        description: descriptionText.text,

                        priority: priority,

                        color: selectedIndex,
                        //don't touch
                        date: DateFormat.yMMMd().format(DateTime.now()),
                      );

                      if (widget.id == null) {
                        box.add(value);
                      } else {
                        box.put(widget.id, value);
                      }

                      Navigator.pop(context);
                    },
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  flex: 1,
                  child: RaisedButton(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Text(
                        "REMOVE",
                        style: MyTextTheme.buttonTitle,
                      ),
                    ),
                    color: Colors.blue,
                    elevation: 0,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  onTapFunc(int index) {
    setState(() {
      selectedIndex = index;
      widget.note.color = selectedIndex;
    });
  }
}
