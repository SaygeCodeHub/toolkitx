import 'dart:convert';

FetchDataForChangePermitCpModel fetchDataForChangePermitCpModelFromJson(
        String str) =>
    FetchDataForChangePermitCpModel.fromJson(json.decode(str));

String fetchDataForChangePermitCpModelToJson(
        FetchDataForChangePermitCpModel data) =>
    json.encode(data.toJson());

class FetchDataForChangePermitCpModel {
  final int? status;
  final String? message;
  final List<List<GetDataForCPDatum>>? data;

  FetchDataForChangePermitCpModel({
    this.status,
    this.message,
    this.data,
  });

  factory FetchDataForChangePermitCpModel.fromJson(Map<String, dynamic> json) =>
      FetchDataForChangePermitCpModel(
        status: json["Status"],
        message: json["Message"],
        data: json["Data"] == null
            ? []
            : List<List<GetDataForCPDatum>>.from(json["Data"]!.map((x) =>
                List<GetDataForCPDatum>.from(
                    x.map((x) => GetDataForCPDatum.fromJson(x))))),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": data == null
            ? []
            : List<dynamic>.from(
                data!.map((x) => List<dynamic>.from(x.map((x) => x.toJson())))),
      };
}

class GetDataForCPDatum {
  final String? permitName;
  final String? showTransferWarning;
  final int? constructionId;
  final String? name;
  final String? constructionEmail;
  final int? userId;
  final String? userFullName;
  final String? userEmail;

  GetDataForCPDatum({
    this.permitName,
    this.showTransferWarning,
    this.constructionId,
    this.name,
    this.constructionEmail,
    this.userId,
    this.userFullName,
    this.userEmail,
  });

  factory GetDataForCPDatum.fromJson(Map<String, dynamic> json) =>
      GetDataForCPDatum(
        permitName: json["permit_name"],
        showTransferWarning: json["show_transfer_warning"],
        constructionId: json["construction_id"],
        name: json["name"],
        constructionEmail: json["construction_email"],
        userId: json["user_id"],
        userFullName: json["user_full_name"],
        userEmail: json["user_email"],
      );

  Map<String, dynamic> toJson() => {
        "permit_name": permitName,
        "show_transfer_warning": showTransferWarning,
        "construction_id": constructionId,
        "name": name,
        "construction_email": constructionEmail,
        "user_id": userId,
        "user_full_name": userFullName,
        "user_email": userEmail,
      };
}
