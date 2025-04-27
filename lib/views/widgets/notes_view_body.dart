import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_space/cubits/read_notes_cubit/read_notes_cubit.dart';
import 'package:note_space/models/note_model.dart';
import 'package:note_space/theme.dart';
import 'package:note_space/views/search_note_view.dart';
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
    super.initState();
    // استرجاع الملاحظات عند تحميل الصفحة
    BlocProvider.of<ReadNotesCubit>(context).featchAllNotes();
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 16.0),
        child: Column(
          children: [
            const SizedBox(height: 44.0),
            // Custom AppBar with search icon
            CustomAppBar(
              icon: Icons.search,
              icon2: Icons.checklist,
              icon3: Icons.info_outline,
              title: 'Notes',
              onPressed: () {
                // عند الضغط على أيقونة البحث، افتح صفحة البحث وتمرير الملاحظات
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return BlocBuilder<ReadNotesCubit, ReadNotesState>(
                        builder: (context, state) {
                          List<NoteModel> readNotes =
                              BlocProvider.of<ReadNotesCubit>(context)
                                      .readNotes ??
                                  [];
                          return SearchNotesView(
                              allNotes: readNotes); // تمرير الملاحظات
                        },
                      );
                    },
                  ),
                );
              },
            ),
            const SizedBox(height: 8.0),
            // عرض قائمة الملاحظات
            const Expanded(child: NotesListView()),
          ],
        ),
      ),
    );
  }
}
