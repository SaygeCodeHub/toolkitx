import 'dart:convert';

FetchTankChecklistQuestionModel fetchTankChecklistQuestionModelFromJson(
        String str) =>
    FetchTankChecklistQuestionModel.fromJson(json.decode(str));

String fetchTankChecklistQuestionModelToJson(
        FetchTankChecklistQuestionModel data) =>
    json.encode(data.toJson());

class FetchTankChecklistQuestionModel {
  final int? status;
  final String? message;
  final Data? data;

  FetchTankChecklistQuestionModel({
    this.status,
    this.message,
    this.data,
  });

  factory FetchTankChecklistQuestionModel.fromJson(Map<String, dynamic> json) =>
      FetchTankChecklistQuestionModel(
        status: json["Status"],
        message: json["Message"],
        data: json["Data"] == null ? null : Data.fromJson(json["Data"]),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": data?.toJson(),
      };
}

class Data {
  final String? checklistid;
  final String? scheduleid;
  final String? name;
  final String? state;
  final String? type;
  final String? showlocation;
  final String? templateid;
  final String? responseid;
  final List<TankQuestionList>? questionlist;

  Data({
    this.checklistid,
    this.scheduleid,
    this.name,
    this.state,
    this.type,
    this.showlocation,
    this.templateid,
    this.responseid,
    this.questionlist,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        checklistid: json["checklistid"],
        scheduleid: json["scheduleid"],
        name: json["name"],
        state: json["state"],
        type: json["type"],
        showlocation: json["showlocation"],
        templateid: json["templateid"],
        responseid: json["responseid"],
        questionlist: json["questionlist"] == null
            ? []
            : List<TankQuestionList>.from(
                json["questionlist"]!.map((x) => TankQuestionList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "checklistid": checklistid,
        "scheduleid": scheduleid,
        "name": name,
        "state": state,
        "type": type,
        "showlocation": showlocation,
        "templateid": templateid,
        "responseid": responseid,
        "questionlist": questionlist == null
            ? []
            : List<dynamic>.from(questionlist!.map((x) => x.toJson())),
      };
}

class TankQuestionList {
  final String? id;
  final int? type;
  final String? title;
  final String? categoryname;
  final String? subcategoryname;
  final String? locationname;
  final int? ismandatory;
  final int? isallowchar;
  final int? isallownumber;
  final int? isallowspchar;
  final dynamic maxlength;
  final int? minval;
  final int? maxval;
  final String? fileextension;
  final dynamic optioncomment;
  final dynamic optionid;
  final dynamic optiontext;
  final String? queresponseid;
  final String? additionalcomment;
  final String? files;
  final String? moreinfo;
  final dynamic matrixrowcount;
  final List<Maplink>? maplinks;
  final List<dynamic>? queoptions;
  final List<dynamic>? matrixcols;

  TankQuestionList({
    this.id,
    this.type,
    this.title,
    this.categoryname,
    this.subcategoryname,
    this.locationname,
    this.ismandatory,
    this.isallowchar,
    this.isallownumber,
    this.isallowspchar,
    this.maxlength,
    this.minval,
    this.maxval,
    this.fileextension,
    this.optioncomment,
    this.optionid,
    this.optiontext,
    this.queresponseid,
    this.additionalcomment,
    this.files,
    this.moreinfo,
    this.matrixrowcount,
    this.maplinks,
    this.queoptions,
    this.matrixcols,
  });

  factory TankQuestionList.fromJson(Map<String, dynamic> json) =>
      TankQuestionList(
        id: json["id"],
        type: json["type"],
        title: json["title"],
        categoryname: json["categoryname"],
        subcategoryname: json["subcategoryname"],
        locationname: json["locationname"],
        ismandatory: json["ismandatory"],
        isallowchar: json["isallowchar"],
        isallownumber: json["isallownumber"],
        isallowspchar: json["isallowspchar"],
        maxlength: json["maxlength"],
        minval: json["minval"],
        maxval: json["maxval"],
        fileextension: json["fileextension"],
        optioncomment: json["optioncomment"],
        optionid: json["optionid"],
        optiontext: json["optiontext"],
        queresponseid: json["queresponseid"],
        additionalcomment: json["additionalcomment"],
        files: json["files"],
        moreinfo: json["moreinfo"],
        matrixrowcount: json["matrixrowcount"],
        maplinks: json["maplinks"] == null
            ? []
            : List<Maplink>.from(
                json["maplinks"]!.map((x) => Maplink.fromJson(x))),
        queoptions: json["queoptions"] == null
            ? []
            : List<dynamic>.from(json["queoptions"]!.map((x) => x)),
        matrixcols: json["matrixcols"] == null
            ? []
            : List<dynamic>.from(json["matrixcols"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "title": title,
        "categoryname": categoryname,
        "subcategoryname": subcategoryname,
        "locationname": locationname,
        "ismandatory": ismandatory,
        "isallowchar": isallowchar,
        "isallownumber": isallownumber,
        "isallowspchar": isallowspchar,
        "maxlength": maxlength,
        "minval": minval,
        "maxval": maxval,
        "fileextension": fileextension,
        "optioncomment": optioncomment,
        "optionid": optionid,
        "optiontext": optiontext,
        "queresponseid": queresponseid,
        "additionalcomment": additionalcomment,
        "files": files,
        "moreinfo": moreinfo,
        "matrixrowcount": matrixrowcount,
        "maplinks": maplinks == null
            ? []
            : List<dynamic>.from(maplinks!.map((x) => x.toJson())),
        "queoptions": queoptions == null
            ? []
            : List<dynamic>.from(queoptions!.map((x) => x.toJson())),
        "matrixcols": matrixcols == null
            ? []
            : List<dynamic>.from(matrixcols!.map((x) => x)),
      };
}

class Maplink {
  final String? name;
  final String? link;
  final String? classname;

  Maplink({
    this.name,
    this.link,
    this.classname,
  });

  factory Maplink.fromJson(Map<String, dynamic> json) => Maplink(
        name: json["name"],
        link: json["link"],
        classname: json["classname"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "link": link,
        "classname": classname,
      };
}

class TankQueoption {
  final int? queoptionid;
  final String? queoptiontext;

  TankQueoption({
    this.queoptionid,
    this.queoptiontext,
  });

  factory TankQueoption.fromJson(Map<String, dynamic> json) => TankQueoption(
        queoptionid: json["queoptionid"],
        queoptiontext: json["queoptiontext"],
      );

  Map<String, dynamic> toJson() => {
        "queoptionid": queoptionid,
        "queoptiontext": queoptiontext,
      };
}
