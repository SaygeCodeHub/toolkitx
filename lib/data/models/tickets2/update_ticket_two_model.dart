class UpdateTicketTwoModel {
  final int status;
  final String message;
  final Data data;

  UpdateTicketTwoModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory UpdateTicketTwoModel.fromJson(Map<String, dynamic> json) =>
      UpdateTicketTwoModel(
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
