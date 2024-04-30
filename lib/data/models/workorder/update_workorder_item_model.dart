
import 'dart:convert';

UpdateWorkOrderItemModel updateWorkOrderItemModelFromJson(String str) => UpdateWorkOrderItemModel.fromJson(json.decode(str));

String updateWorkOrderItemModelToJson(UpdateWorkOrderItemModel data) => json.encode(data.toJson());

class UpdateWorkOrderItemModel {
  final int status;
  final String message;
  final Data data;

  UpdateWorkOrderItemModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory UpdateWorkOrderItemModel.fromJson(Map<String, dynamic> json) => UpdateWorkOrderItemModel(
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

  factory Data.fromJson(Map<String, dynamic> json) => Data(
  );

  Map<String, dynamic> toJson() => {
  };
}
