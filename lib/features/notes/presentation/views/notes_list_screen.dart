import 'package:flutter/material.dart';
import 'package:notes_app/features/notes/presentation/views/widgets/note_tile.dart';
import '../../data/models/note.dart';

class NotesListScreen extends StatefulWidget {
  const NotesListScreen({
    super.key,
    required this.notes,
    required this.onDelete,
    required this.onOpenNote,
  });

  final List<Note> notes;
  final ValueChanged<Note> onDelete;
  final ValueChanged<Note> onOpenNote;

  @override
  State<NotesListScreen> createState() => _NotesListScreenState();
}

class _NotesListScreenState extends State<NotesListScreen> {
  late List<Note> _notes;

  @override
  void initState() {
    super.initState();
    _notes = List<Note>.of(widget.notes);
  }

  void _deleteNote(Note note) {
    setState(() {
      _notes.remove(note);
    });
    widget.onDelete(note);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text('Notes List'),
      ),
      body: _notes.isEmpty
          ? const Center(child: Text('No notes found.'))
          : ListView.separated(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
              itemCount: _notes.length,
              separatorBuilder: (context, index) => const SizedBox(height: 18),
              itemBuilder: (context, index) {
                final note = _notes[index];
                return NoteTile(
                  note: note,
                  onTap: () => widget.onOpenNote(note),
                  onDelete: () => _deleteNote(note),
                );
              },
            ),
    );
  }
}