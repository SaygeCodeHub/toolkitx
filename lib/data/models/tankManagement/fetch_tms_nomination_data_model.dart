import 'dart:convert';

FetchTmsNominationDataModel fetchTmsNominationDataModelFromJson(String str) => FetchTmsNominationDataModel.fromJson(json.decode(str));

String fetchTmsNominationDataModelToJson(FetchTmsNominationDataModel data) => json.encode(data.toJson());

class FetchTmsNominationDataModel {
  final int status;
  final String message;
  final Data data;

  FetchTmsNominationDataModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory FetchTmsNominationDataModel.fromJson(Map<String, dynamic> json) => FetchTmsNominationDataModel(
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
  final String product;
  final String tank;
  final String licenseplate;
  final String id;
  final String nominationid;
  final String fillinglevel;
  final String temperature;
  final String density;
  final String entrydate;
  final String entryweight;
  final String exitweight;
  final String exitdate;
  final String thaOpereationCompleted;
  final String startdate;
  final String enddate;
  final String postOperationSourceTankVolume;
  final String preOperationSourceTankVolume;
  final String postOperationDestinationTankVolume;
  final String updateddate;
  final String tankinitialweight;
  final String tankinitiallevel;
  final String tankfinalweight;
  final String tankfinallevel;
  final String reportingtime;
  final String thaintime;
  final String thaouttime;
  final String quantity;
  final List<Tankreading> sourcetankreading;
  final List<Tankreading> destinationtankreading;

  Data({
    required this.product,
    required this.tank,
    required this.licenseplate,
    required this.id,
    required this.nominationid,
    required this.fillinglevel,
    required this.temperature,
    required this.density,
    required this.entrydate,
    required this.entryweight,
    required this.exitweight,
    required this.exitdate,
    required this.thaOpereationCompleted,
    required this.startdate,
    required this.enddate,
    required this.postOperationSourceTankVolume,
    required this.preOperationSourceTankVolume,
    required this.postOperationDestinationTankVolume,
    required this.updateddate,
    required this.tankinitialweight,
    required this.tankinitiallevel,
    required this.tankfinalweight,
    required this.tankfinallevel,
    required this.reportingtime,
    required this.thaintime,
    required this.thaouttime,
    required this.quantity,
    required this.sourcetankreading,
    required this.destinationtankreading,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    product: json["product"],
    tank: json["tank"],
    licenseplate: json["licenseplate"],
    id: json["id"],
    nominationid: json["nominationid"],
    fillinglevel: json["fillinglevel"],
    temperature: json["temperature"],
    density: json["density"],
    entrydate: json["entrydate"],
    entryweight: json["entryweight"],
    exitweight: json["exitweight"],
    exitdate: json["exitdate"],
    thaOpereationCompleted: json["tha_opereation_completed"],
    startdate: json["startdate"],
    enddate: json["enddate"],
    postOperationSourceTankVolume: json["post_operation_source_tank_volume"],
    preOperationSourceTankVolume: json["pre_operation_source_tank_volume"],
    postOperationDestinationTankVolume: json["post_operation_destination_tank_volume"],
    updateddate: json["updateddate"],
    tankinitialweight: json["tankinitialweight"],
    tankinitiallevel: json["tankinitiallevel"],
    tankfinalweight: json["tankfinalweight"],
    tankfinallevel: json["tankfinallevel"],
    reportingtime: json["reportingtime"],
    thaintime: json["thaintime"],
    thaouttime: json["thaouttime"],
    quantity: json["quantity"],
    sourcetankreading: List<Tankreading>.from(json["sourcetankreading"].map((x) => Tankreading.fromJson(x))),
    destinationtankreading: List<Tankreading>.from(json["destinationtankreading"].map((x) => Tankreading.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "product": product,
    "tank": tank,
    "licenseplate": licenseplate,
    "id": id,
    "nominationid": nominationid,
    "fillinglevel": fillinglevel,
    "temperature": temperature,
    "density": density,
    "entrydate": entrydate,
    "entryweight": entryweight,
    "exitweight": exitweight,
    "exitdate": exitdate,
    "tha_opereation_completed": thaOpereationCompleted,
    "startdate": startdate,
    "enddate": enddate,
    "post_operation_source_tank_volume": postOperationSourceTankVolume,
    "pre_operation_source_tank_volume": preOperationSourceTankVolume,
    "post_operation_destination_tank_volume": postOperationDestinationTankVolume,
    "updateddate": updateddate,
    "tankinitialweight": tankinitialweight,
    "tankinitiallevel": tankinitiallevel,
    "tankfinalweight": tankfinalweight,
    "tankfinallevel": tankfinallevel,
    "reportingtime": reportingtime,
    "thaintime": thaintime,
    "thaouttime": thaouttime,
    "quantity": quantity,
    "sourcetankreading": List<dynamic>.from(sourcetankreading.map((x) => x.toJson())),
    "destinationtankreading": List<dynamic>.from(destinationtankreading.map((x) => x.toJson())),
  };
}

class Tankreading {
  final String tankname;
  final String openProductlevel;
  final String openTotalobservedvolume;
  final String openProducttemperature;
  final String openMassliquid;
  final String closeProductlevel;
  final String closeTotalobservedvolume;
  final String closeProducttemperature;
  final String closeMassliquid;

  Tankreading({
    required this.tankname,
    required this.openProductlevel,
    required this.openTotalobservedvolume,
    required this.openProducttemperature,
    required this.openMassliquid,
    required this.closeProductlevel,
    required this.closeTotalobservedvolume,
    required this.closeProducttemperature,
    required this.closeMassliquid,
  });

  factory Tankreading.fromJson(Map<String, dynamic> json) => Tankreading(
    tankname: json["tankname"],
    openProductlevel: json["open_productlevel"],
    openTotalobservedvolume: json["open_totalobservedvolume"],
    openProducttemperature: json["open_producttemperature"],
    openMassliquid: json["open_massliquid"],
    closeProductlevel: json["close_productlevel"],
    closeTotalobservedvolume: json["close_totalobservedvolume"],
    closeProducttemperature: json["close_producttemperature"],
    closeMassliquid: json["close_massliquid"],
  );

  Map<String, dynamic> toJson() => {
    "tankname": tankname,
    "open_productlevel": openProductlevel,
    "open_totalobservedvolume": openTotalobservedvolume,
    "open_producttemperature": openProducttemperature,
    "open_massliquid": openMassliquid,
    "close_productlevel": closeProductlevel,
    "close_totalobservedvolume": openTotalobservedvolume,
    "close_producttemperature": closeProducttemperature,
    "close_massliquid": closeMassliquid,
  };
}
