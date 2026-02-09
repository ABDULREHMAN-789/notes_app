import 'package:hive/hive.dart';
part 'note_model.g.dart';


@HiveType(typeId: 0)
class NoteModel extends HiveObject {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final String description;

  @HiveField(2)
  final String? imageUrl;

  @HiveField(3)
  final String category; // 'Idea', 'Buying', 'Goal', 'Guidance', 'Task'

  @HiveField(4)
  final List<String>? tags;

  @HiveField(5)
  final Map<String, bool>? checklist; // Task name aur uska status (done/not done)

  NoteModel({
    required this.title,
    required this.description,
    this.imageUrl,
    required this.category,
    this.tags,
    this.checklist,
  });
}