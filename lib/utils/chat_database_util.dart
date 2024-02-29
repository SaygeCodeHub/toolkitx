import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:toolkit/screens/chatBox/widgets/chat_data_model.dart';

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

        await db.execute('''
    CREATE TABLE chat_group_details (
      id INTEGER PRIMARY KEY,
      employee_id INTEGER,
      employee_name TEXT,
      msg TEXT,
      group_name TEXT,
      group_id INTEGER,
      purpose TEXT
    )
  ''');

        await db.execute('''
    CREATE TABLE chat_group_members (
      member_id INTEGER PRIMARY KEY,
      id INTEGER,
      type INTEGER,
      name TEXT,
      isowner INTEGER,
      group_id INTEGER,
      FOREIGN KEY (group_id) REFERENCES group_details (group_id)
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

  Future<void> insertGroupDetails(ChatData groupDetails) async {
    final db = await database;
    await db.insert('chat_group_details', groupDetails.chatToMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> insertGroupMembers(int groupId, List<Members> members) async {
    final db = await database;
    final List<Map<String, dynamic>> memberMaps =
        members.map((member) => member.toMap()).toList();
    for (var member in memberMaps) {
      member['group_id'] = groupId;
      await db.insert('chat_group_members', member);
    }
  }

  Future<ChatData?> getGroupDetails(int groupId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('chat_group_details',
        where: 'group_id = ?', whereArgs: [groupId]);
    if (maps.isNotEmpty) {
      return ChatData(
          groupId: maps[0]['group_id'],
          groupName: maps[0]['group_name'],
          groupPurpose: maps[0]['purpose']);
    }
    return null;
  }

  Future<List<Members>> getGroupMembers(int groupId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('chat_group_members',
        where: 'group_id = ?', whereArgs: [groupId]);
    return List.generate(maps.length, (i) {
      return Members(
          id: maps[i]['id'],
          name: maps[i]['name'],
          type: maps[i]['type'],
          isOwner: maps[i]['isowner']);
    });
  }
}
