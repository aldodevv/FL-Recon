import 'package:encrypt/encrypt.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Utils {
  static String encryptWithKey(String value) {
    final key = Key.fromUtf8('X83YQ1PXXS34PJEV');
    final encrypter = Encrypter(AES(key, mode: AESMode.ecb, padding: 'PKCS7'));
    final encrypted = encrypter.encrypt(value, iv: IV.fromLength(0));
    return encrypted.base64;
  }
  
  static final FlutterSecureStorage storageSecure = FlutterSecureStorage(
    aOptions: AndroidOptions(),
    iOptions: IOSOptions(
      accessibility: KeychainAccessibility.unlocked_this_device
    )
  );
}

