import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:noteapp/models/note.dart'; // Import your Note model here

class NoteDatabase {
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
  }

  // Read a note by ID

  // Update an existing note

  // Delete a note by ID

}