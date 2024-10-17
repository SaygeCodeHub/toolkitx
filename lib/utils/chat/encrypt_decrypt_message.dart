import '../../data/models/encrypt_class.dart';

class EncryptDecryptChatMessage {
  Future<String> encryptMessage(String message) async {
    if (message.isNotEmpty) {
      String encryptedMessage = await EncryptData.encryptAES(message);
      return encryptedMessage;
    } else {
      return '';
    }
  }

  Future<String> decryptMessage(String message) async {
    if (message.isNotEmpty) {
      String decryptedMessage = await EncryptData.decryptAES(message);
      return decryptedMessage;
    } else {
      return '';
    }
  }
}
