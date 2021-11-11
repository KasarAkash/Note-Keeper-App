import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:note_keeper_app/model/Note.dart';
import 'package:note_keeper_app/service/auth.dart';

class FireStorage {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  static CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  static CollectionReference notes = FirebaseFirestore.instance
      .collection('notes')
      .doc(getEmail())
      .collection("myNotes");

  static Future<void> addNote(Note note) {
    return notes.add({
      'title': note.title,
      'description': note.description,
      'date': note.date,
    }).catchError((error) {
      return error;
    });
  }

  static Future<void> deleteNote(String id) async {
    return await notes.doc(id).delete();
  }

  static Stream<QuerySnapshot> getNotes() {
    final Stream<QuerySnapshot> notesStream = notes.snapshots();

    return notesStream;
  }

  static getSearchedNotes(String string) {
    try {
      return notes.where('title', isEqualTo: string).get().asStream();
    } catch (e) {
      return e;
    }
  }
}
