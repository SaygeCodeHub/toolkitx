import 'dart:convert';

LanguageKeysModel getLanguageKeysModelFromJson(String str) =>
    LanguageKeysModel.fromJson(json.decode(str));

String getLanguageKeysModelToJson(LanguageKeysModel data) =>
    json.encode(data.toJson());

class LanguageKeysModel {
  final int status;
  final String? message;
  final Data? data;

  LanguageKeysModel({required this.status, this.message, this.data});

  factory LanguageKeysModel.fromJson(Map<String, dynamic> json) =>
      LanguageKeysModel(
          status: json["Status"],
          message: json["Message"],
          data: Data.fromJson(json["Data"]));

  Map<String, dynamic> toJson() =>
      {"Status": status, "Message": message, "Data": data!.toJson()};
}

class Data {
  final String languageid;
  final String currentdate;
  final List<Keys> keys;

  Data(
      {required this.languageid,
      required this.currentdate,
      required this.keys});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
      languageid: json["languageid"],
      currentdate: json["currentdate"],
      keys: List<Keys>.from(json["keys"].map((x) => Keys.fromJson(x))));

  Map<String, dynamic> toJson() => {
        "languageid": languageid,
        "currentdate": currentdate,
        "keys": List<dynamic>.from(keys.map((x) => x.toJson()))
      };
}

class Keys {
  final String key;
  final String? value;

  Keys({required this.key, this.value});

  factory Keys.fromJson(Map<String, dynamic> json) =>
      Keys(key: json["key"], value: json["value"]);

  Map<String, dynamic> toJson() => {"key": key, "value": value};
}
