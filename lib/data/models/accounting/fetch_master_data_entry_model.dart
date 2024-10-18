import 'dart:convert';

FetchMasterDataEntryModel fetchMasterDataEntryModelFromJson(String str) =>
    FetchMasterDataEntryModel.fromJson(json.decode(str));

String fetchMasterDataEntryModelToJson(FetchMasterDataEntryModel data) =>
    json.encode(data.toJson());

class FetchMasterDataEntryModel {
  final int? status;
  final String? message;
  final List<List<ClientDatum>> data;

  FetchMasterDataEntryModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory FetchMasterDataEntryModel.fromJson(Map<String, dynamic> json) =>
      FetchMasterDataEntryModel(
        status: json["Status"],
        message: json["Message"],
        data: List<List<ClientDatum>>.from(json["Data"].map((x) =>
            List<ClientDatum>.from(x.map((x) => ClientDatum.fromJson(x))))),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": List<dynamic>.from(
            data.map((x) => List<dynamic>.from(x.map((x) => x.toJson())))),
      };
}

class ClientDatum {
  final int id;
  final String? name;
  final List<Project>? projects;
  final String? cardname;
  final String? bankname;

  ClientDatum({
    required this.id,
    this.name,
    this.projects,
    this.cardname,
    this.bankname,
  });

  factory ClientDatum.fromJson(Map<String, dynamic> json) => ClientDatum(
        id: json["id"],
        name: json["name"],
        projects: json["projects"] == null
            ? []
            : List<Project>.from(
                json["projects"]!.map((x) => Project.fromJson(x))),
        cardname: json["cardname"],
        bankname: json["bankname"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "projects": projects == null
            ? []
            : List<dynamic>.from(projects!.map((x) => x.toJson())),
        "cardname": cardname,
        "bankname": bankname,
      };
}

class Project {
  final int id;
  final String name;

  Project({
    required this.id,
    required this.name,
  });

  factory Project.fromJson(Map<String, dynamic> json) => Project(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
