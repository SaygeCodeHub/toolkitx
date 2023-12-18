import 'dart:convert';

FetchLotoChecklistQuestionsModel fetchLotoChecklistQuestionsModelFromJson(
        String str) =>
    FetchLotoChecklistQuestionsModel.fromJson(json.decode(str));

String fetchLotoChecklistQuestionsModelToJson(
        FetchLotoChecklistQuestionsModel data) =>
    json.encode(data.toJson());

class FetchLotoChecklistQuestionsModel {
  final int? status;
  final String? message;
  final Data? data;

  FetchLotoChecklistQuestionsModel({
    this.status,
    this.message,
    this.data,
  });

  factory FetchLotoChecklistQuestionsModel.fromJson(
          Map<String, dynamic> json) =>
      FetchLotoChecklistQuestionsModel(
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
  final String? checklistid;
  final String? name;
  final String? checklistArray;
  final List<QuestionList>? questionlist;

  Data({
    this.checklistid,
    this.name,
    this.checklistArray,
    this.questionlist,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        checklistid: json["checklistid"],
        name: json["name"] ?? '',
        checklistArray: json["checklistArray"] ?? '',
        questionlist: json["questionlist"] == null
            ? []
            : List<QuestionList>.from(
                json["questionlist"].map((x) => QuestionList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "checklistid": checklistid,
        "name": name,
        "checklistArray": checklistArray,
        "questionlist":
            List<dynamic>.from(questionlist!.map((x) => x.toJson())),
      };
}

class QuestionList {
  final String id;
  final int type;
  final String title;
  final int ismandatory;
  final int isallowchar;
  final int isallownumber;
  final int isallowspchar;
  final dynamic maxlength;
  final dynamic minval;
  final dynamic maxval;
  final String fileextension;
  final String moreinfo;
  final String optioncomment;
  final dynamic optionid;
  final String optiontext;
  final List<QueOption> queoptions;

  QuestionList({
    required this.id,
    required this.type,
    required this.title,
    required this.ismandatory,
    required this.isallowchar,
    required this.isallownumber,
    required this.isallowspchar,
    required this.maxlength,
    required this.minval,
    required this.maxval,
    required this.fileextension,
    required this.moreinfo,
    required this.optioncomment,
    required this.optionid,
    required this.optiontext,
    required this.queoptions,
  });

  factory QuestionList.fromJson(Map<String, dynamic> json) => QuestionList(
        id: json["id"],
        type: json["type"],
        title: json["title"],
        ismandatory: json["ismandatory"],
        isallowchar: json["isallowchar"],
        isallownumber: json["isallownumber"],
        isallowspchar: json["isallowspchar"],
        maxlength: json["maxlength"],
        minval: json["minval"],
        maxval: json["maxval"],
        fileextension: json["fileextension"],
        moreinfo: json["moreinfo"],
        optioncomment: json["optioncomment"] ?? '',
        optionid: json["optionid"],
        optiontext: json["optiontext"] ?? '',
        queoptions: List<QueOption>.from(
            json["queoptions"].map((x) => QueOption.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "title": title,
        "ismandatory": ismandatory,
        "isallowchar": isallowchar,
        "isallownumber": isallownumber,
        "isallowspchar": isallowspchar,
        "maxlength": maxlength,
        "minval": minval,
        "maxval": maxval,
        "fileextension": fileextension,
        "moreinfo": moreinfo,
        "optioncomment": optioncomment,
        "optionid": optionid,
        "optiontext": optiontext,
        "queoptions": List<dynamic>.from(queoptions.map((x) => x.toJson())),
      };
}

class QueOption {
  final int queoptionid;
  final String queoptiontext;

  QueOption({
    required this.queoptionid,
    required this.queoptiontext,
  });

  factory QueOption.fromJson(Map<String, dynamic> json) => QueOption(
        queoptionid: json["queoptionid"],
        queoptiontext: json["queoptiontext"],
      );

  Map<String, dynamic> toJson() => {
        "queoptionid": queoptionid,
        "queoptiontext": queoptiontext,
      };
}
