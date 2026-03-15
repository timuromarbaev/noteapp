import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:noteapp/models/note.dart'; // Import your Note model here

class NoteDatabase extends ChangeNotifier {
  static late Isar isar;

  // Initialize the database connection and setup tables here
  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [NoteSchema], // Add your collection schemas here
      directory: dir.path,
    );
  }

  // list of all notes
  final List<Note> currentNotes = [];

  // Create a new note
  Future<void> createNote(String textFromUser) async {
    // Create a new note instance 
    final newNote = Note(
      title: 'New Note', // You can customize this as needed
      content: textFromUser,
      createdAt: DateTime.now(),
    );

  // Save the new note to the database
    await isar.writeTxn(() => isar.notes.put(newNote));

     // Re-read all notes from the database
    await fetchNotes();

  }

 
  // Read a note by ID
  Future<void> fetchNotes() async {
    List<Note> fetchedNotes = await isar.notes.where().findAll();
    currentNotes.clear();
    currentNotes.addAll(fetchedNotes);
    notifyListeners(); // Notify listeners to update the UI
  }

  // Update an existing note
  Future<void> updateNote(int id, String newContent) async {
    final existingNote = await isar.notes.get(id);
    if (existingNote != null) {
      existingNote.content = newContent;
      await isar.writeTxn(() => isar.notes.put(existingNote));
      await fetchNotes();
    }
  }

  // Delete a note by ID
Future<void> deleteNote(int id) async {
    await isar.writeTxn(() => isar.notes.delete(id));
    await fetchNotes();
  }
}