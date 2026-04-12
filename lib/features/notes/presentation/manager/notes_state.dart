import 'package:notes_app/features/notes/data/models/note.dart';

class NotesState {
  const NotesState({this.notes = const <Note>[]});

  final List<Note> notes;

  NotesState copyWith({List<Note>? notes}) {
    return NotesState(notes: notes ?? this.notes);
  }
}
