import 'dart:convert';

UpdateUserProfileModel updateUserProfileModelFromJson(String str) =>
    UpdateUserProfileModel.fromJson(json.decode(str));

String updateUserProfileModelToJson(UpdateUserProfileModel data) =>
    json.encode(data.toJson());

class UpdateUserProfileModel {
  final int? status;
  final String? message;
  final Data? data;

  UpdateUserProfileModel({
    this.status,
    this.message,
    this.data,
  });

  factory UpdateUserProfileModel.fromJson(Map<String, dynamic> json) =>
      UpdateUserProfileModel(
        status: json["Status"],
        message: json["Message"],
        data: Data.fromJson(json["Data"]),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": data!.toJson(),
      };
}

class Data {
  Data();

  factory Data.fromJson(Map<String, dynamic> json) => Data();

  Map<String, dynamic> toJson() => {};
}
