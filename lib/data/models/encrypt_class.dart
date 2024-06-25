import 'package:encrypt/encrypt.dart';

class EncryptData {
  static final key = Key.fromUtf8('8a9373b2a1b9f7e0984351dcea683675');
  static final iv = IV.fromUtf8('8080808080808080');
  static final encryptValue = Encrypter(AES(key, mode: AESMode.cbc));

  static encryptAES(text) {
    final encrypted = encryptValue.encrypt(text, iv: iv).base64;
    return encrypted;
  }

  static decryptAES(text) {
    final decrypted = encryptValue.decrypt64(text, iv: iv);
    return decrypted;
  }

  static encryptAESPrivateKey(text, aipKey) {
    final decryptedApiKey = encryptValue.decrypt64(aipKey, iv: iv);
    final priKey = Key.fromUtf8(decryptedApiKey.replaceAll('-', ''));
    final encryptPriKeyValue = Encrypter(AES(priKey, mode: AESMode.cbc));
    final encrypted = encryptPriKeyValue.encrypt(text, iv: iv).base64;
    return encrypted;
  }

  static decryptAESPrivateKey(text, aipKey) {
    final decryptedApiKey = encryptValue.decrypt64(aipKey, iv: iv);
    final priKey = Key.fromUtf8(decryptedApiKey.replaceAll('-', ''));
    final decryptPriKeyValue = Encrypter(AES(priKey, mode: AESMode.cbc));
    final decrypted = decryptPriKeyValue.decrypt64(text, iv: iv);
    return decrypted;
  }
}
