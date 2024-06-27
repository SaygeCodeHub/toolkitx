import 'dart:convert';

UpdateTripSpecialRequestModel updateTripSpecialRequestModelFromJson(
        String str) =>
    UpdateTripSpecialRequestModel.fromJson(json.decode(str));

String updateTripSpecialRequestModelToJson(
        UpdateTripSpecialRequestModel data) =>
    json.encode(data.toJson());

class UpdateTripSpecialRequestModel {
  final int status;
  final String message;
  final Data data;

  UpdateTripSpecialRequestModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory UpdateTripSpecialRequestModel.fromJson(Map<String, dynamic> json) =>
      UpdateTripSpecialRequestModel(
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
