import 'dart:convert';

ManageWorkOrderMiscCostModel manageMiscCostModelFromJson(String str) =>
    ManageWorkOrderMiscCostModel.fromJson(json.decode(str));

String manageMiscCostModelToJson(ManageWorkOrderMiscCostModel data) =>
    json.encode(data.toJson());

class ManageWorkOrderMiscCostModel {
  final int status;
  final String message;
  final Data data;

  ManageWorkOrderMiscCostModel(
      {required this.status, required this.message, required this.data});

  factory ManageWorkOrderMiscCostModel.fromJson(Map<String, dynamic> json) =>
      ManageWorkOrderMiscCostModel(
        status: json["Status"],
        message: json["Message"],
        data: Data.fromJson(json["Data"]),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": data.toJson(),
      };
}

class Data {
  Data();

  factory Data.fromJson(Map<String, dynamic> json) => Data();

  Map<String, dynamic> toJson() => {};
}
