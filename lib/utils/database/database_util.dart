import 'dart:convert';

import 'package:sqflite/sqflite.dart';

// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:toolkit/data/models/permit/permit_details_model.dart';

import '../../data/models/chatBox/fetch_employees_model.dart';

class DatabaseHelper {
  static Database? _database;

  Future<Database> get database async {
    _database ??= await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'chat_database.db');

    return await openDatabase(
      readOnly: false,
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE chat_messages (
            msg_id TEXT PRIMARY KEY,
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
            isReceiver INTEGER DEFAULT 0,
            messageType TEXT,
            isDownloadedImage INTEGER,
            localImagePath TEXT,
            pickedMedia TEXT,
            serverImagePath TEXT,
            showCount INTEGER,
            unreadMessageCount INTEGER,
            isGroup INTEGER,
            attachementExtension TEXT
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
        purpose TEXT,
        date TEXT
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
          date TEXT,
          FOREIGN KEY (group_id) REFERENCES groups(group_id)
        );
  ''');
        await db.execute('''
          CREATE TABLE IF NOT EXISTS OfflinePermit (
            id INTEGER PRIMARY KEY,
            Status INTEGER,
            Message TEXT,
            Data TEXT
          );
        ''');
        await db.execute('''
          CREATE TABLE IF NOT EXISTS Datum (
            id TEXT PRIMARY KEY,
            id2 TEXT,
            listpage TEXT,
            tab1 TEXT,
            tab2 TEXT,
            tab3 TEXT,
            tab4 TEXT,
            tab5 TEXT,
            tab6 TEXT,
            html TEXT
          );
        ''');
        await db.execute('''
          CREATE TABLE IF NOT EXISTS Listpage (
            id TEXT PRIMARY KEY,
            id2 TEXT,
            permit TEXT,
            typeOfPermit INTEGER,
            schedule TEXT,
            location TEXT,
            description TEXT,
            statusid INTEGER,
            status TEXT,
            expired TEXT,
            pname TEXT,
            pcompany TEXT,
            emergency INTEGER,
            npiStatus TEXT,
            npwStatus TEXT,
            startdate TEXT,
            enddate TEXT
          );
        ''');
        await db.execute('''
          CREATE TABLE IF NOT EXISTS Tab1 (
            id TEXT PRIMARY KEY,
            typeOfPermit INTEGER,
            permit TEXT,
            schedule TEXT,
            location TEXT,
            details TEXT,
            status TEXT,
            expired TEXT,
            pnameNpi TEXT,
            pname TEXT,
            pcompany TEXT,
            emergency INTEGER,
            isopen TEXT,
            ishold TEXT,
            isclose TEXT,
            isnpiaccept TEXT,
            isnpwaccept TEXT,
            clientid TEXT
          );
        ''');
        await db.execute('''
          CREATE TABLE IF NOT EXISTS Tab2 (
            id INTEGER PRIMARY KEY,
            typeOfPermit INTEGER,
            permitNo INTEGER,
            safetyisolation TEXT,
            safetyisolationinfo TEXT,
            protectivemeasures TEXT,
            generalMessage TEXT,
            methodStatement TEXT,
            special_work TEXT,
            specialppe TEXT,
            layout TEXT,
            layout_file TEXT,
            layout_link TEXT
          );
        ''');
        await db.execute('''
          CREATE TABLE IF NOT EXISTS Customfield (
            title TEXT PRIMARY KEY,
            fieldvalue TEXT
          );
        ''');
        await db.execute('''
          CREATE TABLE IF NOT EXISTS Tab3 (
            id TEXT PRIMARY KEY,
            name TEXT,
            jobTitle TEXT,
            company TEXT,
            certificatecode TEXT,
            npiId TEXT,
            npwId TEXT
          );
        ''');
        await db.execute('''
          CREATE TABLE IF NOT EXISTS Tab5 (
            id INTEGER PRIMARY KEY,
            name TEXT,
            type TEXT,
            files TEXT
          );
        ''');
      },
    );
  }

  Future<void> insertMessage(Map<String, dynamic> sendMessageMap) async {
    final Database db = await database;
    try {
      await db.insert('chat_messages', sendMessageMap,
          conflictAlgorithm: ConflictAlgorithm.ignore);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> getAllMessages() async {
    final Database db = await database;
    try {
      List<Map<String, dynamic>> allMessagesList =
          await db.query('chat_messages');
      return allMessagesList;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateMessage(Map<String, dynamic> message) async {
    final Database db = await database;
    try {
      await db.update('chat_messages', message,
          where: 'msg_id = ?', whereArgs: [message['msg_id']]);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateLocalImagePath(
      String messageId, String localImagePath) async {
    final db = await database;
    await db.transaction((txn) async {
      await txn.update('chat_messages',
          {'localImagePath': localImagePath, 'isDownloadedImage': 1},
          where: 'msg_id = ?', whereArgs: [messageId]);
    });
  }

  Future<void> updateServerImagePath(
      String messageId, String serverImagePath) async {
    final db = await database;
    await db.transaction((txn) async {
      await txn.update('chat_messages',
          {'serverImagePath': serverImagePath, 'isDownloadedImage': 0},
          where: 'msg_id = ?', whereArgs: [messageId]);
    });
  }

  Future<void> getUnreadMessageCount(String currentUserId) async {
    final Database db = await database;

    await db.transaction((txn) async {
      final unreadCount = await txn.rawQuery('''
      SELECT COUNT(*) AS unread_for_recipient
      FROM chat_messages
      WHERE sid = ? AND showCount = 0;
    ''', [currentUserId]);

      final unreadRecipientCount =
          unreadCount.first['unread_for_recipient'] as int;

      await txn.update(
        'chat_messages',
        {'unreadMessageCount': unreadRecipientCount},
        where: 'sid = ?',
        whereArgs: [currentUserId],
      );
    });
  }

  Future<void> updateShowCountForMessages(
      String recipientId, String senderId) async {
    final Database db = await database;
    await db.update(
      'chat_messages',
      {'showCount': 1},
      where: '(rid = ? AND showCount = 0) OR (sid = ? AND showCount = 0)',
      whereArgs: [recipientId, senderId],
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
    await db.update('chat_messages', {'msg_status': '1'},
        where: 'msg_id = ?', whereArgs: [msgId]);
  }

  Future<List<Map<String, dynamic>>> getMessagesForEmployees(
      String employeeIdA, String employeeIdB) async {
    final Database db = await database;
    List<Map<String, dynamic>> messages = [];

    messages = await db.query('chat_messages',
        where: '(rid = ? AND sid = ?) OR (rid = ? AND sid = ?)',
        whereArgs: [employeeIdA, employeeIdB, employeeIdB, employeeIdA]);

    List<Map<String, dynamic>> updatedMessages = [];

    for (var message in messages) {
      updatedMessages.add(Map<String, dynamic>.from(message));
    }
    for (var i = 0; i < updatedMessages.length; i++) {
      if (updatedMessages[i]['employee_name'] == null ||
          updatedMessages[i]['employee_name'].isEmpty) {
        final nameResult = await db.query(
          'chat_messages',
          where: 'sid = ? OR rid = ?',
          whereArgs: [updatedMessages[i]['sid'], updatedMessages[i]['rid']],
        );
        if (nameResult.isNotEmpty) {
          updatedMessages[i]['employee_name'] =
              nameResult.first['employee_name'];
        }
      }
    }
    return updatedMessages;
  }

  Future<List> getLatestMessagesForEmployees() async {
    final Database db = await database;

    const empList = '''
    SELECT DISTINCT rid, sid
    FROM chat_messages;
  ''';

    final employeeList = await db.rawQuery(empList);

    List employees = List.from(employeeList);

    return employees;
  }

  Future<String> getEmployeeNameFromDatabase(String employeeId) async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db
        .query('chat_messages', where: 'rid = ?', whereArgs: [employeeId]);
    if (maps.isNotEmpty) {
      return maps[0]['employee_name'] ?? '';
    } else {
      return 'employee name not found!';
    }
  }

  Future<String?> getLatestEmployeeId() async {
    final Database db = await database;
    const String query =
        'SELECT rid FROM chat_messages ORDER BY msg_id DESC LIMIT 1;';
    final List<Map<String, dynamic>> results = await db.rawQuery(query);

    if (results.isNotEmpty) {
      return results.first['rid'].toString();
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

  Future<List<Map<String, dynamic>>> getMessagesWithStatusZero() async {
    final Database db = await database;
    List<Map<String, dynamic>> messages;
    messages = await db
        .query('chat_messages', where: 'msg_status = ?', whereArgs: ['0']);
    return messages;
  }

  Future<void> insertOfflinePermit(Map<String, dynamic> model) async {
    final db = await database;
    await db.insert('OfflinePermit', model);
  }

  Future<List<Map<String, dynamic>>> getOfflinePermits() async {
    final db = await database;
    return await db.query('OfflinePermit');
  }

  Future<List<Map<String, dynamic>>> fetchListPageData() async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db
        .rawQuery('SELECT Data FROM OfflinePermit WHERE Data IS NOT NULL');

    // Deserialize JSON data and extract 'listpage' objects
    List<Map<String, dynamic>> listPageData = [];
    for (var row in result) {
      String jsonString = row['Data'];
      List<dynamic> jsonDataList = json.decode(jsonString);

      // Extract 'listpage' objects from each item in the JSON array
      for (var item in jsonDataList) {
        if (item is Map<String, dynamic> && item.containsKey('listpage')) {
          listPageData.add(item['listpage']);
        }
      }
    }

    return listPageData;
  }

  Future<List<PermitDerailsData>> fetchPermitDetails() async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db
        .rawQuery('SELECT Data FROM OfflinePermit WHERE Data IS NOT NULL');

    if (result.isNotEmpty) {
      final List<dynamic> dataList = json.decode(result.first['Data']);
      List<PermitDerailsData> permitDataList = [];
      for (var item in dataList) {
        if (item is Map<String, dynamic>) {
          final PermitDerailsData data = PermitDerailsData(
            tab1: Tab1.fromJson(item['tab1']),
            tab2: Tab2.fromJson(item['tab2']),
            tab3: List<Tab3>.from(item['tab3'].map((x) => Tab3.fromJson(x))),
            tab4: List<Tab4>.from(item['tab4'].map((x) => Tab4.fromJson(x))),
            tab5: List<Tab5>.from(item['tab5'].map((x) => Tab5.fromJson(x))),
            tab6: [],
            // tab6: List<Tab6>.from(item['tab6'].map((x) => Tab6.fromJson(x))),
          );
          permitDataList.add(data);
        }
      }
      return permitDataList;
    } else {
      throw Exception('No data found in OfflinePermit table');
    }
  }
}
