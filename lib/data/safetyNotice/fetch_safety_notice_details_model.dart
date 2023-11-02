import 'dart:convert';

FetchSafetyNoticeDetailsModel fetchSafetyNoticeDetailsModelFromJson(
        String str) =>
    FetchSafetyNoticeDetailsModel.fromJson(json.decode(str));

String fetchSafetyNoticeDetailsModelToJson(
        FetchSafetyNoticeDetailsModel data) =>
    json.encode(data.toJson());

class FetchSafetyNoticeDetailsModel {
  final int status;
  final String message;
  final SafetyNoticeData data;

  FetchSafetyNoticeDetailsModel(
      {required this.status, required this.message, required this.data});

  factory FetchSafetyNoticeDetailsModel.fromJson(Map<String, dynamic> json) =>
      FetchSafetyNoticeDetailsModel(
        status: json["Status"],
        message: json["Message"],
        data: SafetyNoticeData.fromJson(json["Data"]),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": data.toJson(),
      };
}

class SafetyNoticeData {
  final String noticeid;
  final String notice;
  final String validity;
  final String status;
  final String issuetoall;
  final String statusText;
  final String canEdit;
  final String canIssue;
  final String canCancel;
  final String canClose;
  final String canHold;
  final String canReissue;
  final String files;
  final String refno;
  final String createdby;
  final List<Log> logs;

  SafetyNoticeData(
      {required this.noticeid,
      required this.notice,
      required this.validity,
      required this.status,
      required this.issuetoall,
      required this.statusText,
      required this.canEdit,
      required this.canIssue,
      required this.canCancel,
      required this.canClose,
      required this.canHold,
      required this.canReissue,
      required this.files,
      required this.refno,
      required this.createdby,
      required this.logs});

  factory SafetyNoticeData.fromJson(Map<String, dynamic> json) =>
      SafetyNoticeData(
        noticeid: json["noticeid"] ?? '',
        notice: json["notice"] ?? '',
        validity: json["validity"] ?? '',
        status: json["status"] ?? '',
        issuetoall: json["issuetoall"] ?? '',
        statusText: json["status_text"] ?? '',
        canEdit: json["can_edit"] ?? '',
        canIssue: json["can_issue"] ?? '',
        canCancel: json["can_cancel"] ?? '',
        canClose: json["can_close"] ?? '',
        canHold: json["can_hold"] ?? '',
        canReissue: json["can_reissue"] ?? '',
        files: json["files"] ?? '',
        refno: json["refno"] ?? '',
        createdby: json["createdby"] ?? '',
        logs: List<Log>.from(json["logs"].map((x) => Log.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "noticeid": noticeid,
        "notice": notice,
        "validity": validity,
        "status": status,
        "issuetoall": issuetoall,
        "status_text": statusText,
        "can_edit": canEdit,
        "can_issue": canIssue,
        "can_cancel": canCancel,
        "can_close": canClose,
        "can_hold": canHold,
        "can_reissue": canReissue,
        "files": files,
        "refno": refno,
        "createdby": createdby,
        "logs": List<dynamic>.from(logs.map((x) => x.toJson())),
      };
}

class Log {
  final String createdAt;
  final String processedRemark;
  final String createdBy;

  Log(
      {required this.createdAt,
      required this.processedRemark,
      required this.createdBy});

  factory Log.fromJson(Map<String, dynamic> json) => Log(
        createdAt: json["created_at"] ?? '',
        processedRemark: json["processed_remark"] ?? '',
        createdBy: json["created_by"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "created_at": createdAt,
        "processed_remark": processedRemark,
        "created_by": createdBy,
      };
}
