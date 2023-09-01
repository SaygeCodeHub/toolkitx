import 'dart:convert';

FetchLocationDetailsSignInModel fetchLocationDetailsSignInModelFromJson(
        String str) =>
    FetchLocationDetailsSignInModel.fromJson(json.decode(str));

String fetchLocationDetailsSignInModelToJson(
        FetchLocationDetailsSignInModel data) =>
    json.encode(data.toJson());

class FetchLocationDetailsSignInModel {
  final int status;
  final String message;
  final Data data;

  FetchLocationDetailsSignInModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory FetchLocationDetailsSignInModel.fromJson(Map<String, dynamic> json) =>
      FetchLocationDetailsSignInModel(
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
  final List<Permit>? permit;
  final List<Workorder>? workorder;
  final List<Loto>? loto;
  final List<Checklist>? checklist;

  Data({
    this.permit,
    this.workorder,
    this.loto,
    this.checklist,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        permit:
            List<Permit>.from(json["permit"].map((x) => Permit.fromJson(x))),
        workorder: List<Workorder>.from(
            json["workorder"].map((x) => Workorder.fromJson(x))),
        loto: List<Loto>.from(json["loto"].map((x) => Loto.fromJson(x))),
        checklist: List<Checklist>.from(
            json["checklist"].map((x) => Checklist.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "permit": List<dynamic>.from(permit!.map((x) => x.toJson())),
        "workorder": List<dynamic>.from(workorder!.map((x) => x.toJson())),
        "loto": List<dynamic>.from(loto!.map((x) => x.toJson())),
        "checklist": List<dynamic>.from(checklist!.map((x) => x.toJson())),
      };
}

class Checklist {
  final String id;
  final String name;
  final int responsecount;
  final String categoryname;
  final String subcategoryname;

  Checklist({
    required this.id,
    required this.name,
    required this.responsecount,
    required this.categoryname,
    required this.subcategoryname,
  });

  factory Checklist.fromJson(Map<String, dynamic> json) => Checklist(
        id: json["id"],
        name: json["name"],
        responsecount: json["responsecount"],
        categoryname: json["categoryname"] ?? '',
        subcategoryname: json["subcategoryname"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "responsecount": responsecount,
        "categoryname": categoryname,
        "subcategoryname": subcategoryname,
      };
}

class Loto {
  final String id;
  final String name;
  final String date;
  final String location;
  final String purpose;
  final String status;

  Loto({
    required this.id,
    required this.name,
    required this.date,
    required this.location,
    required this.purpose,
    required this.status,
  });

  factory Loto.fromJson(Map<String, dynamic> json) => Loto(
        id: json["id"],
        name: json["name"],
        date: json["date"],
        location: json["location"],
        purpose: json["purpose"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "date": date,
        "location": location,
        "purpose": purpose,
        "status": status,
      };
}

class Permit {
  final String id;
  final String permit;
  final String schedule;
  final String location;
  final String description;
  final String status;
  final String pcompany;

  Permit({
    required this.id,
    required this.permit,
    required this.schedule,
    required this.location,
    required this.description,
    required this.status,
    required this.pcompany,
  });

  factory Permit.fromJson(Map<String, dynamic> json) => Permit(
        id: json["id"],
        permit: json["permit"],
        schedule: json["schedule"],
        location: json["location"],
        description: json["description"],
        status: json["status"],
        pcompany: json["pcompany"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "permit": permit,
        "schedule": schedule,
        "location": location,
        "description": description,
        "status": status,
        "pcompany": pcompany,
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
