import 'dart:convert';

AddLotoCommentModel addLotoCommentModelFromJson(String str) =>
    AddLotoCommentModel.fromJson(json.decode(str));

String addLotoCommentModelToJson(AddLotoCommentModel data) =>
    json.encode(data.toJson());

class AddLotoCommentModel {
  final int status;
  final String message;
  final Data data;

  AddLotoCommentModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory AddLotoCommentModel.fromJson(Map<String, dynamic> json) =>
      AddLotoCommentModel(
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
