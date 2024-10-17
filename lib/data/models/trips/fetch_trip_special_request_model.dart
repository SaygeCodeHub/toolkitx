import 'dart:convert';

FetchTripSpecialRequestModel fetchTripSpecialRequestModelFromJson(String str) =>
    FetchTripSpecialRequestModel.fromJson(json.decode(str));

String fetchTripSpecialRequestModelToJson(FetchTripSpecialRequestModel data) =>
    json.encode(data.toJson());

class FetchTripSpecialRequestModel {
  final int status;
  final String message;
  final Data data;

  FetchTripSpecialRequestModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory FetchTripSpecialRequestModel.fromJson(Map<String, dynamic> json) =>
      FetchTripSpecialRequestModel(
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
  final String id;
  final String specialrequest;
  final String specialrequesttypename;
  final String createdforname;
  final String statustext;
  final String createdfor;
  final String specialrequesttypeid;

  Data({
    required this.id,
    required this.specialrequest,
    required this.specialrequesttypename,
    required this.createdforname,
    required this.statustext,
    required this.createdfor,
    required this.specialrequesttypeid,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        specialrequest: json["specialrequest"],
        specialrequesttypename: json["specialrequesttypename"],
        createdforname: json["createdforname"],
        statustext: json["statustext"],
        createdfor: json["createdfor"],
        specialrequesttypeid: json["specialrequesttypeid"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "specialrequest": specialrequest,
        "specialrequesttypename": specialrequesttypename,
        "createdforname": createdforname,
        "statustext": statustext,
        "createdfor": createdfor,
        "specialrequesttypeid": specialrequesttypeid,
      };
}
