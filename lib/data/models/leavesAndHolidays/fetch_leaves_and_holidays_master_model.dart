import 'dart:convert';

FetchLeavesAndHolidaysMasterModel fetchLeavesAndHolidaysMasterModelFromJson(
        String str) =>
    FetchLeavesAndHolidaysMasterModel.fromJson(json.decode(str));

String fetchLeavesAndHolidaysMasterModelToJson(
        FetchLeavesAndHolidaysMasterModel data) =>
    json.encode(data.toJson());

class FetchLeavesAndHolidaysMasterModel {
  final int status;
  final String message;
  final List<List<LeavesMasterDatum>> data;

  FetchLeavesAndHolidaysMasterModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory FetchLeavesAndHolidaysMasterModel.fromJson(
          Map<String, dynamic> json) =>
      FetchLeavesAndHolidaysMasterModel(
        status: json["Status"],
        message: json["Message"],
        data: List<List<LeavesMasterDatum>>.from(json["Data"].map((x) =>
            List<LeavesMasterDatum>.from(
                x.map((x) => LeavesMasterDatum.fromJson(x))))),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": List<dynamic>.from(
            data.map((x) => List<dynamic>.from(x.map((x) => x.toJson())))),
      };
}

class LeavesMasterDatum {
  final int id;
  final String name;
  final int leaveperyear;
  final int active;

  LeavesMasterDatum({
    required this.id,
    required this.name,
    required this.leaveperyear,
    required this.active,
  });

  factory LeavesMasterDatum.fromJson(Map<String, dynamic> json) =>
      LeavesMasterDatum(
        id: json["id"],
        name: json["name"],
        leaveperyear: json["leaveperyear"] ?? 0,
        active: json["active"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "leaveperyear": leaveperyear,
        "active": active,
      };
}
