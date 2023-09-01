import 'dart:convert';

AssignToMePermitModel assignToMePermitModelFromJson(String str) =>
    AssignToMePermitModel.fromJson(json.decode(str));

String assignToMePermitModelToJson(AssignToMePermitModel data) =>
    json.encode(data.toJson());

class AssignToMePermitModel {
  final int status;
  final String message;
  final Data data;

  AssignToMePermitModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory AssignToMePermitModel.fromJson(Map<String, dynamic> json) =>
      AssignToMePermitModel(
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
