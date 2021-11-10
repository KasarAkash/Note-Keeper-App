// ignore_for_file: file_names

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_keeper_app/Screens/NoteDetail.dart';
import 'package:note_keeper_app/Screens/NotePage.dart';
import 'package:note_keeper_app/Widgets/NoteCard.dart';
import 'package:note_keeper_app/model/Note.dart';
import 'package:note_keeper_app/service/firestore.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isSearching = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff252525),
      appBar: AppBar(
        toolbarHeight: 80,
        elevation: 0,
        backgroundColor: const Color(0xff252525),
        title: Text(
          "Notes",
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          InkWell(
            onTap: () {
              setState(() {
                isSearching = !isSearching;
              });
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white10,
                borderRadius: BorderRadius.circular(10),
              ),
              height: 30,
              width: 50,
              margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              padding: const EdgeInsets.all(8),
              child: isSearching
                  ? const Icon(
                      Icons.clear,
                      color: Colors.white,
                      size: 30,
                    )
                  : const Icon(
                      Icons.search,
                      color: Colors.white,
                      size: 30,
                    ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add new Note',
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => const NotePage(),
            ),
          );
        },
        backgroundColor: const Color(0xff252525),
        child: const Icon(
          Icons.create,
          size: 30,
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            isSearching
                ? Container(
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white10,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextField(
                      // controller: searchController,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      enableInteractiveSelection: true,
                      enableSuggestions: true,
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Search by title",
                        hintStyle: GoogleFonts.poppins(
                          color: Colors.grey,
                          fontSize: 20,
                          letterSpacing: 1,
                        ),
                      ),
                      cursorColor: Colors.grey,
                      cursorHeight: 30,
                    ),
                  )
                : const SizedBox(),
            StreamBuilder<QuerySnapshot>(
              stream: FireStorage.getNotes(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Text("Loading");
                }

                List<Note> notes =
                    snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;

                  Note note = Note(
                    title: data['title'],
                    description: data['description'],
                    date: data['date'],
                  );

                  return note;
                }).toList();

                return StaggeredGridView.countBuilder(
                  physics: const BouncingScrollPhysics(),
                  mainAxisSpacing: 4.0,
                  crossAxisSpacing: 4.0,
                  crossAxisCount: 4,
                  itemCount: notes.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        String docid = snapshot.data!.docs[index].id;

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => NoteDetail(
                              note: notes[index],
                              docid: docid,
                            ),
                          ),
                        );
                      },
                      child: NoteCard(
                        note: notes[index],
                        color: Colors.primaries[
                            Random().nextInt(Colors.primaries.length)],
                      ),
                    );
                  },
                  staggeredTileBuilder: (int index) =>
                      const StaggeredTile.fit(2),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
