import 'dart:convert';

FetchLeavesDetailsModel fetchLeavesDetailsModelFromJson(String str) =>
    FetchLeavesDetailsModel.fromJson(json.decode(str));

String fetchLeavesDetailsModelToJson(FetchLeavesDetailsModel data) =>
    json.encode(data.toJson());

class FetchLeavesDetailsModel {
  final int status;
  final String message;
  final List<LeavesDetailsDatum> data;

  FetchLeavesDetailsModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory FetchLeavesDetailsModel.fromJson(Map<String, dynamic> json) =>
      FetchLeavesDetailsModel(
        status: json["Status"],
        message: json["Message"],
        data: List<LeavesDetailsDatum>.from(
            json["Data"].map((x) => LeavesDetailsDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class LeavesDetailsDatum {
  final String id;
  final String leavetype;
  final String schedule;
  final String applydate;
  final int totaldays;
  final int status;
  final String statustext;

  LeavesDetailsDatum({
    required this.id,
    required this.leavetype,
    required this.schedule,
    required this.applydate,
    required this.totaldays,
    required this.status,
    required this.statustext,
  });

  factory LeavesDetailsDatum.fromJson(Map<String, dynamic> json) =>
      LeavesDetailsDatum(
        id: json["id"],
        leavetype: json["leavetype"],
        schedule: json["schedule"],
        applydate: json["applydate"],
        totaldays: json["totaldays"],
        status: json["status"],
        statustext: json["statustext"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "leavetype": leavetype,
        "schedule": schedule,
        "applydate": applydate,
        "totaldays": totaldays,
        "status": status,
        "statustext": statustext,
      };
}
