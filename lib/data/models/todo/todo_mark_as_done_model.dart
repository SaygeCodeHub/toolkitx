import 'dart:convert';

ToDoMarkAsDoneModel toDoMarkAsDoneModelFromJson(String str) =>
    ToDoMarkAsDoneModel.fromJson(json.decode(str));

String toDoMarkAsDoneModelToJson(ToDoMarkAsDoneModel data) =>
    json.encode(data.toJson());

class ToDoMarkAsDoneModel {
  final int status;
  final String message;
  final Data data;

  ToDoMarkAsDoneModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ToDoMarkAsDoneModel.fromJson(Map<String, dynamic> json) =>
      ToDoMarkAsDoneModel(
        status: json["Status"],
        message: json["Message"],
        data: Data.fromJson(json["Data"]),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": data.toJson(),
      };
}

class Data {
  Data();

  factory Data.fromJson(Map<String, dynamic> json) => Data();

  Map<String, dynamic> toJson() => {};
}
