
import 'dart:convert';

SignInUnathorizedModel signInUnathorizedModelFromJson(String str) => SignInUnathorizedModel.fromJson(json.decode(str));

String signInUnathorizedModelToJson(SignInUnathorizedModel data) => json.encode(data.toJson());

class SignInUnathorizedModel {
  final int status;
  final String message;
  final Data data;

  SignInUnathorizedModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory SignInUnathorizedModel.fromJson(Map<String, dynamic> json) => SignInUnathorizedModel(
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
