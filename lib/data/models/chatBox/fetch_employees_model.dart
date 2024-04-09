import 'dart:convert';

FetchEmployeesModel fetchEmployeeModelFromJson(String str) =>
    FetchEmployeesModel.fromJson(json.decode(str));

String fetchEmployeeModelToJson(FetchEmployeesModel data) =>
    json.encode(data.toJson());

class FetchEmployeesModel {
  final int status;
  final String message;
  final List<EmployeesDatum> data;

  FetchEmployeesModel(
      {required this.status, required this.message, required this.data});

  factory FetchEmployeesModel.fromJson(Map<String, dynamic> json) =>
      FetchEmployeesModel(
          status: json["Status"],
          message: json["Message"],
          data: List<EmployeesDatum>.from(
              json["Data"].map((x) => EmployeesDatum.fromJson(x))));

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": List<dynamic>.from(data.map((x) => x.toJson()))
      };
}

class EmployeesDatum {
  final int id;
  final String name;
  final int type;

  EmployeesDatum({required this.id, required this.name, required this.type});

  factory EmployeesDatum.fromJson(Map<String, dynamic> json) => EmployeesDatum(
        id: json["id"] ?? 0,
        name: json["name"] ?? '',
        type: json["type"] ?? 0,
      );

  Map<String, dynamic> toJson() => {"id": id, "name": name, "type": type};
}
