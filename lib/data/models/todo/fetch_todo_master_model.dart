import 'dart:convert';

FetchToDoMasterModel sendReminderTodoModelFromJson(String str) =>
    FetchToDoMasterModel.fromJson(json.decode(str));

String sendReminderTodoModelToJson(FetchToDoMasterModel data) =>
    json.encode(data.toJson());

class FetchToDoMasterModel {
  final int? status;
  final String? message;
  final List<List<ToDoMasterDatum>>? todoFetchMasterDatum;

  FetchToDoMasterModel({
    this.status,
    this.message,
    this.todoFetchMasterDatum,
  });

  factory FetchToDoMasterModel.fromJson(Map<String, dynamic> json) =>
      FetchToDoMasterModel(
        status: json["Status"],
        message: json["Message"],
        todoFetchMasterDatum: List<List<ToDoMasterDatum>>.from(json["Data"].map(
            (x) => List<ToDoMasterDatum>.from(
                x.map((x) => ToDoMasterDatum.fromJson(x))))),
      );

  Map<String, dynamic> toJson() =>
      {
        "Status": status,
        "Message": message,
        "Data": List<dynamic>.from(todoFetchMasterDatum!
            .map((x) => List<dynamic>.from(x.map((x) => x.toJson())))),
      };
}

class ToDoMasterDatum {
  final dynamic id;
  final String name;
  final String assigned;
  final String completed;

  ToDoMasterDatum({
    this.id,
    required this.name,
    required this.assigned,
    required this.completed,
  });

  factory ToDoMasterDatum.fromJson(Map<String, dynamic> json) =>
      ToDoMasterDatum(
        id: json["id"],
        name: json["name"] ?? '',
        assigned: json["assigned"] ?? '',
        completed: json["completed"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "assigned": assigned,
        "completed": completed,
      };
}
