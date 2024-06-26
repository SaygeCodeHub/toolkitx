class AttachmentDownloadModel {
  final int status;
  final String message;
  final Map<String, dynamic> data;

  AttachmentDownloadModel(
      {required this.status, required this.message, required this.data});

  factory AttachmentDownloadModel.fromJson(Map<String, dynamic> json) {
    return AttachmentDownloadModel(
      status: json['Status'] ?? 0,
      message: json['Message'] ?? '',
      data: json['Data'] ?? {},
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Status'] = status;
    data['Message'] = message;
    data['Data'] = this.data;
    return data;
  }
}
