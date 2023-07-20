import 'dart:convert';

FetchToDoDetailsModel fetchToDoDetailsModelFromJson(String str) =>
    FetchToDoDetailsModel.fromJson(json.decode(str));

String fetchToDoDetailsModelToJson(FetchToDoDetailsModel data) =>
    json.encode(data.toJson());

class FetchToDoDetailsModel {
  final int status;
  final String message;
  final ToDoDetailsData data;

  FetchToDoDetailsModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory FetchToDoDetailsModel.fromJson(Map<String, dynamic> json) =>
      FetchToDoDetailsModel(
        status: json["Status"],
        message: json["Message"],
        data: ToDoDetailsData.fromJson(json["Data"]),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": data.toJson(),
      };
}

class ToDoDetailsData {
  final String todo;
  final String id;
  final String category;
  final String heading;
  final String description;
  final String status;
  final String duedate;
  final String isdraft;

  ToDoDetailsData({
    required this.todo,
    required this.id,
    required this.category,
    required this.heading,
    required this.description,
    required this.status,
    required this.duedate,
    required this.isdraft,
  });

  factory ToDoDetailsData.fromJson(Map<String, dynamic> json) =>
      ToDoDetailsData(
        todo: json["todo"],
        id: json["id"],
        category: json["category"],
        heading: json["heading"],
        description: json["description"],
        status: json["status"],
        duedate: json["duedate"],
        isdraft: json["isdraft"],
      );

  Map<String, dynamic> toJson() => {
        "todo": todo,
        "id": id,
        "category": category,
        "heading": heading,
        "description": description,
        "status": status,
        "duedate": duedate,
        "isdraft": isdraft,
      };
}
