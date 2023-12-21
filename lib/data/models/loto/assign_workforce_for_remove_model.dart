import 'dart:convert';

AssignWorkForceForRemoveModel assignWorkForceForRemoveModelFromJson(
        String str) =>
    AssignWorkForceForRemoveModel.fromJson(json.decode(str));

String assignWorkForceForRemoveModelToJson(
        AssignWorkForceForRemoveModel data) =>
    json.encode(data.toJson());

class AssignWorkForceForRemoveModel {
  final int status;
  final String message;
  final Data data;

  AssignWorkForceForRemoveModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory AssignWorkForceForRemoveModel.fromJson(Map<String, dynamic> json) =>
      AssignWorkForceForRemoveModel(
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
