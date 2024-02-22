import 'dart:convert';

FetchEmployeesModel fetchEmployeeModelFromJson(String str) =>
    FetchEmployeesModel.fromJson(json.decode(str));

String fetchEmployeeModelToJson(FetchEmployeesModel data) =>
    json.encode(data.toJson());

class FetchEmployeesModel {
  final int status;
  final String message;
  final List<Datum> data;

  FetchEmployeesModel(
      {required this.status, required this.message, required this.data});

  factory FetchEmployeesModel.fromJson(Map<String, dynamic> json) =>
      FetchEmployeesModel(
          status: json["Status"],
          message: json["Message"],
          data: List<Datum>.from(json["Data"].map((x) => Datum.fromJson(x))));

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": List<dynamic>.from(data.map((x) => x.toJson()))
      };
}

class Datum {
  final String id;
  final String name;
  final String type;

  Datum({required this.id, required this.name, required this.type});

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"] ?? '',
        name: json["name"] ?? '',
        type: json["type"] ?? '',
      );

  Map<String, dynamic> toJson() => {"id": id, "name": name, "type": type};
}
