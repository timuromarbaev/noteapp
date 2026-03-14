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

  // Read a note by ID

  // Update an existing note

  // Delete a note by ID

}