import 'dart:convert';
import 'package:crypto/crypto.dart';

class ChatIdUtil {
  static String build(String a, String b) {
    final sorted = [a, b]..sort();
    final raw = '${sorted[0]}:${sorted[1]}';
    return sha256.convert(utf8.encode(raw)).toString();
  }
}
