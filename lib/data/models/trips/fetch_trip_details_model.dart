
import 'dart:convert';

FetchTripDetailsModel fetchTripDetailsModelFromJson(String str) => FetchTripDetailsModel.fromJson(json.decode(str));

String fetchTripDetailsModelToJson(FetchTripDetailsModel data) => json.encode(data.toJson());

class FetchTripDetailsModel {
  final int status;
  final String message;
  final TripData data;

  FetchTripDetailsModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory FetchTripDetailsModel.fromJson(Map<String, dynamic> json) => FetchTripDetailsModel(
    status: json["Status"],
    message: json["Message"],
    data: TripData.fromJson(json["Data"]),
  );

  Map<String, dynamic> toJson() => {
    "Status": status,
    "Message": message,
    "Data": data.toJson(),
  };
}

class TripData {
  final String id;
  final String departuredatetime;
  final String arrivaldatetime;
  final String actualdeparturedatetime;
  final String actualarrivaldatetime;
  final String deplocname;
  final String arrlocname;
  final String remarks;
  final String statustext;
  final String purposetext;
  final String canaddspecialrequest;
  final String vesselname;
  final List<Specialrequest> specialrequests;
  final List<Document> documents;

  TripData({
    required this.id,
    required this.departuredatetime,
    required this.arrivaldatetime,
    required this.actualdeparturedatetime,
    required this.actualarrivaldatetime,
    required this.deplocname,
    required this.arrlocname,
    required this.remarks,
    required this.statustext,
    required this.purposetext,
    required this.canaddspecialrequest,
    required this.vesselname,
    required this.specialrequests,
    required this.documents,
  });

  factory TripData.fromJson(Map<String, dynamic> json) => TripData(
    id: json["id"],
    departuredatetime: json["departuredatetime"],
    arrivaldatetime: json["arrivaldatetime"],
    actualdeparturedatetime: json["actualdeparturedatetime"],
    actualarrivaldatetime: json["actualarrivaldatetime"],
    deplocname: json["deplocname"],
    arrlocname: json["arrlocname"],
    remarks: json["remarks"],
    statustext: json["statustext"],
    purposetext: json["purposetext"],
    canaddspecialrequest: json["canaddspecialrequest"],
    vesselname: json["vesselname"],
    specialrequests: List<Specialrequest>.from(json["specialrequests"].map((x) => Specialrequest.fromJson(x))),
    documents: List<Document>.from(json["documents"].map((x) => Document.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "departuredatetime": departuredatetime,
    "arrivaldatetime": arrivaldatetime,
    "actualdeparturedatetime": actualdeparturedatetime,
    "actualarrivaldatetime": actualarrivaldatetime,
    "deplocname": deplocname,
    "arrlocname": arrlocname,
    "remarks": remarks,
    "statustext": statustext,
    "purposetext": purposetext,
    "canaddspecialrequest": canaddspecialrequest,
    "vesselname": vesselname,
    "specialrequests": List<dynamic>.from(specialrequests.map((x) => x.toJson())),
    "documents": List<dynamic>.from(documents.map((x) => x.toJson())),
  };
}

class Document {
  final String id;
  final String name;
  final String type;
  final String files;

  Document({
    required this.id,
    required this.name,
    required this.type,
    required this.files,
  });

  factory Document.fromJson(Map<String, dynamic> json) => Document(
    id: json["id"],
    name: json["name"],
    type: json["type"],
    files: json["files"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "type": type,
    "files": files,
  };
}

class Specialrequest {
  final String id;
  final String specialrequest;
  final String specialrequesttypename;
  final String processedDate;
  final String constructionFullName;
  final String processedStatus;
  final String canedit;

  Specialrequest({
    required this.id,
    required this.specialrequest,
    required this.specialrequesttypename,
    required this.processedDate,
    required this.constructionFullName,
    required this.processedStatus,
    required this.canedit,
  });

  factory Specialrequest.fromJson(Map<String, dynamic> json) => Specialrequest(
    id: json["id"],
    specialrequest: json["specialrequest"],
    specialrequesttypename: json["specialrequesttypename"],
    processedDate: json["processed_date"],
    constructionFullName: json["construction_full_name"],
    processedStatus: json["processed_status"],
    canedit: json["canedit"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "specialrequest": specialrequest,
    "specialrequesttypename": specialrequesttypename,
    "processed_date": processedDate,
    "construction_full_name": constructionFullName,
    "processed_status": processedStatus,
    "canedit": canedit,
  };
}
