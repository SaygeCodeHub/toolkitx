import 'dart:convert';

FetchAssetsManageDocumentModel fetchAssetsManageDocumentModelFromJson(
        String str) =>
    FetchAssetsManageDocumentModel.fromJson(json.decode(str));

String fetchAssetsManageDocumentModelToJson(
        FetchAssetsManageDocumentModel data) =>
    json.encode(data.toJson());

class FetchAssetsManageDocumentModel {
  final int status;
  final String message;
  final List<ManageDocumentDatum> data;

  FetchAssetsManageDocumentModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory FetchAssetsManageDocumentModel.fromJson(Map<String, dynamic> json) =>
      FetchAssetsManageDocumentModel(
        status: json["Status"],
        message: json["Message"],
        data: List<ManageDocumentDatum>.from(json["Data"].map((x) => ManageDocumentDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class ManageDocumentDatum {
  final String docid;
  final String name;
  final String type;
  final dynamic files;

  ManageDocumentDatum({
    required this.docid,
    required this.name,
    required this.type,
    required this.files,
  });

  factory ManageDocumentDatum.fromJson(Map<String, dynamic> json) => ManageDocumentDatum(
        docid: json["docid"],
        name: json["name"],
        type: json["type"],
        files: json["files"],
      );

  Map<String, dynamic> toJson() => {
        "docid": docid,
        "name": name,
        "type": type,
        "files": files,
      };
}
