import 'package:flutter/material.dart';
import 'package:note_space/models/note_model.dart'; // استيراد نموذج الملاحظة
import 'package:note_space/views/widgets/notes_item.dart';

class SearchNotesView extends StatefulWidget {
  const SearchNotesView({super.key, required this.allNotes});

  final List<NoteModel> allNotes;

  @override
  State<SearchNotesView> createState() => _SearchNotesViewState();
}

class _SearchNotesViewState extends State<SearchNotesView> {
  List<NoteModel> filteredNotes = [];
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    filteredNotes = widget.allNotes;
  }

  void updateSearch(String query) {
    setState(() {
      searchQuery = query;
      filteredNotes = widget.allNotes
          .where((note) =>
              note.title.toLowerCase().contains(query.toLowerCase()) ||
              note.content.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Notes'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              onChanged: updateSearch,
              decoration: InputDecoration(
                hintText: 'Search by title or content...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                filled: true,
                fillColor: Theme.of(context).cardColor,
              ),
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: filteredNotes.isEmpty
                  ? Center(
                      child: Image.asset(
                        'assets/images/cuate.png',
                      ),
                    )
                  : ListView.builder(
                      itemCount: filteredNotes.length,
                      itemBuilder: (context, index) {
                        return NotesItem(
                            note: filteredNotes[index],
                            onDelete: () {
                              setState(() {
                                filteredNotes.removeAt(index);
                              });
                            });
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
