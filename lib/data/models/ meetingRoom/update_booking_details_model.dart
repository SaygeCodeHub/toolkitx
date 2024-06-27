import 'dart:convert';

UpdateBookingDetailsModel updateBookingDetailsModelFromJson(String str) =>
    UpdateBookingDetailsModel.fromJson(json.decode(str));

String updateBookingDetailsModelToJson(UpdateBookingDetailsModel data) =>
    json.encode(data.toJson());

class UpdateBookingDetailsModel {
  final int status;
  final String message;
  final Data data;

  UpdateBookingDetailsModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory UpdateBookingDetailsModel.fromJson(Map<String, dynamic> json) =>
      UpdateBookingDetailsModel(
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
