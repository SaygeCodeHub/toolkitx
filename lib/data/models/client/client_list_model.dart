import 'dart:convert';

ClientListModel clientListModelFromJson(String str) =>
    ClientListModel.fromJson(json.decode(str));

String clientListModelToJson(ClientListModel data) =>
    json.encode(data.toJson());

class ClientListModel {
  final int? status;
  final String? message;
  final List<ClientListData>? data;

  ClientListModel({
    this.status,
    this.message,
    this.data,
  });

  factory ClientListModel.fromJson(Map<String, dynamic> json) =>
      ClientListModel(
        status: json["Status"],
        message: json["Message"],
        data: List<ClientListData>.from(
            json["Data"].map((x) => ClientListData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class ClientListData {
  final int hashkey;
  final String hashimg;
  final String apikey;

  ClientListData({
    required this.hashkey,
    required this.hashimg,
    required this.apikey,
  });

  factory ClientListData.fromJson(Map<String, dynamic> json) => ClientListData(
        hashkey: json["hashkey"],
        hashimg: json["hashimg"],
        apikey: json["apikey"],
      );

  Map<String, dynamic> toJson() => {
        "hashkey": hashkey,
        "hashimg": hashimg,
        "apikey": apikey,
      };
}
