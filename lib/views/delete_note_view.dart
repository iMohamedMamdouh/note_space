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
              return Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      note.title,
                                      style: const TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(height: 6.0),
                                    Text(
                                      note.content ??
                                          'No description available',
                                      style: const TextStyle(
                                        fontSize: 14.0,
                                        color: Colors.white70,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.restore),
                                onPressed: () {
                                  BlocProvider.of<ReadNotesCubit>(context)
                                      .restoreNote(note);
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
