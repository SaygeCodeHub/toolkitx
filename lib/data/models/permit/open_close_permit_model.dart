import 'dart:convert';

OpenClosePermitModel openClosePermitModelFromJson(String str) =>
    OpenClosePermitModel.fromJson(json.decode(str));

String openClosePermitModelToJson(OpenClosePermitModel data) =>
    json.encode(data.toJson());

class OpenClosePermitModel {
  final int status;
  final String? message;
  final Data data;

  OpenClosePermitModel(
      {required this.status, this.message, required this.data});

  factory OpenClosePermitModel.fromJson(Map<String, dynamic> json) =>
      OpenClosePermitModel(
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
