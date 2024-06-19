import 'dart:convert';

FetchMeetingBuildingFloorModel fetchMeetingBuildingFloorModelFromJson(String str) => FetchMeetingBuildingFloorModel.fromJson(json.decode(str));

String fetchMeetingBuildingFloorModelToJson(FetchMeetingBuildingFloorModel data) => json.encode(data.toJson());

class FetchMeetingBuildingFloorModel {
  final int status;
  final String message;
  final List<Datum> data;

  FetchMeetingBuildingFloorModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory FetchMeetingBuildingFloorModel.fromJson(Map<String, dynamic> json) => FetchMeetingBuildingFloorModel(
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
  final int id;
  final String floor;

  Datum({
    required this.id,
    required this.floor,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    floor: json["floor"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "floor": floor,
  };
}
