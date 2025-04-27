import 'package:flutter/material.dart';
import 'package:hive/hive.dart'; // Import Hive package
import 'package:note_space/models/note_model.dart'; // Import the NoteModel

class DeletedNotesScreen extends StatefulWidget {
  const DeletedNotesScreen({super.key});

  @override
  _DeletedNotesScreenState createState() => _DeletedNotesScreenState();
}

class _DeletedNotesScreenState extends State<DeletedNotesScreen> {
  List<NoteModel> deletedNotes = []; // Store deleted notes

  @override
  void initState() {
    super.initState();
    // Fetch deleted notes from Hive or from your local storage mechanism
    _fetchDeletedNotes();
  }

  // Fetch deleted notes (assuming they are stored somewhere, like in a Hive box)
  void _fetchDeletedNotes() {
    var box = Hive.box<NoteModel>(
        'deletedNotesBox'); // Assume you store deleted notes in a 'deletedNotesBox'
    setState(() {
      deletedNotes =
          box.values.toList(); // Fetch deleted notes from the Hive box
    });
  }

  // Restore a deleted note
  void _restoreNote(NoteModel note) {
    var notesBox = Hive.box<NoteModel>('notesBox'); // Box for active notes
    var deletedNotesBox =
        Hive.box<NoteModel>('deletedNotesBox'); // Box for deleted notes

    // Add the note back to the notes box and remove from deleted notes box
    notesBox.add(note);
    deletedNotesBox.delete(note.key);

    setState(() {
      deletedNotes.remove(
          note); // Remove the note from the list of deleted notes in the UI
    });

    // Optionally show a success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${note.title} restored')),
    );
  }

  // Delete permanently
  void _deletePermanently(NoteModel note) {
    var deletedNotesBox = Hive.box<NoteModel>('deletedNotesBox');

    // Permanently delete the note from the Hive box
    deletedNotesBox.delete(note.key);

    setState(() {
      deletedNotes.remove(
          note); // Remove the note from the list of deleted notes in the UI
    });

    // Optionally show a success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${note.title} permanently deleted')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Deleted Notes',
            style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.deepPurple,
      ),
      body: deletedNotes.isEmpty
          ? const Center(
              child: Text('No deleted notes found',
                  style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic)))
          : ListView.builder(
              itemCount: deletedNotes.length,
              itemBuilder: (context, index) {
                final note = deletedNotes[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    color: Colors.grey[850],
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
                                  note.content ?? 'No description available',
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
                          const SizedBox(width: 16.0),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Restore button
                              ElevatedButton.icon(
                                icon: const Icon(Icons.restore,
                                    color: Colors.white),
                                label: const Text('Restore',
                                    style: TextStyle(color: Colors.white)),
                                onPressed: () {
                                  _restoreNote(note); // Restore the note
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 8),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              // Permanently delete button
                              ElevatedButton.icon(
                                icon: const Icon(Icons.delete_forever,
                                    color: Colors.white),
                                label: const Text('Delete Forever',
                                    style: TextStyle(color: Colors.white)),
                                onPressed: () {
                                  _deletePermanently(
                                      note); // Permanently delete the note
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 8),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
