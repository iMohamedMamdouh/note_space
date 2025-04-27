import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_space/cubits/read_notes_cubit/read_notes_cubit.dart';
import 'package:note_space/models/note_model.dart';
import 'package:note_space/views/widgets/notes_item.dart';

class ShowDialogForDelete extends StatelessWidget {
  const ShowDialogForDelete({
    super.key,
    required this.note,
    required this.isOnRight,
  });

  final NoteModel note;
  final bool isOnRight;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(note.id),
      direction:
          isOnRight ? DismissDirection.endToStart : DismissDirection.startToEnd,
      confirmDismiss: (direction) async {
        if (isOnRight && direction == DismissDirection.endToStart ||
            !isOnRight && direction == DismissDirection.startToEnd) {
          return await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: Colors.grey.shade900,
                title: const Icon(
                  Icons.info_outline,
                  size: 32,
                ),
                content:
                    const Text("Are you sure you want to delete this note?"),
                actions: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey.shade800,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () => Navigator.of(context).pop(false),
                        child: const Text("Cancel"),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () => Navigator.of(context).pop(true),
                        child: const Text("Delete"),
                      ),
                    ],
                  ),
                ],
              );
            },
          );
        }
        return false;
      },
      onDismissed: (direction) {
        if (direction == DismissDirection.endToStart ||
            direction == DismissDirection.startToEnd) {
          BlocProvider.of<ReadNotesCubit>(context).deleteNote(note);

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('${note.title} deleted')),
          );
        }
      },
      background: Container(
        decoration: const BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.all(
            Radius.circular(16),
          ),
        ),
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 36,
        ),
      ),
      child: NotesItem(note: note, onDelete: () {}),
    );
  }
}
