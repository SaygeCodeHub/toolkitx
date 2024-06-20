import 'dart:convert';

FetchMeetingDetailsModel fetchMeetingDetailsModelFromJson(String str) =>
    FetchMeetingDetailsModel.fromJson(json.decode(str));

String fetchMeetingDetailsModelToJson(FetchMeetingDetailsModel data) =>
    json.encode(data.toJson());

class FetchMeetingDetailsModel {
  final int status;
  final String message;
  final Data data;

  FetchMeetingDetailsModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory FetchMeetingDetailsModel.fromJson(Map<String, dynamic> json) =>
      FetchMeetingDetailsModel(
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
  final String roomid;
  final String startdatetime;
  final String enddatetime;
  final String shortagenda;
  final String longagenda;
  final String owner;
  final String ownerEmail;
  final String createdby;
  final String createdbytype;
  final String participantname;
  final String participantwfname;
  final String participant;
  final String participantWf;
  final String roomname;
  final String location;
  final String buildingid;
  final String floorid;
  final String externalusers;
  final String filename;
  final String canedit;
  final String candelete;

  Data({
    required this.roomid,
    required this.startdatetime,
    required this.enddatetime,
    required this.shortagenda,
    required this.longagenda,
    required this.owner,
    required this.ownerEmail,
    required this.createdby,
    required this.createdbytype,
    required this.participantname,
    required this.participantwfname,
    required this.participant,
    required this.participantWf,
    required this.roomname,
    required this.location,
    required this.buildingid,
    required this.floorid,
    required this.externalusers,
    required this.filename,
    required this.canedit,
    required this.candelete,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        roomid: json["roomid"],
        startdatetime: json["startdatetime"],
        enddatetime: json["enddatetime"],
        shortagenda: json["shortagenda"],
        longagenda: json["longagenda"],
        owner: json["owner"],
        ownerEmail: json["owner_email"],
        createdby: json["createdby"],
        createdbytype: json["createdbytype"],
        participantname: json["participantname"],
        participantwfname: json["participantwfname"],
        participant: json["participant"],
        participantWf: json["participant_wf"],
        roomname: json["roomname"],
        location: json["location"],
        buildingid: json["buildingid"],
        floorid: json["floorid"],
        externalusers: json["externalusers"],
        filename: json["filename"],
        canedit: json["canedit"],
        candelete: json["candelete"],
      );

  Map<String, dynamic> toJson() => {
        "roomid": roomid,
        "startdatetime": startdatetime,
        "enddatetime": enddatetime,
        "shortagenda": shortagenda,
        "longagenda": longagenda,
        "owner": owner,
        "owner_email": ownerEmail,
        "createdby": createdby,
        "createdbytype": createdbytype,
        "participantname": participantname,
        "participantwfname": participantwfname,
        "participant": participant,
        "participant_wf": participantWf,
        "roomname": roomname,
        "location": location,
        "buildingid": buildingid,
        "floorid": floorid,
        "externalusers": externalusers,
        "filename": filename,
        "canedit": canedit,
        "candelete": candelete,
      };
}
