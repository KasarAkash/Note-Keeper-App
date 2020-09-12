import 'package:hive/hive.dart';

part 'note_model.g.dart';

@HiveType(typeId: 1)
class Note {
  @HiveField(1)
  String title;

  @HiveField(2)
  String description;

  @HiveField(3)
  final String date;

  @HiveField(4)
  String priority;

  @HiveField(5)
  int color;

  Note({
    this.title,
    this.description,
    this.date,
    this.priority,
    this.color,
  });
}
