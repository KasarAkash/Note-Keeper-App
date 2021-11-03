// ignore_for_file: file_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_keeper_app/model/Note.dart';

class NoteCard extends StatelessWidget {
  NoteCard({Key? key, required this.note}) : super(key: key);

  Note note;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.cyan,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Text(
              note.title,
              style: GoogleFonts.poppins(
                color: Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              note.date,
              style: GoogleFonts.poppins(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
