import 'dart:convert';

SaveAssetsReportFailureModel saveAssetsReportFailureModelFromJson(String str) => SaveAssetsReportFailureModel.fromJson(json.decode(str));

String saveAssetsReportFailureModelToJson(SaveAssetsReportFailureModel data) => json.encode(data.toJson());

class SaveAssetsReportFailureModel {
  final int status;
  final String message;
  final Data data;

  SaveAssetsReportFailureModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory SaveAssetsReportFailureModel.fromJson(Map<String, dynamic> json) => SaveAssetsReportFailureModel(
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

  factory Data.fromJson(Map<String, dynamic> json) => Data(
  );

  Map<String, dynamic> toJson() => {
  };
}
