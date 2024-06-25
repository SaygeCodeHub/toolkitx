import 'dart:convert';

GetCheckListRejectReasonsModel getCheckListRejectReasonsModelFromJson(
        String str) =>
    GetCheckListRejectReasonsModel.fromJson(json.decode(str));

String getCheckListRejectReasonsModelToJson(
        GetCheckListRejectReasonsModel data) =>
    json.encode(data.toJson());

class GetCheckListRejectReasonsModel {
  final int status;
  final String? message;
  final List<GetChecklistRejectReasonsData>? data;

  GetCheckListRejectReasonsModel({
    required this.status,
    this.message,
    this.data,
  });

  factory GetCheckListRejectReasonsModel.fromJson(Map<String, dynamic> json) =>
      GetCheckListRejectReasonsModel(
        status: json["Status"],
        message: json["Message"],
        data: List<GetChecklistRejectReasonsData>.from(
            json["Data"].map((x) => GetChecklistRejectReasonsData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class GetChecklistRejectReasonsData {
  final String reasontext;

  GetChecklistRejectReasonsData({
    required this.reasontext,
  });

  factory GetChecklistRejectReasonsData.fromJson(Map<String, dynamic> json) =>
      GetChecklistRejectReasonsData(
        reasontext: json["reasontext"],
      );

  Map<String, dynamic> toJson() => {
        "reasontext": reasontext,
      };
}
