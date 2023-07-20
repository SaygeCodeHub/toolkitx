import 'dart:convert';

FetchToDoMasterModel toDoMarkAsDoneModelFromJson(String str) =>
    FetchToDoMasterModel.fromJson(json.decode(str));

String toDoMarkAsDoneModelToJson(FetchToDoMasterModel data) =>
    json.encode(data.toJson());

class FetchToDoMasterModel {
  final int status;
  final String message;
  final List<List<ToDoMasterDatum>> todoMasterDatum;

  FetchToDoMasterModel(
      {required this.status,
      required this.message,
      required this.todoMasterDatum});

  factory FetchToDoMasterModel.fromJson(Map<String, dynamic> json) =>
      FetchToDoMasterModel(
        status: json["Status"],
        message: json["Message"],
        todoMasterDatum: List<List<ToDoMasterDatum>>.from(json["Data"].map(
            (x) => List<ToDoMasterDatum>.from(
                x.map((x) => ToDoMasterDatum.fromJson(x))))),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": List<dynamic>.from(todoMasterDatum
            .map((x) => List<dynamic>.from(x.map((x) => x.toJson())))),
      };
}

class ToDoMasterDatum {
  final int id;
  final String name;
  final String notes;

  ToDoMasterDatum({
    required this.id,
    required this.name,
    required this.notes,
  });

  factory ToDoMasterDatum.fromJson(Map<String, dynamic> json) =>
      ToDoMasterDatum(
        id: json["id"],
        name: json["name"],
        notes: json["notes"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "notes": notes,
      };
}
