import 'dart:convert';

PostDocumentsModel saveLinkedDocumentsModelFromJson(String str) =>
    PostDocumentsModel.fromJson(json.decode(str));

String saveLinkedDocumentsModelToJson(PostDocumentsModel data) =>
    json.encode(data.toJson());

class PostDocumentsModel {
  final int status;
  final String message;
  final Data data;

  PostDocumentsModel(
      {required this.status, required this.message, required this.data});

  factory PostDocumentsModel.fromJson(Map<String, dynamic> json) =>
      PostDocumentsModel(
          status: json["Status"],
          message: json["Message"],
          data: Data.fromJson(json["Data"]));

  Map<String, dynamic> toJson() =>
      {"Status": status, "Message": message, "Data": data.toJson()};
}

class Data {
  Data();

  factory Data.fromJson(Map<String, dynamic> json) => Data();

  Map<String, dynamic> toJson() => {};
}
