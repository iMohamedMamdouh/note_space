import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_space/cubits/read_notes_cubit/read_notes_cubit.dart';
import 'package:note_space/views/widgets/custom_app_bar.dart';
import 'package:note_space/views/widgets/notes_list_view.dart';

class NotesViewBody extends StatefulWidget {
  const NotesViewBody({super.key});

  @override
  State<NotesViewBody> createState() => _NotesViewBodyState();
}

class _NotesViewBodyState extends State<NotesViewBody> {
  @override
  void initState() {
    BlocProvider.of<ReadNotesCubit>(context).featchAllNotes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 16.0),
      child: Column(
        children: [
          SizedBox(height: 44.0),
          CustomAppBar(
            icon: Icons.search,
            icon2: Icons.info_outline,
            title: 'Notes',
          ),
          SizedBox(height: 8.0),
          Expanded(child: NotesListView()),
        ],
      ),
    );
  }
}
