import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'note_model.g.dart';

@HiveType(typeId: 1)
class Note {
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String description;
  @HiveField(3)
  final String date;
  @HiveField(4)
  final String priority;
  @HiveField(5)
  final Color color;

  Note({
    this.title,
    this.description,
    this.date,
    this.priority,
    this.color,
  });
}
