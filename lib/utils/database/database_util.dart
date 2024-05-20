import 'dart:convert';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../data/models/chatBox/fetch_employees_model.dart';
import '../../data/models/permit/offline_permit_model.dart';

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

        await db.execute('''
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
          permitId TEXT UNIQUE,
          listPage TEXT,
          tab1 TEXT,
          tab2 TEXT,
          tab3 TEXT,
          tab4 TEXT,
          tab5 TEXT,
          tab6 TEXT,
          html TEXT,
          statusId INTEGER
        );
  ''');
        await db.execute('''
        CREATE TABLE IF NOT EXISTS OfflinePermitAction (
         id INTEGER PRIMARY KEY,
          permitId TEXT,
          actionText TEXT,
          actionJson TEXT,
          actionDateTime TEXT,
          sign TEXT,
          UNIQUE(permitId, actionText)
        );
  ''');
      },
    );
  }

  Future<void> recreateOfflinePermitTable() async {
    final Database db = await database;
    // Drop the table if it exists
    await db.execute('DROP TABLE IF EXISTS OfflinePermit');
    await db.execute('DROP TABLE IF EXISTS OfflinePermitAction');

    // Create the table again
    await db.execute('''
    CREATE TABLE IF NOT EXISTS OfflinePermit (
          id INTEGER PRIMARY KEY,
          permitId TEXT UNIQUE,
          listPage TEXT,
          tab1 TEXT,
          tab2 TEXT,
          tab3 TEXT,
          tab4 TEXT,
          tab5 TEXT,
          tab6 TEXT,
          html TEXT,
          statusId INTEGER
        );
  ''');

    await db.execute('''
        CREATE TABLE IF NOT EXISTS OfflinePermitAction (
         id INTEGER PRIMARY KEY,
          permitId TEXT,
          actionText TEXT,
          actionJson TEXT,
          actionDateTime TEXT,
          sign TEXT,
          UNIQUE(permitId, actionText)
        );
  ''');
  }

  Future<bool> insertOfflinePermitAction(String permitId, String actionText,
      Map actionJson, String sign, String? actionDateTime) async {
    final Database db = await database;
    try {
      int result = await db.insert(
          'OfflinePermitAction',
          {
            'permitId': permitId,
            'actionText': actionText,
            'actionJson': jsonEncode(actionJson),
            'actionDateTime':
                actionDateTime ?? DateTime.now().toUtc().toString(),
            'sign': sign
          },
          conflictAlgorithm: ConflictAlgorithm.replace);

      return result > 0;
    } catch (e) {
      return false;
    }
  }

  Future<void> insertOfflinePermit(OfflinePermitDatum data) async {
    final Database db = await database;
    await db.insert(
      'OfflinePermit',
      {
        'permitId': data.id,
        'listpage': jsonEncode(data.listpage.toJson()),
        'tab1': jsonEncode(data.tab1.toJson()),
        'tab2': jsonEncode(data.tab2.toJson()),
        'tab3': jsonEncode(data.tab3.map((e) => e.toJson()).toList()),
        'tab4': jsonEncode(data.tab4),
        'tab5': jsonEncode(data.tab5.map((e) => e.toJson()).toList()),
        'tab6': jsonEncode(data.tab6),
        'html': jsonEncode(data.html),
        'statusId': data.listpage.statusid
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
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

  Future<void> getUnreadMessageCount(
      String currentUserId,
      String currentSenderId,
      String receiverId,
      String currentReceiverId,
      bool onChatMessagingScreen) async {
    final Database db = await database;

    await db.transaction((txn) async {
      final unreadCount = await txn.rawQuery('''
      SELECT COUNT(*) AS unread_for_recipient
      FROM chat_messages
       WHERE sid = ? AND rid = ? AND showCount = 0;
    ''', [currentUserId, receiverId]);
      int unreadRecipientCount =
          unreadCount.first['unread_for_recipient'] as int;
      await txn.update(
          'chat_messages', {'unreadMessageCount': unreadRecipientCount},
          where: 'sid = ? AND rid = ?', whereArgs: [currentUserId, receiverId]);
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

    messages = await db.query(
      'chat_messages',
      where: '(rid = ? AND sid = ?) OR (rid = ? AND sid = ?)',
      whereArgs: [employeeIdA, employeeIdB, employeeIdB, employeeIdA],
    );

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

  Future<List<Map<String, dynamic>>> fetchPermitListOffline() async {
    final db = await database;
    final List<Map<String, dynamic>> result =
        await db.rawQuery('SELECT listPage FROM OfflinePermit');
    final List<Map<String, dynamic>> permitList = [];
    for (var data in result) {
      permitList.add(jsonDecode(data['listPage']));
    }
    return permitList;
  }

  Future<Map<String, dynamic>> fetchPermitDetailsOffline(
      String permitId) async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db.rawQuery(
        'SELECT tab1, tab2, tab3, tab4, tab5, tab6, html FROM OfflinePermit WHERE permitId = ?',
        [permitId]);
    if (results.isNotEmpty) {
      final Map<String, dynamic> result = results.first;
      Map<String, dynamic> returnMap = {
        "tab1": jsonDecode(result['tab1']),
        "tab2": jsonDecode(result['tab2']),
        "tab3": jsonDecode(result['tab3']),
        "tab4": jsonDecode(result['tab4']),
        "tab5": jsonDecode(result['tab5']),
        "tab6": jsonDecode(result['tab6']),
        "html": jsonDecode(result['html'])
      };
      return returnMap;
    } else {
      return {};
    }
  }

  Future<Map<String, dynamic>> fetchPermitDetailsHtml(String permitId) async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db.rawQuery(
        'SELECT html FROM OfflinePermit WHERE permitId = ?', [permitId]);
    if (results.isNotEmpty) {
      final Map<String, dynamic> result = results.first;
      Map<String, dynamic> returnMap = jsonDecode(result['html']);
      return returnMap;
    } else {
      return {};
    }
  }

  Future<int> fetchPermitStatusId(String permitId) async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db.rawQuery(
        'SELECT statusId FROM OfflinePermit WHERE permitId = ?', [permitId]);
    return results.first['statusId'];
  }

  Future<List<Map<String, dynamic>>> fetchAllOfflinePermitAction() async {
    final db = await database;
    final List<Map<String, dynamic>> result =
        await db.rawQuery('SELECT * FROM OfflinePermitAction');
    if (result.isEmpty) {
      return [];
    } else {
      return result;
    }
  }

  Future<List<Map<String, dynamic>>> fetchOfflinePermitAction(
      String permitId) async {
    final db = await database;
    List<Map<String, dynamic>> result = await db.query('OfflinePermitAction',
        where: 'permitId = ?', whereArgs: [permitId]);
    if (result.isEmpty) {
      return [];
    } else {
      List<Map<String, dynamic>> finalResult = [];
      for (var i = 0; i < result.length; i++) {
        finalResult.add({
          'actionJson': jsonDecode(result[i]['actionJson']),
          'actionText': result[i]['actionText'],
          'actionDateTime': result[i]['actionDateTime'],
          'sign': result[i]['sign'],
          'permitId': result[i]['permitId'],
        });
      }
      return finalResult;
    }
  }

  Future<void> deleteOfflinePermitAction(int id) async {
    final db = await database;
    await db.delete('OfflinePermitAction', where: 'ID = ?', whereArgs: [id]);
  }

  Future<void> updateStatusId(String permitId, int updatedStatus) async {
    final db = await database;
    await db.update('OfflinePermit', {'statusId': updatedStatus},
        where: 'permitId = ?', whereArgs: [permitId]);
  }

  Future<int> getTypeOfPermit(String permitId) async {
    final db = await database;
    List<Map<String, dynamic>> result = await db.query('OfflinePermit',
        columns: ['listPage'], where: 'permitId = ?', whereArgs: [permitId]);
    if (result.isNotEmpty) {
      String listPageJson = result.first['listPage'];
      Map<String, dynamic> listPageMap = jsonDecode(listPageJson);
      return listPageMap['type_of_permit'];
    } else {
      return -1;
    }
  }

  Future<void> updateStatus(String permitId, String updatedStatus) async {
    final db = await database;
    List<Map<String, dynamic>> result = await db.query('OfflinePermit',
        columns: ['listPage'], where: 'permitId = ?', whereArgs: [permitId]);
    if (result.isNotEmpty) {
      String listPageJson = result.first['listPage'];
      Map<String, dynamic> listPageMap = jsonDecode(listPageJson);
      listPageMap['status'] = updatedStatus;
      String updatedListPageJson = jsonEncode(listPageMap);
      await db.update('OfflinePermit', {'listPage': updatedListPageJson},
          where: 'permitId = ?', whereArgs: [permitId]);
    }
  }

  Future<void> updateEquipmentSafetyDoc(
      String permitId, Map equipmentMap) async {
    final db = await database;
    List<Map<String, dynamic>> result = await db.query('OfflinePermit',
        columns: ['html'], where: 'permitId = ?', whereArgs: [permitId]);
    if (result.isNotEmpty) {
      String listPageJson = result.first['html'];
      Map<String, dynamic> equMap = jsonDecode(listPageJson);
      equMap['location'] = equipmentMap['location'] ?? '';
      equMap['methodstatement'] = equipmentMap['methodstmt'] ?? '';
      equMap['description'] = equipmentMap['description'] ?? '';
      equMap['ptw_isolation'] = equipmentMap['ptw_isolation'] ?? '';
      equMap['ptw_circuit'] = equipmentMap['ptw_circuit'] ?? '';
      equMap['ptw_safety'] = equipmentMap['ptw_safety'] ?? '';
      equMap['ptw_precautions2'] = equipmentMap['ptw_precautions2'] ?? '';
      equMap['ptw_precautions'] = equipmentMap['ptw_precautions'] ?? '';
      equMap['st_precautions'] = equipmentMap['st_precautions'] ?? '';
      equMap['st_safety'] = equipmentMap['st_safety'] ?? '';
      equMap['ptw_circuit2'] = equipmentMap['ptw_circuit2'] ?? '';
      equMap['lwc_accessto'] = equipmentMap['lwc_accessto'] ?? '';
      equMap['lwc_environment'] = equipmentMap['lwc_environment'] ?? '';
      equMap['lwc_precautions'] = equipmentMap['lwc_precautions'] ?? '';
      String updatedEquipmentMap = jsonEncode(equMap);
      await db.update('OfflinePermit', {'html': updatedEquipmentMap},
          where: 'permitId = ?', whereArgs: [permitId]);
    }
  }

  Future<List> populateClearPermitData(String permitId) async {
    final db = await database;
    List<Map<String, dynamic>> result = await db.query('OfflinePermitAction',
        columns: ['actionJson', 'actionText'],
        where: 'permitId = ? AND actionText = ?',
        whereArgs: [permitId, 'open_permit']);
    if (result.isNotEmpty) {
      Map<String, dynamic> populateClearPermitData = result.first;
      Map<String, dynamic> actionJson =
          jsonDecode(populateClearPermitData['actionJson']);
      List customFields = actionJson['customfields'];
      return customFields;
    } else {
      return <Map<String, dynamic>>[];
    }
  }
}
