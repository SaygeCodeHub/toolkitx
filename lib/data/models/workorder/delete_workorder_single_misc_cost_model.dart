import 'dart:convert';

DeleteWorkOrderSingleMiscCostModel deleteWorkOrderSingleMiscCostFromJson(
        String str) =>
    DeleteWorkOrderSingleMiscCostModel.fromJson(json.decode(str));

String deleteWorkOrderSingleMiscCostToJson(
        DeleteWorkOrderSingleMiscCostModel data) =>
    json.encode(data.toJson());

class DeleteWorkOrderSingleMiscCostModel {
  final int status;
  final String message;
  final Data data;

  DeleteWorkOrderSingleMiscCostModel(
      {required this.status, required this.message, required this.data});

  factory DeleteWorkOrderSingleMiscCostModel.fromJson(
          Map<String, dynamic> json) =>
      DeleteWorkOrderSingleMiscCostModel(
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
