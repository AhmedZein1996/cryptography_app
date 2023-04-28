import 'package:encrypt/encrypt.dart';

class Symmetric {
  static Encrypted doAESEncryption(plainText, key, initializationVector) {
    final cipherInit = Encrypter(
      AES(key, mode: AESMode.cbc),
    );

    final encrypted = cipherInit.encrypt(plainText, iv: initializationVector);
    return encrypted;
  }

  static String doAESDecryption(encryptedMessage, key, initializationVector) {
    final cipherInit = Encrypter(
      AES(key, mode: AESMode.cbc),
    );
    final decryptedMessage =
        cipherInit.decrypt(encryptedMessage, iv: initializationVector);
    return decryptedMessage;
  }
}
