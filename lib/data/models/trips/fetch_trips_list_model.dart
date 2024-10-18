import 'dart:convert';

FetchTripsListModel fetchTripsListModelFromJson(String str) =>
    FetchTripsListModel.fromJson(json.decode(str));

String fetchTripsListModelToJson(FetchTripsListModel data) =>
    json.encode(data.toJson());

class FetchTripsListModel {
  final int status;
  final String message;
  final List<TripDatum> data;

  FetchTripsListModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory FetchTripsListModel.fromJson(Map<String, dynamic> json) =>
      FetchTripsListModel(
        status: json["Status"],
        message: json["Message"],
        data: List<TripDatum>.from(
            json["Data"].map((x) => TripDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class TripDatum {
  final String id;
  final String departuredatetime;
  final String arrivaldatetime;
  final String vessel;
  final String deplocname;
  final String arrlocname;
  final String status;

  TripDatum({
    required this.id,
    required this.departuredatetime,
    required this.arrivaldatetime,
    required this.vessel,
    required this.deplocname,
    required this.arrlocname,
    required this.status,
  });

  factory TripDatum.fromJson(Map<String, dynamic> json) => TripDatum(
        id: json["id"],
        departuredatetime: json["departuredatetime"],
        arrivaldatetime: json["arrivaldatetime"],
        vessel: json["vessel"],
        deplocname: json["deplocname"],
        arrlocname: json["arrlocname"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "departuredatetime": departuredatetime,
        "arrivaldatetime": arrivaldatetime,
        "vessel": vessel,
        "deplocname": deplocname,
        "arrlocname": arrlocname,
        "status": status,
      };
}
