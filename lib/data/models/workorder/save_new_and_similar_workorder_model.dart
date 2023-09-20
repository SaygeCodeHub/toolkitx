import 'dart:convert';

SaveNewAndSimilarWorkOrderModel saveNewAndSimilarWorkOrderModelFromJson(
        String str) =>
    SaveNewAndSimilarWorkOrderModel.fromJson(json.decode(str));

String saveNewAndSimilarWorkOrderModelToJson(
        SaveNewAndSimilarWorkOrderModel data) =>
    json.encode(data.toJson());

class SaveNewAndSimilarWorkOrderModel {
  final int status;
  final String message;
  final Data data;

  SaveNewAndSimilarWorkOrderModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory SaveNewAndSimilarWorkOrderModel.fromJson(Map<String, dynamic> json) =>
      SaveNewAndSimilarWorkOrderModel(
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
