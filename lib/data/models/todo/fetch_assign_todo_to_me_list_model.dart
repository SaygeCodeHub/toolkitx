import 'dart:convert';

FetchToDoAssignToMeListModel fetchToDoAssignToMeListModelFromJson(String str) =>
    FetchToDoAssignToMeListModel.fromJson(json.decode(str));

String fetchToDoAssignToMeListModelToJson(FetchToDoAssignToMeListModel data) =>
    json.encode(data.toJson());

class FetchToDoAssignToMeListModel {
  final int status;
  final String message;
  final List<AssignedToMeListDatum> assignToMeListDatum;

  FetchToDoAssignToMeListModel({
    required this.status,
    required this.message,
    required this.assignToMeListDatum,
  });

  factory FetchToDoAssignToMeListModel.fromJson(Map<String, dynamic> json) =>
      FetchToDoAssignToMeListModel(
        status: json["Status"],
        message: json["Message"],
        assignToMeListDatum: List<AssignedToMeListDatum>.from(
            json["Data"].map((x) => AssignedToMeListDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": List<dynamic>.from(assignToMeListDatum.map((x) => x.toJson())),
      };
}

class AssignedToMeListDatum {
  final String id;
  final String todoname;
  final int istododue;
  final String description;
  final String category;
  final String duedate;
  final String createdfor;

  AssignedToMeListDatum({
    required this.id,
    required this.todoname,
    required this.istododue,
    required this.description,
    required this.category,
    required this.duedate,
    required this.createdfor,
  });

  factory AssignedToMeListDatum.fromJson(Map<String, dynamic> json) =>
      AssignedToMeListDatum(
        id: json["id"],
        todoname: json["todoname"],
        istododue: json["istododue"],
        description: json["description"],
        category: json["category"] ?? '',
        duedate: json["duedate"],
        createdfor: json["createdfor"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "todoname": todoname,
        "istododue": istododue,
        "description": description,
        "category": category,
        "duedate": duedate,
        "createdfor": createdfor,
      };
}
