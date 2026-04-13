import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/features/notes/presentation/manager/notes_cubit/notes_cubit.dart';
import 'package:notes_app/features/notes/presentation/manager/notes_cubit/notes_state.dart';
import 'package:notes_app/features/notes/presentation/views/note_details_screen.dart';
import 'package:notes_app/features/notes/presentation/views/widgets/note_tile.dart';

class NotesListScreen extends StatefulWidget {
  const NotesListScreen({super.key});

  @override
  State<NotesListScreen> createState() => _NotesListScreenState();
}

class _NotesListScreenState extends State<NotesListScreen> {
  @override
  void initState() {
    super.initState();
    context.read<NotesCubit>().fetchNotes();
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

      body: BlocBuilder<NotesCubit, NotesState>(
        builder: (context, state) {
          if (state is NotesLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is NotesError) {
            return Center(child: Text(state.message));
          }

          if (state is NotesLoaded) {
            final notes = state.notes;

            if (notes.isEmpty) {
              return const Center(child: Text("No notes yet"));
            }

            return ListView.separated(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
              itemCount: notes.length,
              separatorBuilder: (context, index) => const SizedBox(height: 18),
              itemBuilder: (context, index) {
                final note = notes[index];

                return NoteTile(
                  note: note,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => NoteDetailsScreen(note: note),
                      ),
                    );
                  },
                  onDelete: () {
                    context.read<NotesCubit>().deleteNote(note.id);
                  },
                );
              },
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
