// ignore_for_file: file_names, prefer_const_literals_to_create_immutables, unused_field, avoid_print

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotePage extends StatefulWidget {
  const NotePage({Key? key}) : super(key: key);

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  final formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    titleController.addListener(_printLatestValue);
  }

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

  void _printLatestValue() {
    print('Second text field: ${titleController.text}');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xff252525),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            margin: const EdgeInsets.symmetric(vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white10,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    height: 50,
                    width: 50,
                    child: const Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white70,
                        size: 26,
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    //todo:
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white10,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    height: 50,
                    width: 100,
                    child: Center(
                      child: Text(
                        "Save",
                        style: GoogleFonts.poppins(
                          color: Colors.white70,
                          fontWeight: FontWeight.w500,
                          fontSize: 22,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                TextField(
                  controller: titleController,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  style: GoogleFonts.poppins(
                    color: Colors.white70,
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Title",
                    hintStyle: GoogleFonts.poppins(
                      color: Colors.grey,
                      fontSize: 30,
                      letterSpacing: 1,
                    ),
                  ),
                  cursorColor: Colors.grey,
                  cursorHeight: 40,
                ),
                TextField(
                  controller: descriptionController,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  style: GoogleFonts.poppins(
                    color: Colors.white70,
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Type Something...",
                    hintStyle: GoogleFonts.poppins(
                      color: Colors.grey,
                      fontSize: 22,
                      letterSpacing: 1,
                    ),
                  ),
                  cursorColor: Colors.grey,
                  cursorHeight: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
