import 'package:isar/isar.dart';


// this line is needed for code generation, it should be the last line of this file
// run the command "flutter pub run build_runner build" in the terminal to generate the code
part 'note.g.dart';

@Collection()
class Note {
  Id id = Isar.autoIncrement;
  String title;
  String content;
  DateTime createdAt;

  Note({
    this.id = Isar.autoIncrement,
    required this.title,
    required this.content,
    required this.createdAt,
  });
}