import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../data/models/chatBox/fetch_employees_model.dart';

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
            employee_id TEXT,
            isReceiver INTEGER DEFAULT 0,
            messageType TEXT
          )
        ''');
        await db.execute('''
        CREATE TABLE IF NOT EXISTS employees (
          primary_id INTEGER PRIMARY KEY,
          id TEXT,
          name TEXT,
          type TEXT
        )
  ''');
        await db.execute('''
        CREATE TABLE IF NOT EXISTS groups (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        group_id TEXT UNIQUE,
        group_name TEXT NOT NULL,
        purpose TEXT
      );
        ''');

        db.execute('''
        CREATE TABLE IF NOT EXISTS members (
          primary_id INTEGER PRIMARY KEY AUTOINCREMENT,
          id INTEGER UNIQUE,
          type INTEGER,
          name TEXT,
          isowner INTEGER DEFAULT 0,
          group_id TEXT,
          FOREIGN KEY (group_id) REFERENCES groups(group_id)
        );
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

  Future<void> insertEmployees(List<EmployeesDatum> employees) async {
    final db = await database;
    var batch = db.batch();
    for (var employee in employees) {
      Map<String, dynamic> employeeMap = {
        'id': employee.id,
        'name': employee.name,
        'type': employee.type
      };
      batch.insert('employees', employeeMap,
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
    await batch.commit(noResult: true);
  }

  Future<List<Map<String, dynamic>>> getEmployees() async {
    final db = await database;
    List<Map<String, dynamic>> employees = await db.query('employees');
    return employees;
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
    return await db.query('chat_messages',
        where: 'employee_id = ?', whereArgs: [employeeId]);
  }

  Future<List> getLatestMessagesForEmployees() async {
    final Database db = await database;

    const empList = '''
    SELECT DISTINCT employee_id
    FROM chat_messages;
  ''';

    final employeeList = await db.rawQuery(empList);

    List employees = List.from(employeeList);

    return employees;
  }

  Future<String> getEmployeeNameFromDatabase(String employeeId) async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query('chat_messages',
        where: 'employee_id = ?', whereArgs: [employeeId]);
    if (maps.isNotEmpty) {
      return maps[0]['employee_name'] ?? 'na';
    } else {
      return 'employee name not found!';
    }
  }

  Future<String?> getLatestEmployeeId() async {
    final Database db = await database;
    const String query =
        'SELECT employee_id FROM chat_messages ORDER BY id DESC LIMIT 1;';
    final List<Map<String, dynamic>> results = await db.rawQuery(query);

    if (results.isNotEmpty) {
      return results.first['employee_id'] as String?;
    } else {
      return null;
    }
  }

  Future<void> insertGroup(Map<String, dynamic> groupData,
      List<Map<String, dynamic>> members) async {
    final db = await database;
    Batch batch = db.batch();

    batch.insert('groups', groupData,
        conflictAlgorithm: ConflictAlgorithm.replace);

    for (var member in members) {
      member['group_id'] = groupData['group_id'];
      batch.insert('members', member,
          conflictAlgorithm: ConflictAlgorithm.replace);
    }

    await batch.commit(noResult: true);
  }

  Future<List<Map<String, dynamic>>> getAllGroupsData() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('groups');
    return maps;
  }
}
