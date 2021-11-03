import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:note_keeper_app/model/Note.dart';
import 'package:note_keeper_app/service/auth.dart';

class FireStorage {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  static CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  static CollectionReference notes =
      FirebaseFirestore.instance.collection('notes');

  static Future<void> addUser() {
    return users.add({
      'uid': getUID(),
      'email': getEmail(),
    }).catchError((error) {
      return error;
    });
  }

  static Future<void> addNote(Note note) {
    return notes.add({
      'title': note.title,
      'description': note.description,
      'date': note.date,
    }).catchError((error) {
      return error;
    });
  }

  static Stream<QuerySnapshot> getNotes() {
    final Stream<QuerySnapshot> notesStream =
        FirebaseFirestore.instance.collection('notes').snapshots();

    return notesStream;
  }
}
