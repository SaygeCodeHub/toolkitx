import 'dart:convert';

FetchLeavesSummaryModel fetchLeavesSummaryModelFromJson(String str) =>
    FetchLeavesSummaryModel.fromJson(json.decode(str));

String fetchLeavesSummaryModelToJson(FetchLeavesSummaryModel data) =>
    json.encode(data.toJson());

class FetchLeavesSummaryModel {
  final int status;
  final String message;
  final List<LeavesSummaryDatum> data;

  FetchLeavesSummaryModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory FetchLeavesSummaryModel.fromJson(Map<String, dynamic> json) =>
      FetchLeavesSummaryModel(
        status: json["Status"],
        message: json["Message"],
        data: List<LeavesSummaryDatum>.from(
            json["Data"].map((x) => LeavesSummaryDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class LeavesSummaryDatum {
  final String name;
  final dynamic totalleaves;
  final dynamic balanceleave;
  final int leavesapprovedbynottaken;
  final int leavetaken;
  final int leaverequested;
  final int leavesrejected;

  LeavesSummaryDatum({
    required this.name,
    this.totalleaves,
    this.balanceleave,
    required this.leavesapprovedbynottaken,
    required this.leavetaken,
    required this.leaverequested,
    required this.leavesrejected,
  });

  factory LeavesSummaryDatum.fromJson(Map<String, dynamic> json) =>
      LeavesSummaryDatum(
        name: json["name"],
        totalleaves: json["totalleaves"],
        balanceleave: json["balanceleave"],
        leavesapprovedbynottaken: json["leavesapprovedbynottaken"],
        leavetaken: json["leavetaken"],
        leaverequested: json["leaverequested"],
        leavesrejected: json["leavesrejected"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "totalleaves": totalleaves,
        "balanceleave": balanceleave,
        "leavesapprovedbynottaken": leavesapprovedbynottaken,
        "leavetaken": leavetaken,
        "leaverequested": leaverequested,
        "leavesrejected": leavesrejected,
      };
}
