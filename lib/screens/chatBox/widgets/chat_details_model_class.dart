class ChatDetails {
  final List<Chat> chatDetails;

  ChatDetails({required this.chatDetails});
}

class Chat {
  final String? employeeId;
  final String? employeeName;
  final String? message;

  Chat({this.employeeId = '', this.employeeName = '', this.message = ''});
}
