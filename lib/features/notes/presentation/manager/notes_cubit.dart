import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/features/notes/data/models/note.dart';
import 'package:notes_app/features/notes/presentation/manager/notes_state.dart';

class NotesCubit extends Cubit<NotesState> {
  NotesCubit() : super(const NotesState());

  void addNote(Note note) {
    emit(state.copyWith(notes: <Note>[...state.notes, note]));
  }

  void deleteNote(Note note) {
    final List<Note> updatedNotes = List<Note>.of(state.notes)..remove(note);
    emit(state.copyWith(notes: updatedNotes));
  }
}
