import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

/// This class is used to manage all the [DB] connection, opening, closing and initialization.
///
/// It has a singleton desing pattern.
///
/// It initializes as of the first time is instanciated.
///
/// Also, the tables are defined here.
class MyDB {
  static final MyDB _instance = MyDB._internal();
  static Database? _database;

  MyDB._internal();

  factory MyDB() => _instance;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'database.db');

    return await openDatabase(
      path,
      version: 1,
      onConfigure: (db) async {
        await db.execute('PRAGMA foreign_keys = ON');
      },
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE tasks (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        task_name TEXT NOT NULL,
        done INTEGER NOT NULL,
        description TEXT NOT NULL
      );
    ''');

    await db.execute('''
      CREATE TABLE fields (
        id INTEGER NOT NULL,
        task_id INTEGER NOT NULL,
        label TEXT NOT NULL,
        value TEXT NOT NULL,
        required INTEGER NOT NULL,
        field_type TEXT NOT NULL,
        PRIMARY KEY (id, task_id),
        FOREIGN KEY (task_id) REFERENCES tasks(id) ON DELETE CASCADE
      );
    ''');
  }

  Future<void> close() async {
    final db = await database;
    db.close();
  }

  Future<void> deleteMyDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'database.db');

    await deleteDatabase(path);
  }
}
