import 'dart:convert';

UserProfileModel userProfileModelFromJson(String str) =>
    UserProfileModel.fromJson(json.decode(str));

String userProfileModelToJson(UserProfileModel data) =>
    json.encode(data.toJson());

class UserProfileModel {
  final int? status;
  final String? message;
  final UserProfileData? data;

  UserProfileModel({
    this.status,
    this.message,
    this.data,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) =>
      UserProfileModel(
        status: json["Status"],
        message: json["Message"],
        data: UserProfileData.fromJson(json["Data"]),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": data!.toJson(),
      };
}

class UserProfileData {
  final String lname;
  final String fname;
  final String email;
  final String? contact;
  final String? contact2;
  final String? bloodgrp;
  final String? sign;

  UserProfileData({
    required this.lname,
    required this.fname,
    required this.email,
    this.contact,
    this.contact2,
    this.bloodgrp,
    this.sign,
  });

  factory UserProfileData.fromJson(Map<String, dynamic> json) =>
      UserProfileData(
        lname: json["lname"],
        fname: json["fname"],
        email: json["email"],
        contact: json["contact"],
        contact2: json["contact2"],
        bloodgrp: json["bloodgrp"],
        sign: json["sign"],
      );

  Map<String, dynamic> toJson() => {
        "lname": lname,
        "fname": fname,
        "email": email,
        "contact": contact,
        "contact2": contact2,
        "bloodgrp": bloodgrp,
        "sign": sign,
      };
}
