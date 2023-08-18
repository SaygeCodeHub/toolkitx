
import 'dart:convert';
FetchCurrentSignInModel fetchCurrentSignInModelFromJson(String str) => FetchCurrentSignInModel.fromJson(json.decode(str));
String fetchCurrentSignInModelToJson(FetchCurrentSignInModel data) => json.encode(data.toJson());
class FetchCurrentSignInModel {
final int status;
final String message;
final Data data;
FetchCurrentSignInModel({
required this.status,
required this.message,
required this.data,
});
factory FetchCurrentSignInModel.fromJson(Map<String, dynamic> json) => FetchCurrentSignInModel(
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
final String location;
final String locationid;
final String submitdate;
Data({
required this.location,
required this.locationid,
required this.submitdate,
});
factory Data.fromJson(Map<String, dynamic> json) => Data(
location: json["location"],
locationid: json["locationid"],
submitdate: json["submitdate"],
);
Map<String, dynamic> toJson() => {
"location": location,
"locationid": locationid,
"submitdate": submitdate,
};
}