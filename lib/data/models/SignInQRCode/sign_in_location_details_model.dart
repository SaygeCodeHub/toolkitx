import 'dart:convert';

FetchLocationDetailsSignInModel fetchCurrentSignInModelFromJson(String str) =>
    FetchLocationDetailsSignInModel.fromJson(json.decode(str));

String fetchCurrentSignInModelToJson(FetchLocationDetailsSignInModel data) =>
    json.encode(data.toJson());

class FetchLocationDetailsSignInModel {
  final int status;
  final String message;
  final SignInLocationDetailsDatum data;

  FetchLocationDetailsSignInModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory FetchLocationDetailsSignInModel.fromJson(Map<String, dynamic> json) =>
      FetchLocationDetailsSignInModel(
        status: json["Status"],
        message: json["Message"],
        data: SignInLocationDetailsDatum.fromJson(json["Data"]),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": data.toJson(),
      };
}

class SignInLocationDetailsDatum {
  final List<dynamic> permit;
  final List<Workorder> workorder;
  final List<dynamic> loto;
  final List<dynamic> checklist;

  SignInLocationDetailsDatum({
    required this.permit,
    required this.workorder,
    required this.loto,
    required this.checklist,
  });

  factory SignInLocationDetailsDatum.fromJson(Map<String, dynamic> json) =>
      SignInLocationDetailsDatum(
        permit: List<dynamic>.from(json["permit"].map((x) => x)),
        workorder: List<Workorder>.from(
            json["workorder"].map((x) => Workorder.fromJson(x))),
        loto: List<dynamic>.from(json["loto"].map((x) => x)),
        checklist: List<dynamic>.from(json["checklist"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "permit": List<dynamic>.from(permit.map((x) => x)),
        "workorder": List<dynamic>.from(workorder.map((x) => x.toJson())),
        "loto": List<dynamic>.from(loto.map((x) => x)),
        "checklist": List<dynamic>.from(checklist.map((x) => x)),
      };
}

class Workorder {
  final String id;
  final String woname;
  final String contractorname;
  final String type;
  final String status;
  final String schedule;
  final String subject;

  Workorder({
    required this.id,
    required this.woname,
    required this.contractorname,
    required this.type,
    required this.status,
    required this.schedule,
    required this.subject,
  });

  factory Workorder.fromJson(Map<String, dynamic> json) => Workorder(
        id: json["id"],
        woname: json["woname"],
        contractorname: json["contractorname"],
        type: json["type"],
        status: json["status"],
        schedule: json["schedule"],
        subject: json["subject"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "woname": woname,
        "contractorname": contractorname,
        "type": type,
        "status": status,
        "schedule": schedule,
        "subject": subject,
      };
}
