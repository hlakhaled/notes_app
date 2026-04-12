import 'package:flutter/material.dart';
import 'package:notes_app/core/theme/app_color.dart';
import 'package:notes_app/core/theme/app_styles.dart';
import 'package:notes_app/features/Auth/presentation/views/login_screen.dart';
import 'package:notes_app/features/Auth/presentation/views/register_screen.dart';
import 'package:notes_app/features/notes/presentation/views/create_note_screen.dart';
import 'package:notes_app/features/notes/data/models/note.dart';
import 'package:notes_app/features/notes/presentation/views/note_details_screen.dart';
import 'package:notes_app/features/notes/presentation/views/notes_list_screen.dart';

void main() {
  runApp(const NotesApp());
}

class NotesApp extends StatefulWidget {
  const NotesApp({super.key});

  @override
  State<NotesApp> createState() => _NotesAppState();
}

class _NotesAppState extends State<NotesApp> {
  final List<Note> _notes = <Note>[
    Note(
      title: 'Meeting Notes',
      content:
          'The quick brown fox jumps over the lazy dog.\nThis is a sample note content to demonstrate how the text will be truncated after two lines.',
      createdAt: DateTime(2024, 7, 26, 14, 30),
    ),
    Note(
      title: 'Grocery List',
      content:
          'This is another example of note content. It\'s slightly shorter than the previous one but still enough to show multiple lines.',
      createdAt: DateTime(2024, 7, 24, 9, 15),
    ),
    Note(
      title: 'Quick Ideas',
      content:
          'Short note content. This note has a very brief content to show how it looks when the text is compact.',
      createdAt: DateTime(2024, 7, 22, 18, 5),
    ),
    Note(
      title: 'Project Updates',
      content:
          'This note has a bit more content, but it\'s still within the two-line limit. It\'s just enough to fill the preview.',
      createdAt: DateTime(2024, 7, 20, 11, 45),
    ),
    Note(
      title: 'Travel Plans',
      content:
          'Another long note content example. This one is designed to be truncated, showing only the first two lines in the list.',
      createdAt: DateTime(2024, 7, 18, 7, 0),
    ),
  ];

  void _addNote(Note note) {
    setState(() {
      _notes.insert(0, note);
    });
  }

  void _deleteNote(Note note) {
    setState(() {
      _notes.remove(note);
    });
  }

  void _openNotesList(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return NotesListScreen(
            notes: _notes,
            onDelete: _deleteNote,
            onOpenNote: (Note note) {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (BuildContext context) =>
                      NoteDetailsScreen(note: note),
                ),
              );
            },
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Notes App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColor.primarySeed,
          surface: AppColor.surface,
        ),
        scaffoldBackgroundColor: AppColor.surface,
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColor.surface,
          surfaceTintColor: AppColor.transparent,
          centerTitle: true,
          elevation: 0,
          titleTextStyle: AppStyles.appBarTitle,
          iconTheme: IconThemeData(color: AppColor.textPrimary),
        ),
      ),
      home: RegisterScreen(),
      // home: CreateNoteScreen(onSaveNote: _addNote, onViewNotes: _openNotesList),
    );
  }
}
