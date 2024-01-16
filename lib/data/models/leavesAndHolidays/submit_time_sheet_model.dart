import 'dart:convert';

SubmitTimeSheetModel submitTimeSheetModelFromJson(String str) => SubmitTimeSheetModel.fromJson(json.decode(str));

String submitTimeSheetModelToJson(SubmitTimeSheetModel data) => json.encode(data.toJson());

class SubmitTimeSheetModel {
  int status;
  String message;
  Data data;

  SubmitTimeSheetModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory SubmitTimeSheetModel.fromJson(Map<String, dynamic> json) => SubmitTimeSheetModel(
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
