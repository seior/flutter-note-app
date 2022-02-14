import 'package:note_app/data/models/note.dart';

abstract class NoteRepository {
  save(Note note);

  update(Note note);

  delete(Note note);

  get(String id);
}
