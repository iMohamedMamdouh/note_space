import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_space/cubits/read_notes_cubit/read_notes_cubit.dart';
import 'package:note_space/models/note_model.dart';
import 'package:note_space/views/widgets/show_dialog_for_delete.dart';

class NotesListView extends StatelessWidget {
  const NotesListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReadNotesCubit, ReadNotesState>(
      builder: (context, state) {
        List<NoteModel> readNotes =
            BlocProvider.of<ReadNotesCubit>(context).readNotes ?? [];

        if (readNotes.isEmpty) {
          return const Center(child: Text('No notes available'));
        }

        readNotes = readNotes.reversed.toList();

        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Display two notes per row
            crossAxisSpacing: 16.0, // Space between boxes
            mainAxisSpacing: 16.0, // Space between rows
          ),
          itemCount: readNotes.length,
          itemBuilder: (context, index) {
            final note = readNotes[index];
            final isOnRight = index % 2 == 0; // Determines position of the note
            return ShowDialogForDelete(
              note: note,
              isOnRight: isOnRight,
            );
          },
        );
      },
    );
  }
}
