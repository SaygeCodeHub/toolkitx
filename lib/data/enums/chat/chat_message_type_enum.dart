enum ChatMessageTypeEnum {
  text(messageType: "1"),
  image(messageType: "2"),
  video(messageType: "3"),
  document(messageType: "4");

  const ChatMessageTypeEnum({required this.messageType});

  final String messageType;
}
