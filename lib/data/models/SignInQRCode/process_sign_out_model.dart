import 'dart:convert';

ProcessSignOutModel processSignOutModelFromJson(String str) =>
    ProcessSignOutModel.fromJson(json.decode(str));

String processSignOutModelToJson(ProcessSignOutModel data) =>
    json.encode(data.toJson());

class ProcessSignOutModel {
  final int status;
  final String message;
  final Data data;

  ProcessSignOutModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ProcessSignOutModel.fromJson(Map<String, dynamic> json) =>
      ProcessSignOutModel(
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
