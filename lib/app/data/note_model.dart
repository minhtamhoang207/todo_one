import 'package:hive/hive.dart';

part 'note_model.g.dart';

@HiveType(typeId: 0)
class Note extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  String content;

  @HiveField(2)
  bool isDone;

  @HiveField(3)
  DateTime date;

  @HiveField(4)
  String category;

  Note({
    required this.title,
    required this.content,
    required this.isDone,
    required this.date,
    required this.category,
  });
}