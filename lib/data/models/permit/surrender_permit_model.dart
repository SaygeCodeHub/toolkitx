import 'dart:convert';

SurrenderPermitModel openClosePermitModelFromJson(String str) =>
    SurrenderPermitModel.fromJson(json.decode(str));

String openClosePermitModelToJson(SurrenderPermitModel data) =>
    json.encode(data.toJson());

class SurrenderPermitModel {
  final int status;
  final String? message;
  final Data data;

  SurrenderPermitModel(
      {required this.status, this.message, required this.data});

  factory SurrenderPermitModel.fromJson(Map<String, dynamic> json) =>
      SurrenderPermitModel(
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
