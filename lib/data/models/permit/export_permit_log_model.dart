import 'dart:convert';

ExportPermitLogModel exportPermitLogModelFromJson(String str) =>
    ExportPermitLogModel.fromJson(json.decode(str));

String exportPermitLogModelToJson(ExportPermitLogModel data) =>
    json.encode(data.toJson());

class ExportPermitLogModel {
  final int status;
  final String? message;
  final Data data;

  ExportPermitLogModel(
      {required this.status, this.message, required this.data});

  factory ExportPermitLogModel.fromJson(Map<String, dynamic> json) =>
      ExportPermitLogModel(
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
