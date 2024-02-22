import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database? _database;

  Future<Database> get database async {
    _database ??= await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'chat_database.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE chat_messages (
            id INTEGER PRIMARY KEY,
            msg_id TEXT,
            quote_msg_id TEXT,
            sid TEXT,
            stype TEXT,
            rid INTEGER,
            rtype TEXT,
            msg_type TEXT,
            msg_time TEXT,
            msg TEXT,
            hashcode TEXT,
            sid_2 INTEGER,
            stype_2 TEXT,
            msg_status TEXT DEFAULT '0',
            employee_name TEXT,
            employee_id TEXT
          )
        ''');
      },
    );
  }

  Future<void> insertMessage(Map<String, dynamic> sendMessageMap) async {
    final Database db = await database;
    await db.insert(
      'chat_messages',
      sendMessageMap,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateMessageStatus(String msgId) async {
    final Database db = await database;
    await db.update(
      'chat_messages',
      {'msg_status': '1'},
      where: 'msg_id = ?',
      whereArgs: [msgId],
    );
  }

  Future<List<Map<String, dynamic>>> getMessagesForEmployee(
      String employeeId) async {
    final Database db = await database;
    return await db.query(
      'chat_messages',
      where: 'employee_id = ?',
      whereArgs: [employeeId],
    );
  }

  Future<List<Map<String, dynamic>>> getLatestMessagesForEmployees() async {
    final Database db = await database;
    return await db.rawQuery('''
    SELECT * FROM chat_messages
    WHERE (employee_id, msg_time) IN (
      SELECT employee_id, MAX(msg_time) AS latest_time
      FROM chat_messages
      GROUP BY employee_id
    )
  ''');
  }
}
