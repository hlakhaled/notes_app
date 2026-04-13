import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/features/notes/data/services/database_service.dart';
import 'package:notes_app/features/notes/presentation/manager/notes_cubit/notes_state.dart';

class NotesCubit extends Cubit<NotesState> {
  final DatabaseService _db;

  NotesCubit(this._db) : super(NotesInitial());

  StreamSubscription? _notesSub;

  void fetchNotes() {
    emit(NotesLoading());

    _notesSub = _db.getNotes().listen(
      (snapshot) {
        List<QueryDocumentSnapshot> notes = snapshot.docs;
        emit(NotesLoaded(notes));
      },
      onError: (error) => emit(NotesError(error.toString())),
    );
  }


  Future<void> addNote(String title, String content) async {
    try {
      await _db.addNote(title, content);
    } catch (e) {
      emit(NotesError(e.toString()));
    }
  }

  Future<void> updateNote(
      String id, String title, String content) async {
    try {
      await _db.updateNote(id, title, content);
    } catch (e) {
      emit(NotesError(e.toString()));
    }
  }

  Future<void> deleteNote(String id) async {
    try {
      await _db.deleteNote(id);
    } catch (e) {
      emit(NotesError(e.toString()));
    }
  }

  @override
  Future<void> close() {
    _notesSub?.cancel();
    return super.close();
  }
}