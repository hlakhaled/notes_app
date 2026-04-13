import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/core/theme/app_styles.dart';

class NoteDetailsScreen extends StatelessWidget {
  const NoteDetailsScreen({super.key, required this.note});

  final QueryDocumentSnapshot note;

  String _formatNoteDate(DateTime dateTime) {
    final String month = dateTime.month.toString().padLeft(2, '0');
    final String day = dateTime.day.toString().padLeft(2, '0');
    final String year = dateTime.year.toString();
    final String hour = dateTime.hour.toString().padLeft(2, '0');
    final String minute = dateTime.minute.toString().padLeft(2, '0');
    return '$month/$day/$year $hour:$minute';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text('Note Details'),
        actions: <Widget>[
          IconButton(onPressed: () {}, icon: const Icon(Icons.edit_outlined)),
          const SizedBox(width: 6),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(note["title"], style: AppStyles.noteDetailsTitle),
            const SizedBox(height: 16),
            Text(note["content"], style: AppStyles.noteDetailsBody),
            const SizedBox(height: 22),
            Text(
              'Created At: ${note["createdAt"] != null ? _formatNoteDate((note["createdAt"] as Timestamp).toDate()) : "Date not available"}',
              style: AppStyles.noteDetailsMeta,
            ),
          ],
        ),
      ),
    );
  }
}
