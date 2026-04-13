import 'package:flutter/material.dart';
import 'package:notes_app/core/theme/app_styles.dart';
import 'package:notes_app/features/notes/data/services/database_service.dart';
import 'package:notes_app/features/notes/presentation/views/notes_list_screen.dart';
import 'package:notes_app/features/notes/presentation/views/widgets/input_field.dart';
import 'package:notes_app/features/notes/presentation/views/widgets/primary_button.dart';

class CreateNoteScreen extends StatefulWidget {
  const CreateNoteScreen({super.key});

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

  void _saveNote() async {
    String title = _titleController.text.trim();
    String content = _contentController.text.trim();

    if (title.isNotEmpty && content.isNotEmpty) {
      try {
        DatabaseService dbService = DatabaseService();

        await dbService.addNote(title, content);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Note saved successfully!")),
        );
      } catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Error: $e")));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter both a title and content")),
      );
    }
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
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const NotesListScreen()),
                  );
                },
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
