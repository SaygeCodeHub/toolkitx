import 'dart:convert';

FetchTankManagementDetailsModel fetchTankManagementDetailsModelFromJson(
        String str) =>
    FetchTankManagementDetailsModel.fromJson(json.decode(str));

String fetchTankManagementDetailsModelToJson(
        FetchTankManagementDetailsModel data) =>
    json.encode(data.toJson());

class FetchTankManagementDetailsModel {
  final int status;
  final String message;
  final Data data;

  FetchTankManagementDetailsModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory FetchTankManagementDetailsModel.fromJson(Map<String, dynamic> json) =>
      FetchTankManagementDetailsModel(
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
  final String id;
  final String contractname;
  final String announce;
  final String announcedetails;
  final String customerid;
  final String customername;
  final String customeremail;
  final String contractid;
  final String priority;
  final String eta;
  final String type;
  final String product;
  final String productname;
  final String tank;
  final String clientproduct;
  final String containertype;
  final String metrictons;
  final String metriccbm;
  final String surveyour;
  final String surveyourname;
  final String customstatusid;
  final String customstatus;
  final String status;
  final String userid;
  final String licenseplate;
  final String drivername;
  final String carriercompany;
  final String noofcompartments;
  final String volumn;
  final String truckposition;
  final String driverphone;
  final String rfidnumber;
  final String berth;
  final String agent;
  final String agentname;
  final String captainCarrierperson;
  final String loadport;
  final String disport;
  final String countryoforigin;
  final String countryofproduction;
  final String countryoforiginname;
  final String countryofproductionname;
  final String destinationtank;
  final String destinationtankname;
  final String nominationNo;
  final String shipname;
  final String tankername;
  final String sealnotop;
  final String sealnobottom;
  final String tankermaxcapacity;
  final String closeDatetime;
  final String processStopconditionid;
  final String closedwithfailure;
  final String files;
  final String tanknames;
  final String nominationo;
  final String announcetext;
  final List<Approvelist> approvelist;

  Data({
    required this.id,
    required this.contractname,
    required this.announce,
    required this.announcedetails,
    required this.customerid,
    required this.customername,
    required this.customeremail,
    required this.contractid,
    required this.priority,
    required this.eta,
    required this.type,
    required this.product,
    required this.productname,
    required this.tank,
    required this.clientproduct,
    required this.containertype,
    required this.metrictons,
    required this.metriccbm,
    required this.surveyour,
    required this.surveyourname,
    required this.customstatusid,
    required this.customstatus,
    required this.status,
    required this.userid,
    required this.licenseplate,
    required this.drivername,
    required this.carriercompany,
    required this.noofcompartments,
    required this.volumn,
    required this.truckposition,
    required this.driverphone,
    required this.rfidnumber,
    required this.berth,
    required this.agent,
    required this.agentname,
    required this.captainCarrierperson,
    required this.loadport,
    required this.disport,
    required this.countryoforigin,
    required this.countryofproduction,
    required this.countryoforiginname,
    required this.countryofproductionname,
    required this.destinationtank,
    required this.destinationtankname,
    required this.nominationNo,
    required this.shipname,
    required this.tankername,
    required this.sealnotop,
    required this.sealnobottom,
    required this.tankermaxcapacity,
    required this.closeDatetime,
    required this.processStopconditionid,
    required this.closedwithfailure,
    required this.files,
    required this.tanknames,
    required this.nominationo,
    required this.announcetext,
    required this.approvelist,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"] ?? '',
        contractname: json["contractname"] ?? '',
        announce: json["announce"] ?? '',
        announcedetails: json["announcedetails"] ?? '',
        customerid: json["customerid"] ?? '',
        customername: json["customername"] ?? '',
        customeremail: json["customeremail"] ?? '',
        contractid: json["contractid"] ?? '',
        priority: json["priority"] ?? '',
        eta: json["eta"] ?? '',
        type: json["type"] ?? '',
        product: json["product"] ?? '',
        productname: json["productname"] ?? '',
        tank: json["tank"] ?? '',
        clientproduct: json["clientproduct"] ?? '',
        containertype: json["containertype"] ?? '',
        metrictons: json["metrictons"] ?? '',
        metriccbm: json["metriccbm"] ?? '',
        surveyour: json["surveyour"] ?? '',
        surveyourname: json["surveyourname"] ?? '',
        customstatusid: json["customstatusid"] ?? '',
        customstatus: json["customstatus"] ?? '',
        status: json["status"] ?? '',
        userid: json["userid"] ?? '',
        licenseplate: json["licenseplate"] ?? '',
        drivername: json["drivername"] ?? '',
        carriercompany: json["carriercompany"] ?? '',
        noofcompartments: json["noofcompartments"] ?? '',
        volumn: json["volumn"] ?? '',
        truckposition: json["truckposition"] ?? '',
        driverphone: json["driverphone"] ?? '',
        rfidnumber: json["rfidnumber"] ?? '',
        berth: json["berth"] ?? '',
        agent: json["agent"] ?? '',
        agentname: json["agentname"] ?? '',
        captainCarrierperson: json["captain_carrierperson"] ?? '',
        loadport: json["loadport"] ?? '',
        disport: json["disport"] ?? '',
        countryoforigin: json["countryoforigin"] ?? '',
        countryofproduction: json["countryofproduction"] ?? '',
        countryoforiginname: json["countryoforiginname"] ?? '',
        countryofproductionname: json["countryofproductionname"] ?? '',
        destinationtank: json["destinationtank"] ?? '',
        destinationtankname: json["destinationtankname"] ?? '',
        nominationNo: json["nomination_no"] ?? '',
        shipname: json["shipname"] ?? '',
        tankername: json["tankername"] ?? '',
        sealnotop: json["sealnotop"] ?? '',
        sealnobottom: json["sealnobottom"] ?? '',
        tankermaxcapacity: json["tankermaxcapacity"] ?? '',
        closeDatetime: json["close_datetime"] ?? '',
        processStopconditionid: json["process_stopconditionid"] ?? '',
        closedwithfailure: json["closedwithfailure"] ?? '',
        files: json["files"] ?? '',
        tanknames: json["tanknames"] ?? '',
        nominationo: json["nominationo"] ?? '',
        announcetext: json["announcetext"] ?? '',
        approvelist: json["approvelist"] == null ? [] : List<Approvelist>.from(
            json["approvelist"].map((x) => Approvelist.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "contractname": contractname,
        "announce": announce,
        "announcedetails": announcedetails,
        "customerid": customerid,
        "customername": customername,
        "customeremail": customeremail,
        "contractid": contractid,
        "priority": priority,
        "eta": eta,
        "type": type,
        "product": product,
        "productname": productname,
        "tank": tank,
        "clientproduct": clientproduct,
        "containertype": containertype,
        "metrictons": metrictons,
        "metriccbm": metriccbm,
        "surveyour": surveyour,
        "surveyourname": surveyourname,
        "customstatusid": customstatusid,
        "customstatus": customstatus,
        "status": status,
        "userid": userid,
        "licenseplate": licenseplate,
        "drivername": drivername,
        "carriercompany": carriercompany,
        "noofcompartments": noofcompartments,
        "volumn": volumn,
        "truckposition": truckposition,
        "driverphone": driverphone,
        "rfidnumber": rfidnumber,
        "berth": berth,
        "agent": agent,
        "agentname": agentname,
        "captain_carrierperson": captainCarrierperson,
        "loadport": loadport,
        "disport": disport,
        "countryoforigin": countryoforigin,
        "countryofproduction": countryofproduction,
        "countryoforiginname": countryoforiginname,
        "countryofproductionname": countryofproductionname,
        "destinationtank": destinationtank,
        "destinationtankname": destinationtankname,
        "nomination_no": nominationNo,
        "shipname": shipname,
        "tankername": tankername,
        "sealnotop": sealnotop,
        "sealnobottom": sealnobottom,
        "tankermaxcapacity": tankermaxcapacity,
        "close_datetime": closeDatetime,
        "process_stopconditionid": processStopconditionid,
        "closedwithfailure": closedwithfailure,
        "files": files,
        "tanknames": tanknames,
        "nominationo": nominationo,
        "announcetext": announcetext,
        "approvelist": List<dynamic>.from(approvelist.map((x) => x.toJson())),
      };
}

class Approvelist {
  final int approve;
  final dynamic remark;
  final String group;

  Approvelist({
    required this.approve,
    required this.remark,
    required this.group,
  });

  factory Approvelist.fromJson(Map<String, dynamic> json) => Approvelist(
        approve: json["approve"],
        remark: json["remark"],
        group: json["group"],
      );

  Map<String, dynamic> toJson() => {
        "approve": approve,
        "remark": remark,
        "group": group,
      };
}
