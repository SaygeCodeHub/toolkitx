import 'dart:convert';

DeleteItemTabItemModel deleteItemTabItemModelFromJson(String str) =>
    DeleteItemTabItemModel.fromJson(json.decode(str));

String deleteItemTabItemModelToJson(DeleteItemTabItemModel data) =>
    json.encode(data.toJson());

class DeleteItemTabItemModel {
  final int status;
  final String message;
  final Data data;

  DeleteItemTabItemModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory DeleteItemTabItemModel.fromJson(Map<String, dynamic> json) =>
      DeleteItemTabItemModel(
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
