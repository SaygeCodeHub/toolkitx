import 'dart:convert';

CurrentLocationUpdateModel currentLocationUpdateModelFromJson(String str) =>
    CurrentLocationUpdateModel.fromJson(json.decode(str));

String currentLocationUpdateModelToJson(CurrentLocationUpdateModel data) =>
    json.encode(data.toJson());

class CurrentLocationUpdateModel {
  int status;
  String message;
  Data data;

  CurrentLocationUpdateModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory CurrentLocationUpdateModel.fromJson(Map<String, dynamic> json) =>
      CurrentLocationUpdateModel(
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
