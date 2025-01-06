import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static Database? _db;
  static final DatabaseService instance = DatabaseService._constructor();

  final String _pillTableName = 'pills';
  final String _pillLogTableName = 'pill_logs';

  DatabaseService._constructor();

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await getDatabase();
    return _db!;
  }

  Future<Database> getDatabase() async {
    final databaseDirPath = await getDatabasesPath();
    final databasePath = join(databaseDirPath, 'medmate.db');
    print("Database file path: $databasePath");
    final database = await openDatabase(
      databasePath,
      version: 1,
      onCreate: (db, version) {
        db.execute('''
          CREATE TABLE $_pillTableName(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            frequency TEXT,
            time TEXT,
            pill_type TEXT
          )
          ''');
      },
    );
    return database;
  }

  void addPill(
    String name,
    String frequency,
    String time,
    String pill_type,
  ) async {
    final db = await database;
    await db.insert(
      _pillTableName,
      {
        'name': name,
        'frequency': frequency,
        'time': time,
        'pill_type': pill_type,
      },
    );
  }

  void deletePill(int id) async {
    final db = await database;
    await db.delete(
      _pillTableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Map<String, dynamic>>> getPills() async {
    final db = await database;
    final data = db.query(_pillTableName);
    print(data);
    return data;
  }
}
