// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:hive_flutter/adapters.dart';
import 'package:injectable/injectable.dart';
import 'package:yt_dupe/Domain/Home/i.home_repo.dart';
import 'package:yt_dupe/Domain/Home/model/home_model.dart';

const dbName = 'note_db';

@Injectable(as: InotesRepo)
class Notes implements InotesRepo {
  @override
  Future<void> createNote(NoteModel value) async {
    final _createdb = await Hive.openBox<NoteModel>(dbName);
    _createdb.put(value.id, value);
  }

  @override
  Future<void> deleteNote(String id) async {
    final _delete = await Hive.openBox<NoteModel>(dbName);
    return _delete.delete(id);
  }

  @override
  Future<List<NoteModel>> getAllNote() async {
    final _getData = await Hive.openBox<NoteModel>(dbName);

    final _list = _getData.values.toList();

    return _list;
  }

  @override
  Future<void> updateNote(NoteModel newvalue) async {
    final _getData = await Hive.openBox<NoteModel>(dbName);

    return _getData.put(newvalue.id, newvalue);
  }
}
