import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:note_space/models/note_model.dart';

import '../../constants.dart';

part 'read_notes_state.dart';

class ReadNotesCubit extends Cubit<ReadNotesState> {
  ReadNotesCubit() : super(ReadNotesInitial());

  List<NoteModel>? readNotes;
  List<NoteModel>? deletedNotes = []; // List to store deleted notes

  // Fetch all notes
  void featchAllNotes() {
    var notesBox = Hive.box<NoteModel>(kNotesBox);
    readNotes = notesBox.values.toList();
    emit(ReadNotesSuccess());
  }

  // Delete a note (Move to deleted notes)
  void deleteNote(NoteModel note) {
    var notesBox = Hive.box<NoteModel>(kNotesBox);

    // Safely delete note and update state
    deletedNotes?.add(note); // Add note to deleted notes
    note.delete(); // Delete the note from Hive

    readNotes?.remove(note); // Remove from the active notes list
    emit(ReadNotesUpdated(readNotes: readNotes ?? []));
  }

  // Restore a deleted note
  void restoreNote(NoteModel note) {
    var notesBox = Hive.box<NoteModel>(kNotesBox);

    deletedNotes?.remove(note); // نحذف النوتة من قائمة المحذوفات
    notesBox.add(note); // نرجع النوتة إلى الـ Hive

    emit(ReadNotesDeletedSuccess()); // نبعث حالة جديدة عشان الشاشة تعمل Rebuild
  }

  // Fetch deleted notes
  void fetchDeletedNotes() {
    emit(ReadNotesDeletedSuccess());
  }
}
