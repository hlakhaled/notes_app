import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/features/notes/presentation/manager/notes_cubit.dart';
import 'package:notes_app/features/notes/presentation/manager/notes_state.dart';
import 'package:notes_app/features/notes/presentation/views/note_details_screen.dart';
import 'package:notes_app/features/notes/presentation/views/widgets/note_tile.dart';

class NotesListScreen extends StatelessWidget {
  const NotesListScreen({super.key});

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
          if (state.notes.isEmpty) {
            return const Center(child: Text('No notes found.'));
          }

          return ListView.separated(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
            itemCount: state.notes.length,
            separatorBuilder: (context, index) => const SizedBox(height: 18),
            itemBuilder: (context, index) {
              final note = state.notes[index];
              return NoteTile(
                note: note,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => NoteDetailsScreen(note: note),
                    ),
                  );
                },
                onDelete: () => context.read<NotesCubit>().deleteNote(note),
              );
            },
          );
        },
      ),
    );
  }
}
