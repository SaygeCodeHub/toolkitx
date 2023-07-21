import 'dart:convert';

SubmitToDoModel submitToDoModelFromJson(String str) =>
    SubmitToDoModel.fromJson(json.decode(str));

String submitToDoModelToJson(SubmitToDoModel data) =>
    json.encode(data.toJson());

class SubmitToDoModel {
  final int status;
  final String message;
  final Data data;

  SubmitToDoModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory SubmitToDoModel.fromJson(Map<String, dynamic> json) =>
      SubmitToDoModel(
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
