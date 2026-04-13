import 'package:cloud_firestore/cloud_firestore.dart';

class Note {
  final String title;
  final String content;
  final DateTime createdAt;

  const Note({
    required this.title,
    required this.content,
    required this.createdAt,
  });


  factory Note.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    
    return Note(
      title: data['title'] ?? '',
      content: data['content'] ?? '',
      // Convert Timestamp to DateTime
      createdAt: (data['createdAt'] as Timestamp).toDate(), 
    );
  }
}