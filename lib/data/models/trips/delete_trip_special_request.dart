import 'dart:convert';

DeleteTripSpecialRequestModel deleteTripSpecialRequestModelFromJson(
        String str) =>
    DeleteTripSpecialRequestModel.fromJson(json.decode(str));

String deleteTripSpecialRequestModelToJson(
        DeleteTripSpecialRequestModel data) =>
    json.encode(data.toJson());

class DeleteTripSpecialRequestModel {
  final int status;
  final String message;
  final Data data;

  DeleteTripSpecialRequestModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory DeleteTripSpecialRequestModel.fromJson(Map<String, dynamic> json) =>
      DeleteTripSpecialRequestModel(
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
