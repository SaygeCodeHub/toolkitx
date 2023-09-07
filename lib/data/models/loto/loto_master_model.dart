import 'dart:convert';

FetchLotoMasterModel fetchLotoMasterModelFromJson(String str) =>
    FetchLotoMasterModel.fromJson(json.decode(str));

String fetchLotoMasterModelToJson(FetchLotoMasterModel data) =>
    json.encode(data.toJson());

class FetchLotoMasterModel {
  final int status;
  final String message;
  final List<List<LotoMasterDatum>> data;

  FetchLotoMasterModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory FetchLotoMasterModel.fromJson(Map<String, dynamic> json) =>
      FetchLotoMasterModel(
        status: json["Status"],
        message: json["Message"],
        data: json["Data"] == null
            ? []
            : List<List<LotoMasterDatum>>.from(json["Data"].map((x) =>
                List<LotoMasterDatum>.from(
                    x.map((x) => LotoMasterDatum.fromJson(x))))),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": List<dynamic>.from(
            data.map((x) => List<dynamic>.from(x.map((x) => x.toJson())))),
      };
}

class LotoMasterDatum {
  final int id;
  final String name;
  final String emailName;
  final dynamic company;
  final dynamic status;
  final dynamic deleteUserId;
  final String lastAction;

  LotoMasterDatum({
    required this.id,
    required this.name,
    required this.emailName,
    required this.company,
    required this.status,
    required this.deleteUserId,
    required this.lastAction,
  });

  factory LotoMasterDatum.fromJson(Map<String, dynamic> json) =>
      LotoMasterDatum(
        id: json["id"],
        name: json["name"] ?? '',
        emailName: json["email_name"] ?? '',
        company: json["company"],
        status: json["status"],
        deleteUserId: json["delete_user_id"],
        lastAction: json["last_action"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email_name": emailName,
        "company": company,
        "status": status,
        "delete_user_id": deleteUserId,
        "last_action": lastAction,
      };
}
