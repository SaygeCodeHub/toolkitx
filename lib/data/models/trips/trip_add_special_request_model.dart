
import 'dart:convert';

TripAddSpecialRequestModel tripAddSpecialRequestModelFromJson(String str) => TripAddSpecialRequestModel.fromJson(json.decode(str));

String tripAddSpecialRequestModelToJson(TripAddSpecialRequestModel data) => json.encode(data.toJson());

class TripAddSpecialRequestModel {
  final int status;
  final String message;
  final Data data;

  TripAddSpecialRequestModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory TripAddSpecialRequestModel.fromJson(Map<String, dynamic> json) => TripAddSpecialRequestModel(
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
