import 'package:hive/hive.dart';

part 'note.g.dart';

@HiveType(typeId: 1)
class Note {
  static String boxName = 'notes';

  @HiveField(0)
  String title;

  @HiveField(1)
  String description;

  @HiveField(2)
  String content;

  @HiveField(3)
  String type;

  @HiveField(4)
  bool favorite;

  Note({
    required this.title,
    required this.description,
    required this.content,
    required this.type,
    required this.favorite,
  });

  @override
  String toString() {
    return 'Note(title: $title, description: $description, content: $content, type: $type, favorite: $favorite)';
  }
}

enum NoteType {
  text,
  markdown,
  html,
}

extension NoteTypeExtension on NoteType {
  String get value {
    switch (this) {
      case NoteType.text:
        return "text";
      case NoteType.markdown:
        return "markdown";
      case NoteType.html:
        return "html";
      default:
        return "";
    }
  }
}
