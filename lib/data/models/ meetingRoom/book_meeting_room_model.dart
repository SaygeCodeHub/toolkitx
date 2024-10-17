import 'dart:convert';

BookMeetingRoomModel bookMeetingRoomModelFromJson(String str) =>
    BookMeetingRoomModel.fromJson(json.decode(str));

String bookMeetingRoomModelToJson(BookMeetingRoomModel data) =>
    json.encode(data.toJson());

class BookMeetingRoomModel {
  final int status;
  final String message;
  final Data data;

  BookMeetingRoomModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory BookMeetingRoomModel.fromJson(Map<String, dynamic> json) =>
      BookMeetingRoomModel(
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
