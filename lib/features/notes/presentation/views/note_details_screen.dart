import 'package:flutter/material.dart';
import 'package:notes_app/core/theme/app_styles.dart';
import '../../data/models/note.dart';

class NoteDetailsScreen extends StatelessWidget {
  const NoteDetailsScreen({super.key, required this.note});

  final Note note;

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
            Text(note.title, style: AppStyles.noteDetailsTitle),
            const SizedBox(height: 16),
            Text(note.content, style: AppStyles.noteDetailsBody),
            const SizedBox(height: 22),
            Text(
              'Created At: ${formatNoteDate(note.createdAt)}',
              style: AppStyles.noteDetailsMeta,
            ),
          ],
        ),
      ),
    );
  }
}
