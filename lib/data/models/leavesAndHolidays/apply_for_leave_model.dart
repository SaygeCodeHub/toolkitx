import 'dart:convert';

ApplyForLeaveModel applyForLeaveModelFromJson(String str) =>
    ApplyForLeaveModel.fromJson(json.decode(str));

String applyForLeaveModelToJson(ApplyForLeaveModel data) =>
    json.encode(data.toJson());

class ApplyForLeaveModel {
  final int status;
  final String message;
  final Data data;

  ApplyForLeaveModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ApplyForLeaveModel.fromJson(Map<String, dynamic> json) =>
      ApplyForLeaveModel(
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
