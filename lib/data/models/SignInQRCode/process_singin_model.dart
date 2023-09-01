import 'dart:convert';

ProcessSignInModel processSignInModelFromJson(String str) =>
    ProcessSignInModel.fromJson(json.decode(str));

String processSignInModelToJson(ProcessSignInModel data) =>
    json.encode(data.toJson());

class ProcessSignInModel {
  final int status;
  final String message;
  final Data data;

  ProcessSignInModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ProcessSignInModel.fromJson(Map<String, dynamic> json) =>
      ProcessSignInModel(
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
