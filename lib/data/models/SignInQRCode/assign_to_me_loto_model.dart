import 'dart:convert';

AssignToMeLotoModel assignToMeLotoModelFromJson(String str) =>
    AssignToMeLotoModel.fromJson(json.decode(str));

String assignToMeLotoModelToJson(AssignToMeLotoModel data) =>
    json.encode(data.toJson());

class AssignToMeLotoModel {
  final int status;
  final String message;
  final Data data;

  AssignToMeLotoModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory AssignToMeLotoModel.fromJson(Map<String, dynamic> json) =>
      AssignToMeLotoModel(
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
