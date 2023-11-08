import 'dart:convert';

UpdateExpenseModel updateExpenseModelFromJson(String str) =>
    UpdateExpenseModel.fromJson(json.decode(str));

String updateExpenseModelToJson(UpdateExpenseModel data) =>
    json.encode(data.toJson());

class UpdateExpenseModel {
  final int status;
  final String message;
  final Data data;

  UpdateExpenseModel(
      {required this.status, required this.message, required this.data});

  factory UpdateExpenseModel.fromJson(Map<String, dynamic> json) =>
      UpdateExpenseModel(
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
