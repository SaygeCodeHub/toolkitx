import 'dart:convert';
FetchGetNotesModel fetchGetNotesModelFromJson(String str) => FetchGetNotesModel.fromJson(json.decode(str));
String fetchGetNotesModelToJson(FetchGetNotesModel data) => json.encode(data.toJson());
class FetchGetNotesModel {
  final int status;
  final String message;
  final GetNotesData data;
  FetchGetNotesModel({
    required this.status,
    required this.message,
    required this.data,
  });
  factory FetchGetNotesModel.fromJson(Map<String, dynamic> json) => FetchGetNotesModel(
    status: json["Status"],
    message: json["Message"],
    data: GetNotesData.fromJson(json["Data"]),
  );
  Map<String, dynamic> toJson() => {
    "Status": status,
    "Message": message,
    "Data": data.toJson(),
  };
}
class GetNotesData {
  final String topicname;
  final String topicdescription;
  final String coursename;
  final String certificatename;
  final String id;
  final String type;
  final String notes;
  final String description;
  final String notescount;
  final String currentpageno;
  final String link;
  GetNotesData({
    required this.topicname,
    required this.topicdescription,
    required this.coursename,
    required this.certificatename,
    required this.id,
    required this.type,
    required this.notes,
    required this.description,
    required this.notescount,
    required this.currentpageno,
    required this.link,
  });
  factory GetNotesData.fromJson(Map<String, dynamic> json) => GetNotesData(
    topicname: json["topicname"] ?? '',
    topicdescription: json["topicdescription"]?? '',
    coursename: json["coursename"]?? '',
    certificatename: json["certificatename"]?? '',
    id: json["id"]?? '',
    type: json["type"]?? '',
    notes: json["notes"]?? '',
    description: json["description"]?? '',
    notescount: json["notescount"]?? '',
    currentpageno: json["currentpageno"]?? '',
    link: json["link"]?? '',
  );
  Map<String, dynamic> toJson() => {
    "topicname": topicname,
    "topicdescription": topicdescription,
    "coursename": coursename,
    "certificatename": certificatename,
    "id": id,
    "type": type,
    "notes": notes,
    "description": description,
    "notescount": notescount,
    "currentpageno": currentpageno,
    "link": link,
  };
}