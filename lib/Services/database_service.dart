import 'package:path/path.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static Database? _db;
  static final DatabaseService instance = DatabaseService._constructor();

  final String _tasksTableName = "tasks";
  final String _tasksIdColumnName = "id";
  final String _tasksContetColumnName = "id";
  final String _tasksStatusColumnName = "id";

  DatabaseService._constructor();

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await getDatabase();
    return _db!;
  }

  Future<Database> getDatabase() async {
    final databaseDirPath = await getDatabasesPath();
    final databasePath = join(databaseDirPath, "master_db.db");

    final database = await openDatabase(databasePath, onCreate: (db, version) {
      db.execute('''
      CREATE TABLE $_tasksTableName (
        $_tasksIdColumnName INTEGER PRIMARY KEY,
        $_tasksContetColumnName TEXT NOT NULL,
        $_tasksStatusColumnName INTEGER NOT NULL
      )
      ''');
    });
    return database;
  }

  void addTask(
    String content,
  ) async {
    final db = await database;
    await db.insert(
      _tasksTableName,
      {
        _tasksContetColumnName: content,
        _tasksStatusColumnName: 0,
      },
    );
  }
}
