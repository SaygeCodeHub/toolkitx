import 'dart:convert';

FetchCertificateListModel fetchCertificateListModelFromJson(String str) =>
    FetchCertificateListModel.fromJson(json.decode(str));

String fetchCertificateListModelToJson(FetchCertificateListModel data) =>
    json.encode(data.toJson());

class FetchCertificateListModel {
  final int status;
  final String message;
  final List<CertificateListDatum> data;

  FetchCertificateListModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory FetchCertificateListModel.fromJson(Map<String, dynamic> json) =>
      FetchCertificateListModel(
        status: json["Status"],
        message: json["Message"],
        data: List<CertificateListDatum>.from(
            json["Data"].map((x) => CertificateListDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Status": status,
        "Message": message,
        "Data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class CertificateListDatum {
  final String id;
  final String name;
  final String actualDates;
  final String newDates;
  final String actualCertificate;
  final NewCertificate newCertificate;
  final dynamic status;
  final String expired;
  final String accesscertificate;
  final String accessfeedback;
  final String accessfeedbackedit;

  CertificateListDatum({
    required this.id,
    required this.name,
    required this.actualDates,
    required this.newDates,
    required this.actualCertificate,
    required this.newCertificate,
    required this.status,
    required this.expired,
    required this.accesscertificate,
    required this.accessfeedback,
    required this.accessfeedbackedit,
  });

  factory CertificateListDatum.fromJson(Map<String, dynamic> json) =>
      CertificateListDatum(
        id: json["id"],
        name: json["name"],
        actualDates: json["actual_dates"] ?? '',
        newDates: json["new_dates"] ?? '',
        actualCertificate: json["actual_certificate"],
        newCertificate: newCertificateValues.map[json["new_certificate"]]!,
        status: json["status"] ?? '',
        expired: json["expired"],
        accesscertificate: json["accesscertificate"],
        accessfeedback: json["accessfeedback"],
        accessfeedbackedit: json["accessfeedbackedit"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "actual_dates": actualDates,
        "new_dates": newDates,
        "actual_certificate": actualCertificate,
        "new_certificate": newCertificateValues.reverse[newCertificate],
        "status": status,
        "expired": expired,
        "accesscertificate": accesscertificate,
        "accessfeedback": accessfeedback,
        "accessfeedbackedit": accessfeedbackedit,
      };
}

enum NewCertificate {
  EMPTY,
  THE_6_BK_T_EA_OFO_H_BLJ_FO3_G_WSJ2_ZS_RT_PD_Y0_NP_JP_Q_IM_TJ_PZKK,
  UN_YG93_W_CK_DO_CV4_E_GWHJ6_AQ_E_SU2_R1_CC_VH_KW_K_EDY_V_FWG
}

final newCertificateValues = EnumValues({
  "": NewCertificate.EMPTY,
  "6BkTEaOfoHBljFO3GWsj2zsRtPd/y0npJpQImTJPzkk=": NewCertificate
      .THE_6_BK_T_EA_OFO_H_BLJ_FO3_G_WSJ2_ZS_RT_PD_Y0_NP_JP_Q_IM_TJ_PZKK,
  "unYg93wCkDoCv4eGwhj6aqE+su2R1ccVHKwKEdyVFwg=": NewCertificate
      .UN_YG93_W_CK_DO_CV4_E_GWHJ6_AQ_E_SU2_R1_CC_VH_KW_K_EDY_V_FWG
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
