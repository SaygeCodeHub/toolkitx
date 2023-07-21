import 'dart:convert';

FetchToDoHistoryListModel fetchToDoHistoryListModelFromJson(String str) =>
    FetchToDoHistoryListModel.fromJson(json.decode(str));

String fetchToDoHistoryListModelToJson(FetchToDoHistoryListModel data) =>
    json.encode(data.toJson());

class FetchToDoHistoryListModel {
  final int status;
  final String message;
  final List<Datum> data;

  FetchToDoHistoryListModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory FetchToDoHistoryListModel.fromJson(Map<String, dynamic> json) =>
      FetchToDoHistoryListModel(
        status: json["Status"],
        message: json["Message"],
        data: List<Datum>.from(json["Data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  final String id;
  final String todoname;
  final int istododue;
  final String description;
  final String category;
  final String duedate;
  final String createdfor;

  Datum({
    required this.id,
    required this.todoname,
    required this.istododue,
    required this.description,
    required this.category,
    required this.duedate,
    required this.createdfor,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        todoname: json["todoname"],
        istododue: json["istododue"],
        description: json["description"] ?? '',
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
