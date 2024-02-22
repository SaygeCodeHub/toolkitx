import 'dart:convert';

SaveCustomParameterModel saveCustomParameterModelFromJson(String str) =>
    SaveCustomParameterModel.fromJson(json.decode(str));

String saveCustomParameterModelToJson(SaveCustomParameterModel data) =>
    json.encode(data.toJson());

class SaveCustomParameterModel {
  final int status;
  final String message;
  final Data data;

  SaveCustomParameterModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory SaveCustomParameterModel.fromJson(Map<String, dynamic> json) =>
      SaveCustomParameterModel(
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
