import 'dart:convert';

SaveQualityManagementPhotos saveQualityManagementPhotosFromJson(String str) =>
    SaveQualityManagementPhotos.fromJson(json.decode(str));

String saveQualityManagementPhotosToJson(SaveQualityManagementPhotos data) =>
    json.encode(data.toJson());

class SaveQualityManagementPhotos {
  final int status;
  final String message;
  final Data data;

  SaveQualityManagementPhotos({
    required this.status,
    required this.message,
    required this.data,
  });

  factory SaveQualityManagementPhotos.fromJson(Map<String, dynamic> json) =>
      SaveQualityManagementPhotos(
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
  Data();

  factory Data.fromJson(Map<String, dynamic> json) => Data();

  Map<String, dynamic> toJson() => {};
}
