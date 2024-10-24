class OpenTicket2Model {
  final int status;
  final String message;
  final Data data;

  OpenTicket2Model({
    required this.status,
    required this.message,
    required this.data,
  });

  factory OpenTicket2Model.fromJson(Map<String, dynamic> json) =>
      OpenTicket2Model(
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
