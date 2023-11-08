import 'dart:convert';

FetchAssetsCommentsModel fetchAssetsCommentsModelFromJson(String str) =>
    FetchAssetsCommentsModel.fromJson(json.decode(str));

String fetchAssetsCommentsModelToJson(FetchAssetsCommentsModel data) =>
    json.encode(data.toJson());

class FetchAssetsCommentsModel {
  final int status;
  final String message;
  final List<Datum> data;

  FetchAssetsCommentsModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory FetchAssetsCommentsModel.fromJson(Map<String, dynamic> json) =>
      FetchAssetsCommentsModel(
        status: json["Status"],
        message: json["Message"],
        data: List<Datum>.from(json["Data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  final String ownername;
  final String created;
  final String files;
  final String comment;

  Datum({
    required this.ownername,
    required this.created,
    required this.files,
    required this.comment,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        ownername: json["ownername"] ?? "",
        created: json["created"] ?? "",
        files: json["files"] ?? "",
        comment: json["comment"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "ownername": ownername,
        "created": created,
        "files": files,
        "comment": comment,
      };
}
