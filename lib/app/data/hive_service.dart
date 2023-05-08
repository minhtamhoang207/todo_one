import 'package:get/get.dart';
import 'package:hive/hive.dart';

import 'note_model.dart';

class HiveService {

  final Box<Note> box;
  HiveService({required this.box});

  Future<int> add(Note note) async {
    return await box.add(note);
  }

  Future<void> update(Note note) async {
    await box.put(note.key, note);
  }

  Future<void> delete(Note note) async {
    final box = Get.find<Box<Note>>();
    await box.delete(note.key);
  }

  Future<List<Note>> getAll() async {
    return box.values.toList().cast<Note>();
  }

  Future<List<Note>> getByStatus(bool isDone) async {
    final notes = box.values.toList().cast<Note>();
    return notes.where((note) => note.isDone == isDone).toList();
  }

  Future<List<Note>> getByDate(DateTime date) async {
    final notes = box.values.toList().cast<Note>();
    return notes.where((note) => note.date == date).toList();
  }

  void changeNoteStatus(int noteId, bool isDone) {
    Note? note = box.get(noteId);
    note!.isDone = isDone;
    box.put(noteId, note);
  }

  void changeAllNoteStatus(bool isDone) async {

    final notes = box.values.toList();

    for (final note in notes) {
      note.isDone = isDone;
    }

    final updatedNotes = { for (var note in notes) note.key : note };

    await box.putAll(updatedNotes);
  }

  Future<void> closeBox() async {
    await box.close();
  }
}