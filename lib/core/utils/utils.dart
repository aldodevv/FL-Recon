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

  static String? convertMoney(dynamic value, dynamic currencyCode) {
    if (value == null || (value is String && value.isEmpty)) return null;
    if (value == 'N/A') return value;

    final numValue = num.tryParse(value.toString());
    if (numValue == null) return null;

    final absValue = numValue.abs().toStringAsFixed(2);
    final parts = absValue.split('.');
    final integerPart = parts[0];
    final decimalPart = parts[1];

    final formattedInteger = _addThousandSeparator(integerPart);

    final formatted = '$formattedInteger,$decimalPart';
    final symbol = currencyCode != null && currencyCode.toString().isNotEmpty
        ? '${currencyCode.toString()} '
        : '';

    return '$symbol${numValue < 0 ? '-' : ''}$formatted';
  }

  static String _addThousandSeparator(String number) {
    final buffer = StringBuffer();
    int count = 0;

    for (int i = number.length - 1; i >= 0; i--) {
      buffer.write(number[i]);
      count++;
      if (count % 3 == 0 && i != 0) {
        buffer.write('.');
      }
    }

    return buffer.toString().split('').reversed.join();
  }
}

