import 'package:yt_dupe/Domain/Home/model/home_model.dart';

abstract class InotesRepo {
  Future<List<NoteModel>> getAllNote();
  Future<void> updateNote(NoteModel value);
  Future<void> createNote(NoteModel value);
  Future<void> deleteNote(String id);
}
