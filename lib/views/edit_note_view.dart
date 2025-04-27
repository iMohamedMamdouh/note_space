import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_space/cubits/read_notes_cubit/read_notes_cubit.dart';
import 'package:note_space/models/note_model.dart';
import 'package:note_space/views/widgets/custom_app_bar.dart';

class EditNoteView extends StatefulWidget {
  final NoteModel note;

  const EditNoteView({super.key, required this.note});

  @override
  _EditNoteViewState createState() => _EditNoteViewState();
}

class _EditNoteViewState extends State<EditNoteView> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note.title);
    _contentController = TextEditingController(text: widget.note.content);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 44.0),
            CustomAppBar(
              onPressed: () {
                widget.note.title = _titleController.text;
                widget.note.content = _contentController.text;
                widget.note.save();

                BlocProvider.of<ReadNotesCubit>(context).featchAllNotes();

                Navigator.pop(context);
              },
              icon2: Icons.check,
              title: 'Edit Note',
            ),
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding:
                    EdgeInsets.zero, // Reduce padding inside the TextField
              ),
              style: const TextStyle(
                fontSize: 28.0,
              ),
            ),
            TextField(
              controller: _contentController,
              decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding:
                    EdgeInsets.zero, // Reduce padding inside the TextField
              ),
              maxLines: null,
              keyboardType: TextInputType.multiline,
            ),
          ],
        ),
      ),
    );
  }
}
