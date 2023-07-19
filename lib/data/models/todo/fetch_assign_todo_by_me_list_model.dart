import 'dart:convert';

FetchToDoAssignToByListModel fetchToDoAssignToByeListModelFromJson(
        String str) =>
    FetchToDoAssignToByListModel.fromJson(json.decode(str));

String fetchToDoAssignToByeListModelToJson(FetchToDoAssignToByListModel data) =>
    json.encode(data.toJson());

class FetchToDoAssignToByListModel {
  final int status;
  final String message;
  final List<AssignByMeListDatum> assignedByMeListDatum;

  FetchToDoAssignToByListModel({
    required this.status,
    required this.message,
    required this.assignedByMeListDatum,
  });

  factory FetchToDoAssignToByListModel.fromJson(Map<String, dynamic> json) =>
      FetchToDoAssignToByListModel(
        status: json["Status"],
        message: json["Message"],
        assignedByMeListDatum: List<AssignByMeListDatum>.from(
            json["Data"].map((x) => AssignByMeListDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data":
            List<dynamic>.from(assignedByMeListDatum.map((x) => x.toJson())),
      };
}

class AssignByMeListDatum {
  final String id;
  final String todoname;
  final int istododue;
  final String description;
  final String category;
  final String duedate;
  final String createdfor;

  AssignByMeListDatum({
    required this.id,
    required this.todoname,
    required this.istododue,
    required this.description,
    required this.category,
    required this.duedate,
    required this.createdfor,
  });

  factory AssignByMeListDatum.fromJson(Map<String, dynamic> json) =>
      AssignByMeListDatum(
        id: json["id"],
        todoname: json["todoname"],
        istododue: json["istododue"],
        description: json["description"],
        category: json["category"],
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
