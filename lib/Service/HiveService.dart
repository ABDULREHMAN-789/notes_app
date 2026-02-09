import 'package:hive/hive.dart';
import '../model/note_model.dart';

class HiveService {
  static const String boxName = 'notes_box';

  // Note save karne ke liye
  static Future<void> addNote(NoteModel note) async {
    var box = Hive.box<NoteModel>(boxName);
    await box.add(note);
  }

  // Saare notes hasil karne ke liye
  static List<NoteModel> getAllNotes() {
    var box = Hive.box<NoteModel>(boxName);
    return box.values.toList();
  }

  // Category ke hisaab se filter karne ke liye
  static List<NoteModel> getNotesByCategory(String category) {
    var box = Hive.box<NoteModel>(boxName);
    return box.values.where((note) => note.category == category).toList();
  }
}