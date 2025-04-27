import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_space/cubits/read_notes_cubit/read_notes_cubit.dart';
import 'package:note_space/theme.dart';
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
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 14),
              child: Row(children: [
                Icon(
                  Icons.info_outline,
                  size: 32,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Setting",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ]),
            ),
            ListTile(
              leading: const Icon(Icons.delete),
              title: const Text('Deleted Notes'),
              onTap: () {
                // Handle deleted notes action here
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              leading: const Icon(Icons.lock_outline_rounded),
              title: const Text('Change Password'),
              onTap: () {
                // Handle change password action here
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              leading: const Icon(Icons.light_mode),
              title: const Text('Light Mode'),
              onTap: () {
                // Toggle between dark and light theme
                if (themeNotifier.value == ThemeMode.dark) {
                  themeNotifier.value = ThemeMode.light;
                } else {
                  themeNotifier.value = ThemeMode.dark;
                }
                Navigator.pop(context); // Close the drawer
              },
            ),
          ],
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 16.0),
        child: Column(
          children: [
            SizedBox(height: 44.0),
            CustomAppBar(
              icon: Icons.checklist,
              icon2: Icons.search,
              icon3: Icons.info_outline,
              title: 'Notes',
            ),
            SizedBox(height: 8.0),
            Expanded(child: NotesListView()),
          ],
        ),
      ),
    );
  }
}
