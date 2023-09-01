
import 'dart:convert';

AssignToMeChecklistModel assignToMeChecklistModelFromJson(String str) => AssignToMeChecklistModel.fromJson(json.decode(str));

String assignToMeChecklistModelToJson(AssignToMeChecklistModel data) => json.encode(data.toJson());

class AssignToMeChecklistModel {
  final int status;
  final String message;
  final Data data;

  AssignToMeChecklistModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory AssignToMeChecklistModel.fromJson(Map<String, dynamic> json) => AssignToMeChecklistModel(
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

  factory Data.fromJson(Map<String, dynamic> json) => Data(
  );

  Map<String, dynamic> toJson() => {
  };
}
