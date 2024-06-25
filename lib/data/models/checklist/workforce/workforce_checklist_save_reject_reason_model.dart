import 'dart:convert';

PostRejectReasonsModel postRejectReasonsModelFromJson(String str) =>
    PostRejectReasonsModel.fromJson(json.decode(str));

String postRejectReasonsModelToJson(PostRejectReasonsModel data) =>
    json.encode(data.toJson());

class PostRejectReasonsModel {
  final int status;
  final String? message;
  final Data? data;

  PostRejectReasonsModel({
    required this.status,
    this.message,
    this.data,
  });

  factory PostRejectReasonsModel.fromJson(Map<String, dynamic> json) =>
      PostRejectReasonsModel(
        status: json["Status"],
        message: json["Message"],
        data: Data.fromJson(json["Data"]),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": data!.toJson(),
      };
}

class Data {
  Data();

  factory Data.fromJson(Map<String, dynamic> json) => Data();

  Map<String, dynamic> toJson() => {};
}
