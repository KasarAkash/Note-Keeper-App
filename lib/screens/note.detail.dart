import 'package:NoteKeeperApp/models/note_model.dart';
import 'package:NoteKeeperApp/themes/textStyle.dart';
import 'package:NoteKeeperApp/widgets/circle_dot.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

import '../main.dart';

class NoteDetailScreen extends StatefulWidget {
  final String title;

  const NoteDetailScreen({Key key, this.title}) : super(key: key);
  @override
  _NoteDetailScreenState createState() => _NoteDetailScreenState();
}

class _NoteDetailScreenState extends State<NoteDetailScreen> {
  String priority = "Low";
  TextEditingController titleText = TextEditingController();
  TextEditingController descriptionText = TextEditingController();
  int selectedIndex;

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
          widget.title ?? "NoteDetail",
          style: MyTextTheme.appTitle,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: ListView(
          children: <Widget>[
            Tooltip(
              message: "Set Priority of Note",
              child: ListTile(
                title: DropdownButton(
                  hint: Text("Set Priority of Note"),
                  items: ["High", "Medium", "Low"].map((String item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        style: MyTextTheme.dropDownTitle,
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      priority = value;
                    });
                  },
                  value: priority,
                ),
              ),
            ),
            SizedBox(height: 12),
            Row(
              children: <Widget>[
                CircleDot(
                  color: Colors.lightBlueAccent,
                  isSelected: selectedIndex == 0,
                  onTap: () {
                    onTapFunc(0);
                  },
                ),
                CircleDot(
                  color: Colors.tealAccent,
                  isSelected: selectedIndex == 1,
                  onTap: () {
                    onTapFunc(1);
                  },
                ),
                CircleDot(
                  color: Colors.lime,
                  isSelected: selectedIndex == 2,
                  onTap: () {
                    onTapFunc(2);
                  },
                ),
                CircleDot(
                  color: Colors.cyanAccent,
                  isSelected: selectedIndex == 3,
                  onTap: () {
                    onTapFunc(3);
                  },
                ),
                CircleDot(
                  color: Colors.deepOrangeAccent,
                  isSelected: selectedIndex == 4,
                  onTap: () {
                    onTapFunc(4);
                  },
                ),
                CircleDot(
                  color: Colors.indigoAccent,
                  isSelected: selectedIndex == 5,
                  onTap: () {
                    onTapFunc(5);
                  },
                ),
              ],
            ),
            SizedBox(height: 12),
            TextField(
              controller: titleText,
              decoration: InputDecoration(
                hintText: "Title",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            SizedBox(height: 10),
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
            SizedBox(height: 30),
            RaisedButton(
              child: Text(
                "SAVE",
                style: MyTextTheme.buttonTitle,
              ),
              color: Colors.greenAccent,
              elevation: 0,
              onPressed: () {
                setState(() {
                  Note value = Note(
                    title: titleText.text,
                    description: descriptionText.text,
                    priority: priority,
                    color: selectColor(selectedIndex),
                    date: DateFormat.yMMMd().format(DateTime.now()),
                  );
                  box.add(value);
                });
              },
            ),
            RaisedButton(
              child: Text(
                "REMOVE",
                style: MyTextTheme.buttonTitle,
              ),
              color: Colors.greenAccent,
              elevation: 0,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  onTapFunc(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  Color selectColor(int index) {
    switch (index) {
      case 0:
        Colors.lightBlueAccent;
        break;
      case 1:
        Colors.tealAccent;
        break;
      case 2:
        Colors.lime;
        break;
      case 3:
        Colors.cyanAccent;
        break;
      case 4:
        Colors.deepOrangeAccent;
        break;
      case 5:
        Colors.indigoAccent;
        break;

      default:
        Colors.transparent;
    }
  }

  Color selectPriority(String s) {
    switch (s) {
      case "High":
        Colors.redAccent;
        break;
      case "High":
        Colors.deepOrange;
        break;
      case "High":
        Colors.amber;
        break;
      default:
        Colors.amber;
    }
  }
}
