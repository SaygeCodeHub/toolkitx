import 'dart:convert';

SaveAssetsMeterReadingModel saveAssetsMeterReadingModelFromJson(String str) => SaveAssetsMeterReadingModel.fromJson(json.decode(str));

String saveAssetsMeterReadingModelToJson(SaveAssetsMeterReadingModel data) => json.encode(data.toJson());

class SaveAssetsMeterReadingModel {
  final int status;
  final String message;
  final Data data;

  SaveAssetsMeterReadingModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory SaveAssetsMeterReadingModel.fromJson(Map<String, dynamic> json) => SaveAssetsMeterReadingModel(
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
