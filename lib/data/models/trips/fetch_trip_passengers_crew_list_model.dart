import 'dart:convert';

FetchTripPassengersCrewListModel fetchTripPassengersCrewListModelFromJson(
        String str) =>
    FetchTripPassengersCrewListModel.fromJson(json.decode(str));

String fetchTripPassengersCrewListModelToJson(
        FetchTripPassengersCrewListModel data) =>
    json.encode(data.toJson());

class FetchTripPassengersCrewListModel {
  final int status;
  final String message;
  final List<PassengerCrewDatum> data;

  FetchTripPassengersCrewListModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory FetchTripPassengersCrewListModel.fromJson(
          Map<String, dynamic> json) =>
      FetchTripPassengersCrewListModel(
        status: json["Status"],
        message: json["Message"],
        data: List<PassengerCrewDatum>.from(
            json["Data"].map((x) => PassengerCrewDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class PassengerCrewDatum {
  final String id;
  final String name;

  PassengerCrewDatum({
    required this.id,
    required this.name,
  });

  factory PassengerCrewDatum.fromJson(Map<String, dynamic> json) =>
      PassengerCrewDatum(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
