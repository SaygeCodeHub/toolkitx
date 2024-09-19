import 'dart:convert';

SaveTicket2Model saveTicket2ModelFromJson(String str) =>
    SaveTicket2Model.fromJson(json.decode(str));

String saveTicket2ModelToJson(SaveTicket2Model data) =>
    json.encode(data.toJson());

class SaveTicket2Model {
  final int status;
  final String message;
  final Data data;

  SaveTicket2Model({
    required this.status,
    required this.message,
    required this.data,
  });

  factory SaveTicket2Model.fromJson(Map<String, dynamic> json) =>
      SaveTicket2Model(
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
