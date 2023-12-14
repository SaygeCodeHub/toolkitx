import 'dart:convert';

AddManageDocumentModel addManageDocumentModelFromJson(String str) =>
    AddManageDocumentModel.fromJson(json.decode(str));

String addManageDocumentModelToJson(AddManageDocumentModel data) =>
    json.encode(data.toJson());

class AddManageDocumentModel {
  final int status;
  final String message;
  final Data data;

  AddManageDocumentModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory AddManageDocumentModel.fromJson(Map<String, dynamic> json) =>
      AddManageDocumentModel(
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
