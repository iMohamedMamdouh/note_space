part of 'read_notes_cubit.dart';

@immutable
sealed class ReadNotesState {}

final class ReadNotesInitial extends ReadNotesState {}

final class ReadNotesSuccess extends ReadNotesState {}

class ReadNotesUpdated extends ReadNotesState {
  final List<NoteModel>? readNotes;

  ReadNotesUpdated({required this.readNotes});
}

final class ReadNotesDeletedSuccess extends ReadNotesState {}

class ReadNotesRestored extends ReadNotesState {
  final List<NoteModel>? readNotes;

  ReadNotesRestored({required this.readNotes});
}
