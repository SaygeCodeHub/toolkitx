import 'dart:convert';

SaveCheckListThirdPartyApproval saveThirdPartyApprovalFromJson(String str) =>
    SaveCheckListThirdPartyApproval.fromJson(json.decode(str));

String saveThirdPartyApprovalToJson(SaveCheckListThirdPartyApproval data) =>
    json.encode(data.toJson());

class SaveCheckListThirdPartyApproval {
  final int status;
  final String? message;
  final Data? data;

  SaveCheckListThirdPartyApproval({
    required this.status,
    this.message,
    this.data,
  });

  factory SaveCheckListThirdPartyApproval.fromJson(Map<String, dynamic> json) =>
      SaveCheckListThirdPartyApproval(
        status: json["Status"],
        message: json["Message"],
        data: Data.fromJson(json["Data"]),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": data!.toJson(),
      };
}

class Data {
  Data();

  factory Data.fromJson(Map<String, dynamic> json) => Data();

  Map<String, dynamic> toJson() => {};
}
