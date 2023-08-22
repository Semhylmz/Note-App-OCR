import 'dart:io';
import 'package:noteapp/model/note_db_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class NotesDatabaseHelper {
  final String _databaseName = 'userNotes.db';
  final String _tableName = 'notesTable';
  final int _version = 1;

  NotesDatabaseHelper._privateConstructor();

  static final NotesDatabaseHelper instance =
      NotesDatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path, version: _version, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''CREATE TABLE $_tableName(
        id INTEGER NOT NULL PRIMARY KEY,
        title TEXT,
        content TEXT,
        category TEXT,
        date TEXT,
        color TEXT
        )''');
  }

  Future<List<NoteDbModel>> getData() async {
    Database db = await instance.database;

    var items = await db.query(_tableName, orderBy: 'date DESC');

    List<NoteDbModel> contentList = items.isNotEmpty
        ? items.map((e) => NoteDbModel.fromMap(e)).toList()
        : [];

    return contentList;
  }

  Future<int> add(NoteDbModel saveDbModel) async {
    Database db = await instance.database;
    return await db.insert(_tableName, saveDbModel.toMap());
  }

  Future<int> update(NoteDbModel updateDbModel, int id) async {
    Database db = await instance.database;

    return await db.rawUpdate(
        'UPDATE $_tableName '
        'SET title = ?,'
        'content = ?,'
        'category = ?,'
        'date = ?,'
        'color = ?'
        'WHERE id = ?',
        [
          updateDbModel.title,
          updateDbModel.content,
          updateDbModel.category,
          updateDbModel.date,
          updateDbModel.color,
          id
        ]);
  }

  Future<int> remove(int id) async {
    Database db = await instance.database;
    return await db.delete(_tableName, where: 'id = ?', whereArgs: [id]);
  }

  Future<void> dropTable() async {
    Database db = await instance.database;

    db.delete(_tableName);

    '''DROP TABLE $_tableName''';
  }

  Future<void> deleteDatabase(String path) async {
    await databaseFactory.deleteDatabase(path);
  }
}
