import 'dart:convert';

WorkorderAssignItemModel workorderAssignItemModelFromJson(String str) =>
    WorkorderAssignItemModel.fromJson(json.decode(str));

String workorderAssignItemModelToJson(WorkorderAssignItemModel data) =>
    json.encode(data.toJson());

class WorkorderAssignItemModel {
  final int status;
  final String message;
  final Data data;

  WorkorderAssignItemModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory WorkorderAssignItemModel.fromJson(Map<String, dynamic> json) =>
      WorkorderAssignItemModel(
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
