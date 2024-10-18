import 'dart:convert';

SubmitNominationChecklistModel submitNomintionChecklistModelFromJson(
        String str) =>
    SubmitNominationChecklistModel.fromJson(json.decode(str));

String submitNomintionChecklistModelToJson(
        SubmitNominationChecklistModel data) =>
    json.encode(data.toJson());

class SubmitNominationChecklistModel {
  final int status;
  final String message;
  final Data data;

  SubmitNominationChecklistModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory SubmitNominationChecklistModel.fromJson(Map<String, dynamic> json) =>
      SubmitNominationChecklistModel(
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
