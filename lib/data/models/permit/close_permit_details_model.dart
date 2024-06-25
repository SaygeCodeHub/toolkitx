import 'dart:convert';

ClosePermitDetailsModel closePermitDetailsModelFromJson(String str) =>
    ClosePermitDetailsModel.fromJson(json.decode(str));

String closePermitDetailsModelToJson(ClosePermitDetailsModel data) =>
    json.encode(data.toJson());

class ClosePermitDetailsModel {
  final int status;
  final String message;
  final GetClosePermitData data;

  ClosePermitDetailsModel(
      {required this.status, required this.message, required this.data});

  factory ClosePermitDetailsModel.fromJson(Map<String, dynamic> json) =>
      ClosePermitDetailsModel(
          status: json["Status"],
          message: json["Message"],
          data: GetClosePermitData.fromJson(json["Data"]));

  Map<String, dynamic> toJson() =>
      {"Status": status, "Message": message, "Data": data.toJson()};
}

class GetClosePermitData {
  final String? permitName;
  String? permitStatus;
  final String? panelSaint;
  final String? showComment;

  GetClosePermitData(
      {this.permitName, this.permitStatus, this.panelSaint, this.showComment});

  factory GetClosePermitData.fromJson(Map<String, dynamic> json) =>
      GetClosePermitData(
          permitName: json["permit_name"],
          permitStatus: json["permit_status"],
          panelSaint: json["panel_saint"],
          showComment: json["show_comment"]);

  Map<String, dynamic> toJson() => {
        "permit_name": permitName,
        "permit_status": permitStatus,
        "panel_saint": panelSaint,
        "show_comment": showComment
      };
}
