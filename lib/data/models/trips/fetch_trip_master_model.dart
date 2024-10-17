import 'dart:convert';

FetchTripMasterModel fetchTripMasterModelFromJson(String str) =>
    FetchTripMasterModel.fromJson(json.decode(str));

String fetchTripMasterModelToJson(FetchTripMasterModel data) =>
    json.encode(data.toJson());

class FetchTripMasterModel {
  final int status;
  final String message;
  final List<List<MasterDatum>> data;

  FetchTripMasterModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory FetchTripMasterModel.fromJson(Map<String, dynamic> json) =>
      FetchTripMasterModel(
        status: json["Status"],
        message: json["Message"],
        data: List<List<MasterDatum>>.from(json["Data"].map((x) =>
            List<MasterDatum>.from(x.map((x) => MasterDatum.fromJson(x))))),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": List<dynamic>.from(
            data.map((x) => List<dynamic>.from(x.map((x) => x.toJson())))),
      };
}

class MasterDatum {
  final dynamic id;
  final String vessel;
  final String name;
  final String matrix;
  final dynamic matrix2;
  final String matrix3;

  MasterDatum({
    required this.id,
    required this.vessel,
    required this.name,
    required this.matrix,
    required this.matrix2,
    required this.matrix3,
  });

  factory MasterDatum.fromJson(Map<String, dynamic> json) => MasterDatum(
        id: json["id"] ?? '',
        vessel: json["vessel"] ?? '',
        name: json["name"] ?? '',
        matrix: json["matrix"] ?? '',
        matrix2: json["matrix2"] ?? '',
        matrix3: json["matrix3"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "vessel": vessel,
        "name": name,
        "matrix": matrix,
        "matrix2": matrix2,
        "matrix3": matrix3,
      };
}
