import 'package:medmate/helper.dart';
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

        db.execute('''
          CREATE TABLE $_pillLogTableName(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            pill_id INTEGER,
            action TEXT,
            date TEXT,
            logtime TEXT,
            FOREIGN KEY(pill_id) REFERENCES $_pillTableName(id)
          )
        ''');
      },
    );
    return database;
  }

  void addPillLog(int pillId, String action, String date) async {
    final db = await database;
    await db.insert(
      _pillLogTableName,
      {
        'pill_id': pillId,
        'action': action,
        'date': date,
        'logtime': formatDateTimeToDatetime(DateTime.now()),
      },
    );
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

  Future<List<Map<String, dynamic>>> getPillLogs(
      int pillId, String date) async {
    final db = await database;
    final logs = await db.query(
      _pillLogTableName,
      where: 'pill_id = ? AND date = ?',
      whereArgs: [pillId, date],
    );
    return logs;
  }

  Future<List<Map<String, dynamic>>> getPillLogsByDate(String date) async {
    final db = await database;

    final logs = await db.rawQuery(
      '''
      SELECT p.id, p.name, p.frequency, p.time, p.pill_type, 
            COALESCE(pl.action, null) AS action, 
            COALESCE(pl.date, ?) AS date, 
            pl.logtime
      FROM $_pillTableName p
      LEFT JOIN $_pillLogTableName pl ON p.id = pl.pill_id AND pl.date = ?
      ''',
      [date, date],
    );

    return logs;
  }

  void deletePillLog(int pillId, String date) async {
    final db = await database;
    await db.delete(
      _pillLogTableName,
      where: 'pill_id = ? AND date = ?',
      whereArgs: [pillId, date],
    );
  }
}
