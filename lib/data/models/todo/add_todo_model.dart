import 'dart:convert';

AddToDoModel addToDoModelFromJson(String str) =>
    AddToDoModel.fromJson(json.decode(str));

String addToDoModelToJson(AddToDoModel data) => json.encode(data.toJson());

class AddToDoModel {
  final int status;
  final String message;
  final Data data;

  AddToDoModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory AddToDoModel.fromJson(Map<String, dynamic> json) => AddToDoModel(
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
