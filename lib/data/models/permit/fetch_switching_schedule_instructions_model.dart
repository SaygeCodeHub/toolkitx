import 'dart:convert';

FetchSwitchingScheduleInstructionsModel
    fetchSwitchingScheduleInstructionsModelFromJson(String str) =>
        FetchSwitchingScheduleInstructionsModel.fromJson(json.decode(str));

String fetchSwitchingScheduleInstructionsModelToJson(
        FetchSwitchingScheduleInstructionsModel data) =>
    json.encode(data.toJson());

class FetchSwitchingScheduleInstructionsModel {
  final int status;
  final String message;
  final List<PermitSwithcingScheduleInstructionDatum> data;

  FetchSwitchingScheduleInstructionsModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory FetchSwitchingScheduleInstructionsModel.fromJson(
          Map<String, dynamic> json) =>
      FetchSwitchingScheduleInstructionsModel(
        status: json["Status"],
        message: json["Message"],
        data: List<PermitSwithcingScheduleInstructionDatum>.from(json["Data"]
            .map((x) => PermitSwithcingScheduleInstructionDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class PermitSwithcingScheduleInstructionDatum {
  final String id;
  final String location;
  final String equipmentuid;
  final String operation;
  final String instructionreceivedbyname;
  final String instructionreceiveddate;
  final String controlengineername;
  final String carriedoutdate;
  final String carriedoutconfirmeddate;
  final String safetykeynumber;
  final int ismanual;
  final String canexecute;

  PermitSwithcingScheduleInstructionDatum({
    required this.id,
    required this.location,
    required this.equipmentuid,
    required this.operation,
    required this.instructionreceivedbyname,
    required this.instructionreceiveddate,
    required this.controlengineername,
    required this.carriedoutdate,
    required this.carriedoutconfirmeddate,
    required this.safetykeynumber,
    required this.ismanual,
    required this.canexecute,
  });

  factory PermitSwithcingScheduleInstructionDatum.fromJson(
          Map<String, dynamic> json) =>
      PermitSwithcingScheduleInstructionDatum(
        id: json["id"] ?? '',
        location: json["location"] ?? '',
        equipmentuid: json["equipmentuid"] ?? '',
        operation: json["operation"] ?? '',
        instructionreceivedbyname: json["instructionreceivedbyname"] ?? '',
        instructionreceiveddate: json["instructionreceiveddate"] ?? '',
        controlengineername: json["controlengineername"] ?? '',
        carriedoutdate: json["carriedoutdate"] ?? '',
        carriedoutconfirmeddate: json["carriedoutconfirmeddate"] ?? '',
        safetykeynumber: json["safetykeynumber"] ?? '',
        ismanual: json["ismanual"] ?? 0,
        canexecute: json["canexecute"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "location": location,
        "equipmentuid": equipmentuid,
        "operation": operation,
        "instructionreceivedbyname": instructionreceivedbyname,
        "instructionreceiveddate": instructionreceiveddate,
        "controlengineername": controlengineername,
        "carriedoutdate": carriedoutdate,
        "carriedoutconfirmeddate": carriedoutconfirmeddate,
        "safetykeynumber": safetykeynumber,
        "ismanual": ismanual,
        "canexecute": canexecute,
      };
}
