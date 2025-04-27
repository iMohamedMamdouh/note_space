import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_space/cubits/read_notes_cubit/read_notes_cubit.dart';
import 'package:note_space/models/note_model.dart';

class DeletedNotesScreen extends StatelessWidget {
  const DeletedNotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Deleted Notes')),
      body: BlocBuilder<ReadNotesCubit, ReadNotesState>(
        builder: (context, state) {
          List<NoteModel>? deletedNotes =
              BlocProvider.of<ReadNotesCubit>(context).deletedNotes;

          if (deletedNotes == null || deletedNotes.isEmpty) {
            return const Center(child: Text('No deleted notes.'));
          }

          return ListView.builder(
            itemCount: deletedNotes.length,
            itemBuilder: (context, index) {
              final note = deletedNotes[index];
              return ListTile(
                title: Text(note.title),
                subtitle: Text(note.content),
                trailing: IconButton(
                  icon: const Icon(Icons.restore),
                  onPressed: () {
                    BlocProvider.of<ReadNotesCubit>(context).restoreNote(note);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
