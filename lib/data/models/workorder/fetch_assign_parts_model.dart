import 'dart:convert';

FetchAssignPartsModel fetchAssignPartsModelFromJson(String str) =>
    FetchAssignPartsModel.fromJson(json.decode(str));

String fetchAssignPartsModelToJson(FetchAssignPartsModel data) =>
    json.encode(data.toJson());

class FetchAssignPartsModel {
  final int status;
  final String message;
  final List<AddPartsDatum> data;

  FetchAssignPartsModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory FetchAssignPartsModel.fromJson(Map<String, dynamic> json) =>
      FetchAssignPartsModel(
        status: json["Status"],
        message: json["Message"],
        data: List<AddPartsDatum>.from(
            json["Data"].map((x) => AddPartsDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class AddPartsDatum {
  final String id;
  final String item;
  final String type;
  final String code;
  final dynamic plannedquan;

  AddPartsDatum({
    required this.id,
    required this.item,
    required this.type,
    required this.code,
    required this.plannedquan,
  });

  factory AddPartsDatum.fromJson(Map<String, dynamic> json) => AddPartsDatum(
        id: json["id"],
        item: json["item"],
        type: json["type"],
        code: json["code"],
        plannedquan: json["plannedquan"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "item": item,
        "type": type,
        "code": code,
        "plannedquan": plannedquan,
      };
}
