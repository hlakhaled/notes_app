import 'package:flutter/material.dart';
import 'package:notes_app/core/theme/app_styles.dart';
import 'package:notes_app/features/notes/presentation/views/widgets/input_field.dart';
import 'package:notes_app/features/notes/presentation/views/widgets/primary_button.dart';
import '../../data/models/note.dart';

class CreateNoteScreen extends StatefulWidget {
  const CreateNoteScreen({
    super.key,
    required this.onSaveNote,
    required this.onViewNotes,
  });

  final ValueChanged<Note> onSaveNote;
  final void Function(BuildContext context) onViewNotes;

  @override
  State<CreateNoteScreen> createState() => _CreateNoteScreenState();
}

class _CreateNoteScreenState extends State<CreateNoteScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _saveNote() {
    final String title = _titleController.text.trim();
    final String content = _contentController.text.trim();

    if (title.isEmpty || content.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a title and content.')),
      );
      return;
    }

    widget.onSaveNote(
      Note(title: title, content: content, createdAt: DateTime.now()),
    );

    _titleController.clear();
    _contentController.clear();

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Note saved.')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 8),
              const Text(
                'Create Note',
                textAlign: TextAlign.center,
                style: AppStyles.screenTitle,
              ),
              const SizedBox(height: 28),
              const Text('Note Title', style: AppStyles.sectionLabel),
              const SizedBox(height: 8),
              NoteInputField(
                controller: _titleController,
                hintText: 'Enter note title',
                maxLines: 1,
              ),
              const SizedBox(height: 20),
              const Text('Content', style: AppStyles.sectionLabel),
              const SizedBox(height: 8),
              NoteInputField(
                controller: _contentController,
                hintText: 'Enter note content',
                maxLines: 6,
              ),
              Expanded(flex: 1, child: Container()),

              PrimaryButton(onPressed: _saveNote, label: 'Save Note'),
              const SizedBox(height: 18),
              TextButton(
                onPressed: () => widget.onViewNotes(context),
                child: const Text('View Notes', style: AppStyles.bodyText),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
