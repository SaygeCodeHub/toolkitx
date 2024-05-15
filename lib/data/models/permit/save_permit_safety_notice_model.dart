import 'dart:convert';

SavePermitEditSafetyDocumentModel openClosePermitModelFromJson(String str) =>
    SavePermitEditSafetyDocumentModel.fromJson(json.decode(str));

String openClosePermitModelToJson(SavePermitEditSafetyDocumentModel data) =>
    json.encode(data.toJson());

class SavePermitEditSafetyDocumentModel {
  final int status;
  final String? message;
  final Data data;

  SavePermitEditSafetyDocumentModel(
      {required this.status, this.message, required this.data});

  factory SavePermitEditSafetyDocumentModel.fromJson(
          Map<String, dynamic> json) =>
      SavePermitEditSafetyDocumentModel(
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
