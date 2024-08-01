import 'dart:convert';
import 'dart:math';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:toolkit/data/models/encrypt_class.dart';

import '../../data/enums/offlinePermit/instruction_operstions_enum.dart';
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
            isMessageUnread INTEGER,
            unreadMessageCount INTEGER,
            isGroup INTEGER,
            attachementExtension TEXT,
            msgTime INTEGER,
            sender_name TEXT,
            clientid INTEGER
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
          tab7 TEXT,
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
          tab7 TEXT,
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
      print('result====>${result > 0}');

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
        'tab7': jsonEncode(data.tab7.map((e) => e.toJson()).toList()),
        'html': jsonEncode(data.html),
        'statusId': data.listpage.statusid
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> insertMessage(Map<String, dynamic> sendMessageMap) async {
    final Database db = await database;
    try {
      DateTime dateTime = DateTime.parse(sendMessageMap['msg_time']);
      sendMessageMap['msgTime'] = dateTime.millisecondsSinceEpoch;
      await db.insert('chat_messages', sendMessageMap,
          conflictAlgorithm: ConflictAlgorithm.ignore);
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getLastMessage() async {
    final Database db = await database;
    List<Map<String, dynamic>> result =
        await db.query('chat_messages', orderBy: 'msgTime DESC', limit: 1);

    if (result.isNotEmpty) {
      return result.first;
    } else {
      return {};
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

  Future<void> updateUnreadMessageCount(String rid, String rtype) async {
    final Database db = await database;
    if (rtype == '3') {
      await db.update('chat_messages', {'isMessageUnread': 0},
          where: 'isMessageUnread = 1 AND rid = ? AND rtype = 3',
          whereArgs: [rid]);
    } else {
      await db.update('chat_messages', {'isMessageUnread': 0},
          where: 'isMessageUnread = 1 AND sid = ? AND stype = ?',
          whereArgs: [rid, rtype]);
    }
  }

  Future<List<Map<String, dynamic>>> getMessagesForEmployees(String sId,
      String sType, String rId, String rType, String clientId) async {
    final Database db = await database;
    List<Map<String, dynamic>> messages = [];
    var query =
        'select *,  ifnull((Select msg from chat_messages c1 where c1.msg_id = chat_messages.quote_msg_id),"") AS quotemsg,  ifnull((Select sender_name from chat_messages c1 where c1.msg_id = chat_messages.quote_msg_id),"") AS quote_sender from chat_messages where (((sid = $sId AND stype = $sType AND rid = $rId AND rtype = $rType) OR (sid = $rId AND stype = $rType AND rid = $sId AND rtype = $sType)) and clientid=$clientId) ORDER BY msgTime DESC';
    if (rType == '3') {
      query =
          'select *, ifnull((Select msg from chat_messages c1 where c1.msg_id = chat_messages.quote_msg_id),"") AS quotemsg,  ifnull((Select sender_name from chat_messages c1 where c1.msg_id = chat_messages.quote_msg_id),"") AS quote_sender from chat_messages where ((rid = $rId AND rtype = $rType) and clientid=$clientId) ORDER BY msgTime DESC';
    }
    messages = await db.rawQuery(query);
    if (messages.isNotEmpty) {
      return messages;
    } else {
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> getChatUsersList(String clientId) async {
    final Database db = await database;
    List<Map<String, dynamic>> messages = [];

    messages = await db.rawQuery(
        'select distinct sid as rid, stype as rtype, employee_name, (select msg from chat_messages c where ( ((c.rid=chat_messages.sid and c.rtype=chat_messages.stype) OR (c.sid=chat_messages.sid and c.stype=chat_messages.stype)) AND c.rtype in (1,2) and clientid = $clientId) ORDER BY c.msgTime DESC LIMIT 1) as latest_msg, (select msgTime from chat_messages c where (((c.rid=chat_messages.sid and c.rtype=chat_messages.stype) OR (c.sid=chat_messages.sid and c.stype=chat_messages.stype)) AND c.rtype in (1,2) and clientid = $clientId) ORDER BY c.msgTime DESC LIMIT 1) as latest_msgTime, (select SUM(c.isMessageUnread) from chat_messages c where (((c.rid=chat_messages.sid and c.rtype=chat_messages.stype) OR (c.sid=chat_messages.sid and c.stype=chat_messages.stype)))  AND c.rtype in (1,2) and clientid = $clientId) AS unreadCount from chat_messages where rtype in (1,2) and clientid = $clientId union select distinct rid, rtype, employee_name, (select msg from chat_messages c where ( ((c.rid=chat_messages.rid and c.rtype=chat_messages.rtype) OR (c.sid=chat_messages.rid and c.stype=chat_messages.rtype)) AND c.rtype in (1,2) and clientid = $clientId) ORDER BY c.msgTime DESC LIMIT 1) as latest_msg, (select msgTime from chat_messages c where ( ((c.rid=chat_messages.rid and c.rtype=chat_messages.rtype) OR (c.sid=chat_messages.rid and c.stype=chat_messages.rtype)) AND c.rtype in (1,2) and clientid = $clientId) ORDER BY c.msgTime DESC LIMIT 1) as latest_msgTime, (select SUM(c.isMessageUnread) from chat_messages c where (((c.rid=chat_messages.rid and c.rtype=chat_messages.rtype) OR (c.sid=chat_messages.rid and c.stype=chat_messages.rtype))) AND c.rtype in (1,2) and clientid = $clientId) AS unreadCount from chat_messages where rtype in (1,2) and clientid = $clientId  union select distinct rid, rtype, employee_name, (select msg from chat_messages c where (c.rid=chat_messages.rid AND c.rtype=3 and clientid = $clientId) ORDER BY c.msgTime DESC LIMIT 1) as latest_msg, (select msgTime from chat_messages c where ((c.rid=chat_messages.rid AND c.rtype=3) and clientid = $clientId) ORDER BY c.msgTime DESC LIMIT 1) as latest_msgTime, (select SUM(c.isMessageUnread) from chat_messages c where (c.rid=chat_messages.rid AND c.rtype=3 and clientid = $clientId)) AS unreadCount from chat_messages where rtype=3  and clientid = $clientId');
    if (messages.isNotEmpty) {
      return messages;
    } else {
      return [];
    }
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

  Future<Map<String, dynamic>> getGroupData(String groupId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps =
        await db.query('groups', where: 'group_id = ?', whereArgs: [groupId]);
    if (maps.isNotEmpty) {
      return maps.first;
    } else {
      return {};
    }
  }

  Future<List<Map<String, dynamic>>> getMessagesWithStatusZero() async {
    final Database db = await database;
    List<Map<String, dynamic>> messages;
    messages = await db
        .query('chat_messages', where: 'msg_status = ?', whereArgs: ['0']);
    return messages;
  }

  Future<void> deleteGroupChat(String rid) async {
    final db = await database;
    await db.delete('chat_messages',
        where: 'rid = ? and rtype = 3', whereArgs: [rid]);
  }

  Future<List<Map<String, dynamic>>> fetchPermitListOffline() async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db.rawQuery(
        'SELECT listPage,(SELECT count(OfflinePermitAction.id) FROM OfflinePermitAction WHERE OfflinePermitAction.permitId = OfflinePermit.permitId) AS actionCount FROM OfflinePermit');
    return result;
  }

  Future<Map<String, dynamic>> fetchPermitDetailsOffline(
      String permitId) async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db.rawQuery(
        'SELECT listPage, tab1, tab2, tab3, tab4, tab5, tab6, tab7, html FROM OfflinePermit WHERE permitId = ?',
        [permitId]);
    if (results.isNotEmpty) {
      final Map<String, dynamic> result = results.first;
      Map<String, dynamic> returnMap = {
        "listPage": jsonDecode(result['listPage']),
        "tab1": jsonDecode(result['tab1']),
        "tab2": jsonDecode(result['tab2']),
        "tab3": jsonDecode(result['tab3']),
        "tab4": jsonDecode(result['tab4']),
        "tab5": jsonDecode(result['tab5']),
        "tab6": jsonDecode(result['tab6']),
        "tab7": jsonDecode(result['tab7']),
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

  Future<Map<String, dynamic>> populateTransferPermitCpData(
      String permitId) async {
    final db = await database;
    List<Map<String, dynamic>> result = await db.query('OfflinePermitAction',
        columns: ['actionJson', 'actionText'],
        where: 'permitId = ? AND actionText = ?',
        whereArgs: [permitId, 'transfer_permit']);
    if (result.isNotEmpty) {
      Map<String, dynamic> populateTransferCpPermitData = result.first;
      Map<String, dynamic> actionJson =
          jsonDecode(populateTransferCpPermitData['actionJson']);
      return actionJson;
    } else {
      return {};
    }
  }

  Future<Map<String, dynamic>> fetchOfflinePermitSurrenderData(
      String permitId) async {
    final db = await database;
    List<Map<String, dynamic>> result = await db.query(
      'OfflinePermitAction',
      columns: ['actionJson', 'actionText'],
      where: 'permitId = ? AND actionText = ?',
      whereArgs: [permitId, 'transfer_permit'],
    );
    if (result.isNotEmpty) {
      Map<String, dynamic> fetchSurrenderData = result.first;
      Map<String, dynamic> actionJson =
          jsonDecode(fetchSurrenderData['actionJson']);
      return actionJson;
    } else {
      return {};
    }
  }

  Future<Map<String, dynamic>> fetchOfflinePermitTransferData(
      String permitId) async {
    final db = await database;
    List<Map<String, dynamic>> result = await db.query(
      'OfflinePermitAction',
      columns: ['actionJson', 'actionText'],
      where: 'permitId = ? AND actionText = ?',
      whereArgs: [permitId, 'transfer_permit'],
    );
    if (result.isNotEmpty) {
      Map<String, dynamic> fetchSurrenderData = result.first;

      Map<String, dynamic> actionJson =
          jsonDecode(fetchSurrenderData['actionJson']);
      return actionJson;
    } else {
      return {};
    }
  }

  Future<List<Map<String, dynamic>>> getInstructionsByScheduleId(
      String scheduleId) async {
    final db = await database;
    List<Map<String, dynamic>> result = await db.rawQuery('''
    SELECT permitId, tab7
    FROM OfflinePermit
    WHERE tab7 IS NOT NULL
  ''');

    List<Map<String, dynamic>> filteredInstructions = [];

    for (var row in result) {
      String permitId = row['permitId'];
      String tab7Json = row['tab7'];
      List<dynamic> tab7Data = jsonDecode(tab7Json);

      List<dynamic> matchingTabs = tab7Data.where((instruction) {
        return instruction['id'] == scheduleId;
      }).toList();

      for (var matchingTab in matchingTabs) {
        if (matchingTab.containsKey('instructions')) {
          List<dynamic> instructions = matchingTab['instructions'];

          for (var instruction in instructions) {
            Map<String, dynamic> instructionWithPermitId =
                Map<String, dynamic>.from(instruction);
            instructionWithPermitId['permitId'] = permitId;
            filteredInstructions.add(instructionWithPermitId);
          }
        }
      }
    }

    return filteredInstructions;
  }

  Future<List<Map<String, dynamic>>> getAllTab7Data() async {
    final db = await database; // Replace with your database reference
    List<Map<String, dynamic>> result = await db.rawQuery('''
    SELECT tab7
    FROM OfflinePermit
     WHERE tab7 IS NOT NULL
  ''');
    return result;
  }

  Future<void> updateInstructions(
      String instructionId,
      Map<String, dynamic> updatedInstruction,
      InstructionOperation operation) async {
    List<Map<String, dynamic>> result = await getAllTab7Data();
    bool operationCompleted = false;

    if (result.isNotEmpty) {
      // Iterate over all fetched rows
      for (var row in result) {
        if (row['tab7'] != null) {
          String tab7Json = row['tab7'];
          List<dynamic> tab7Data = jsonDecode(tab7Json);

          for (var item in tab7Data) {
            if (item['instructions'] != null) {
              List<dynamic> instructions =
                  List<dynamic>.from(item['instructions']);
              List<dynamic> updatedInstructions = [];

              for (var instruction in instructions) {
                switch (operation) {
                  case InstructionOperation.add:
                    updatedInstructions.add(instruction);
                    if (instruction['id'] == instructionId) {
                      updatedInstructions.add(updatedInstruction);
                      operationCompleted = true;
                    }
                    break;
                  case InstructionOperation.edit:
                    if (instruction['id'] == instructionId) {
                      updatedInstructions.add(updatedInstruction);
                      operationCompleted = true;
                    } else {
                      updatedInstructions.add(instruction);
                    }
                    break;
                  case InstructionOperation.moveUp:
                    // Implement move up logic
                    updatedInstructions =
                        _moveInstruction(instructions, instructionId, true);
                    operationCompleted = true;
                    break;
                  case InstructionOperation.moveDown:
                    // Implement move down logic
                    updatedInstructions =
                        _moveInstruction(instructions, instructionId, false);
                    operationCompleted = true;
                    break;
                  case InstructionOperation.delete:
                    if (instruction['id'] != instructionId) {
                      updatedInstructions.add(instruction);
                    } else {
                      operationCompleted = true;
                    }
                    break;
                }
              }

              // Update instructions in the item
              item['instructions'] = updatedInstructions;

              // Convert updated data to JSON
              String updatedTab7Json = jsonEncode(tab7Data);
              // log('updatedTab7Json $updatedTab7Json');
              // Update the tab7 data in the database
              final db = await database;
              await db.rawUpdate('''
            UPDATE OfflinePermit
            SET tab7 = ?
            WHERE permitId = ?  
          ''', [updatedTab7Json, row['permitId']]);

              // Exit after updating
              if (operationCompleted) break;
            }
          }
          if (operationCompleted) break;
        }
      }

      if (!operationCompleted) {
        throw Exception('Instruction with id $instructionId not found');
      }
    }
  }

  List<dynamic> _moveInstruction(
      List<dynamic> instructions, String instructionId, bool moveUp) {
    int index = instructions.indexWhere((inst) => inst['id'] == instructionId);
    if (index == -1 ||
        (moveUp && index == 0) ||
        (!moveUp && index == instructions.length - 1)) {
      return instructions;
    }

    var instruction = instructions.removeAt(index);
    if (moveUp) {
      instructions.insert(index - 1, instruction);
    } else {
      instructions.insert(index + 1, instruction);
    }
    return instructions;
  }

  //this is to show table data
  Future<List> getAllInstructions(ssid) async {
    Map<String, dynamic> offlinePermitData =
        await fetchPermitDetailsOffline("event.permitId");
    var temp = offlinePermitData['tab7'];
    var inst = [];
    for (var x = 0; x < temp.length; x++) {
      if (temp[x].id == ssid) {
        inst = temp[x]["instructions"];
        return inst;
      }
    }
    return inst;
  }

  // this is to update all data in tab7
  Future<void> updateTab7(String permitId, tab7) async {
    final db = await database;
    String updatedListPageJson = jsonEncode(tab7);
    await db.update('OfflinePermit', {'tab7': updatedListPageJson},
        where: 'permitId = ?', whereArgs: [permitId]);
    await insertOfflinePermitAction(
        permitId, 'switching_schedule', {}, "", null);
  }

  Future<int> getSSFromInstructionIndex(instId, permitId) async {
    var index = -1;
    Map<String, dynamic> offlinePermitData =
        await fetchPermitDetailsOffline(permitId);
    if (offlinePermitData.containsKey('tab7')) {
      List<dynamic> temp = offlinePermitData['tab7'];
      for (int a = 0; a < temp.length; a++) {
        List<dynamic>? instructions = temp[a]['instructions'];
        if (instructions != null) {
          for (int x = 0; x < instructions.length; x++) {
            dynamic instruction = instructions[x];
            if (instruction['id'] == instId) {
              index = a;
              break;
            }
          }
          if (index != -1) {
            break;
          }
        }
      }
    }
    return index;
  }

  Future<dynamic> addInstruction(data, instId, permitId, apiKey) async {
    data['instructionreceiveddatetime'] =
        data['instructionreceiveddate'] + ' ' + data['instructionreceivedtime'];
    data['carriedoutdatetime'] =
        data['carriedoutdate'] + ' ' + data['carriedouttime'];
    data['carriedoutconfirmeddatetime'] =
        data['carriedoutconfirmeddate'] + ' ' + data['carriedoutconfirmedtime'];

    Map<String, dynamic> offlinePermitData =
        await fetchPermitDetailsOffline(permitId);
    var temp = offlinePermitData['tab7'];
    int ssIndex = await getSSFromInstructionIndex(instId, permitId);
    var tempInstructions = [];
    var ss = temp[ssIndex];
    var instructions = ss["instructions"];
    DateTime dateTime = DateTime.now();
    Random random = Random();
    int randomValue = random.nextInt(100000);
    String maxInstructionId = '${dateTime.millisecondsSinceEpoch}$randomValue';
    data['id'] = EncryptData.encryptAESPrivateKey(maxInstructionId, apiKey);

    for (var x = 0; x < instructions.length; x++) {
      tempInstructions.add(instructions[x]);
      if (instructions[x]['id'] == instId) {
        tempInstructions.add(data);
      }
    }
    ss["instructions"] = tempInstructions;
    temp[ssIndex] = ss;
    await updateTab7(permitId, temp);
  }

  Future<void> upInstruction(String instId, String permitId) async {
    Map<String, dynamic> offlinePermitData =
        await fetchPermitDetailsOffline(permitId);
    var temp = offlinePermitData['tab7'];
    int ssIndex = await getSSFromInstructionIndex(instId, permitId);
    int currentIndex = -1;

    var ss = temp[ssIndex];
    var instructions = ss["instructions"];
    for (var x = 0; x < instructions.length; x++) {
      if (instructions[x]['id'] == instId) {
        currentIndex = x;
      }
    }
    if (currentIndex <= 0) return;
    var el = instructions[currentIndex];
    instructions[currentIndex] = instructions[currentIndex - 1];
    instructions[currentIndex - 1] = el;

    ss["instructions"] = instructions;
    temp[ssIndex] = ss;
    await updateTab7(permitId, temp);
  }

  Future<void> downInstruction(String instId, String permitId) async {
    Map<String, dynamic> offlinePermitData =
        await fetchPermitDetailsOffline(permitId);
    var temp = offlinePermitData['tab7'];
    int ssIndex = await getSSFromInstructionIndex(instId, permitId);
    int currentIndex = -1;

    var ss = temp[ssIndex];
    var instructions = ss["instructions"];
    for (var x = 0; x < instructions.length; x++) {
      if (instructions[x]['id'] == instId) {
        currentIndex = x;
      }
    }
    var el = instructions[currentIndex];
    instructions[currentIndex] = instructions[currentIndex + 1];
    instructions[currentIndex + 1] = el;
    ss["instructions"] = instructions;
    temp[ssIndex] = ss;
    await updateTab7(permitId, temp);
  }

  Future<void> deleteInstruction(instId, permitId) async {
    Map<String, dynamic> offlinePermitData =
        await fetchPermitDetailsOffline(permitId);
    var temp = offlinePermitData['tab7'];
    int ssIndex = await getSSFromInstructionIndex(instId, permitId);
    var tempInstructions = [];
    var ss = temp[ssIndex];
    var instructions = ss["instructions"];
    for (var x = 0; x < instructions.length; x++) {
      if (instructions[x]['id'] == instId) {
        tempInstructions.remove(instructions[x]);
      } else {
        tempInstructions.add(instructions[x]);
      }
    }
    ss["instructions"] = tempInstructions;
    temp[ssIndex] = ss;
    await updateTab7(permitId, temp);
  }

  Future<Map> getSSFromInstruction(instId, permitId) async {
    var ss = {};
    Map<String, dynamic> offlinePermitData =
        await fetchPermitDetailsOffline(permitId);
    var temp = offlinePermitData['tab7'];
    for (var a = 0; a < temp.length; a++) {
      var instructions = temp[a]["instructions"];

      if (instructions.length > 0) {
        for (var x = 0; x < instructions.length; x++) {
          if (instructions[x]['id'] == instId) {
            ss = temp[a];
            return ss;
          }
        }
      }
    }
    return ss;
  }

  Future<Map> getInstruction(instId, permitId) async {
    Map<String, dynamic> instruction = {};
    var ss = await getSSFromInstruction(instId, permitId);
    var instructions = ss["instructions"];
    if (instructions != null && instructions.length > 0) {
      for (var x = 0; x < instructions.length; x++) {
        if (instructions[x]['id'] == instId) {
          instruction = instructions[x];
        }
      }
    }
    return instruction;
  }

  Future<dynamic> editInstruction(data, instId, permitId) async {
    data['instructionreceiveddatetime'] =
        data['instructionreceiveddate'] + ' ' + data['instructionreceivedtime'];
    data['carriedoutdatetime'] =
        data['carriedoutdate'] + ' ' + data['carriedouttime'];
    data['carriedoutconfirmeddatetime'] =
        data['carriedoutconfirmeddate'] + ' ' + data['carriedoutconfirmedtime'];
    Map<String, dynamic> offlinePermitData =
        await fetchPermitDetailsOffline(permitId);
    var temp = offlinePermitData['tab7'];
    int ssIndex = await getSSFromInstructionIndex(instId, permitId);
    var tempInstructions = [];
    var ss = temp[ssIndex];
    var instructions = ss["instructions"];
    for (var x = 0; x < instructions.length; x++) {
      if (instructions[x]['id'] == instId) {
        tempInstructions.add(data);
      } else {
        tempInstructions.add(instructions[x]);
      }
    }
    ss["instructions"] = tempInstructions;
    temp[ssIndex] = ss;
    await updateTab7(permitId, temp);
  }

  Future<dynamic> editMultiSelectInstructions(data, instIds, permitId) async {
    Map<String, dynamic> offlinePermitData =
        await fetchPermitDetailsOffline(permitId);
    var temp = offlinePermitData['tab7'];

    var arr = instIds.split(',');
    for (var i = 0; i < arr.length; i++) {
      var ssIndex = await getSSFromInstructionIndex(arr[i], permitId);
      if (ssIndex >= 0) {
        var ss = temp[ssIndex];
        var instructions = ss["instructions"];

        for (var x = 0; x < instructions.length; x++) {
          if (instructions[x]['id'] == arr[i]) {
            instructions[x]['instructionreceivedby'] = 0;
            instructions[x]['controlengineerid'] = 0;
            instructions[x]['instructionreceivedbyname'] =
                data['instructionreceivedbyname'];
            instructions[x]['controlengineername'] =
                data['controlengineername'];

            instructions[x]['instructionreceiveddate'] =
                data['instructionreceiveddate'];
            instructions[x]['instructionreceivedtime'] =
                data['instructionreceivedtime'];

            instructions[x]['carriedoutdate'] = data['carriedoutdate'];
            instructions[x]['carriedouttime'] = data['carriedouttime'];

            instructions[x]['carriedoutconfirmeddate'] =
                data['carriedoutconfirmeddate'];
            instructions[x]['carriedoutconfirmedtime'] =
                data['carriedoutconfirmedtime'];

            instructions[x]['safetykeynumber'] = data['safetykeynumber'];
            instructions[x]['instructionreceiveddatetime'] =
                data['instructionreceiveddate'] +
                    ' ' +
                    data['instructionreceivedtime'];
            instructions[x]['carriedoutdatetime'] =
                data['carriedoutdate'] + ' ' + data['carriedouttime'];
            instructions[x]['carriedoutconfirmeddatetime'] =
                data['carriedoutconfirmeddate'] +
                    ' ' +
                    data['carriedoutconfirmedtime'];
          }
        }
      }
    }
    await updateTab7(permitId, temp);
  }
}
