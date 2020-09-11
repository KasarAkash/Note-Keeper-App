import 'package:NoteKeeperApp/models/note_model.dart';
import 'package:NoteKeeperApp/screens/note_list.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

const boxName = "NoteKeeperAppDB";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final doc = await getApplicationDocumentsDirectory();
  Hive.init(doc.path);
  Hive.registerAdapter(NoteAdapter());
  await Hive.openBox<Note>(boxName);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NoteKeepeerApp',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        canvasColor: Colors.white,
        primarySwatch: Colors.blue,
        appBarTheme: AppBarTheme(
          centerTitle: true,
          color: Colors.white,
          elevation: 0.0,
        ),
      ),
      home: NoteListScreen(),
    );
  }
}
