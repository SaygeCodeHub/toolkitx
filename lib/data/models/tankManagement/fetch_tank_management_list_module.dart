import 'dart:convert';

FetchTankManagementListModel fetchTankManagementListModelFromJson(String str) =>
    FetchTankManagementListModel.fromJson(json.decode(str));

String fetchTankManagementListModelToJson(FetchTankManagementListModel data) =>
    json.encode(data.toJson());

class FetchTankManagementListModel {
  final int status;
  final String message;
  final List<Datum> data;

  FetchTankManagementListModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory FetchTankManagementListModel.fromJson(Map<String, dynamic> json) =>
      FetchTankManagementListModel(
        status: json["Status"],
        message: json["Message"],
        data: List<Datum>.from(json["Data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  final String id;
  final String nominationNo;
  final String date;
  final String announce;
  final String contractname;
  final String status;

  Datum({
    required this.id,
    required this.nominationNo,
    required this.date,
    required this.announce,
    required this.contractname,
    required this.status,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        nominationNo: json["nomination_no"],
        date: json["date"],
        announce: json["announce"],
        contractname: json["contractname"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nomination_no": nominationNo,
        "date": date,
        "announce": announce,
        "contractname": contractname,
        "status": status,
      };
}
