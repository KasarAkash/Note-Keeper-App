// ignore_for_file: non_constant_identifier_names, file_names

import 'package:flutter/material.dart';

class Note {
  late String title;
  late String description;
  late String date;
  Color color;

  Note({
    required this.description,
    required this.date,
    required this.title,
    required this.color,
  });
}
