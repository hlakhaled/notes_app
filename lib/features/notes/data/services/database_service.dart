import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String get currentUserId => _auth.currentUser!.uid;
  CollectionReference get _notesRef {
    String uid = _auth.currentUser!.uid;

    return _db.collection('users').doc(uid).collection('notes');
  }

  Future<void> addNote(String title, String content) async {
    try {
      await _notesRef.add({
        'title': title,
        'content': content,
        'createdAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      rethrow;
    }
  }

  Stream<QuerySnapshot> getNotes() {
    return _notesRef.orderBy('createdAt', descending: true).snapshots();
  }

  Future<void> updateNote(
    String noteId,
    String newTitle,
    String newContent,
  ) async {
    try {
      await _notesRef.doc(noteId).update({
        'title': newTitle,
        'content': newContent,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteNote(String noteId) async {
    try {
      await _notesRef.doc(noteId).delete();
    } catch (e) {
      rethrow;
    }
  }
}
