import 'dart:convert';

UpdateWorkOrderDetailsModel updateWorkOrderDetailsFromJson(String str) =>
    UpdateWorkOrderDetailsModel.fromJson(json.decode(str));

String updateWorkOrderDetailsToJson(UpdateWorkOrderDetailsModel data) =>
    json.encode(data.toJson());

class UpdateWorkOrderDetailsModel {
  final int status;
  final String message;
  final Data data;

  UpdateWorkOrderDetailsModel(
      {required this.status, required this.message, required this.data});

  factory UpdateWorkOrderDetailsModel.fromJson(Map<String, dynamic> json) =>
      UpdateWorkOrderDetailsModel(
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
