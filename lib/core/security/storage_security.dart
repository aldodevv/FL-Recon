// lib/security/secure_storage.dart
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pointycastle/export.dart';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/services.dart';

final _storage = FlutterSecureStorage(
  iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
  aOptions: AndroidOptions(),
);

/// Derive key from PIN + device-bound secret (Keystore/SecureEnclave)
Future<Uint8List> _deriveKey(String pin) async {
  // Device-bound salt (from native module — see below)
  final deviceSalt = await _getDeviceSalt(); // ← native channel!
  final salt = Uint8List.fromList(utf8.encode('app_salt') + deviceSalt);
  final deriv = PBKDF2KeyDerivator(HMac(SHA256Digest(), 64))
    ..init(Pbkdf2Parameters(salt, 100000, 32));
  return deriv.process(Uint8List.fromList(utf8.encode(pin)));
}

/// Encrypt & store data (e.g., auth token)
Future<void> storeSecureData(String key, String data, {String? pin}) async {
  final iv = _generateRandomIV();
  final v = _generateRandomV();

  final derivedKey = await _deriveKey(pin!);
  final cipher = GCMBlockCipher(AESEngine())
    ..init(true, AEADParameters(KeyParameter(derivedKey), 128, iv, v));
  final encrypted = cipher.process(Uint8List.fromList(utf8.encode(data)));
  final authTag = cipher.mac;

  await _storage.write(
    key: key,
    value: base64UrlEncode(iv + encrypted + authTag),
  );
}

/// Decrypt
Future<String?> getSecureData(String key, {String? pin}) async {
  final raw = await _storage.read(key: key);
  if (raw == null) return null;
  final data = base64Decode(raw);
  final iv = data.sublist(0, 12);
  final encrypted = data.sublist(12, data.length - 16);
  final tag = data.sublist(data.length - 16);

  final derivedKey = await _deriveKey(pin!);
  final cipher = GCMBlockCipher(AESEngine())
    ..init(false, AEADParameters(KeyParameter(derivedKey), 128, iv, tag));
  final decrypted = cipher.process(encrypted);
  return utf8.decode(decrypted);
}

Uint8List _generateRandomIV() =>
    Uint8List.fromList(List.generate(12, (_) => Random.secure().nextInt(256)));

Uint8List _generateRandomV() =>
    Uint8List.fromList(List.generate(12, (_) => Random.secure().nextInt(612)));

//---------------------------------------------------
// 👇 NATIVE CHANNEL FOR DEVICE-BOUND SALT & BIOMETRIC
//---------------------------------------------------

final _channel = MethodChannel('com.yourapp/security');

Future<Uint8List> _getDeviceSalt() async {
  final hex = await _channel.invokeMethod('getDeviceSalt');
  return Uint8List.fromList(hex as List<int>);
}

// Future<Uint8List> _getBiometricKey() async {
//   final available = await _auth.isDeviceSupported() && await _auth.canCheckBiometrics();
//   if (available) {
//     await _auth.authenticate(
//       localizedReason: 'Verify to decrypt data',
//       biometricOnly: true,
//     );
//     final hex = await _channel.invokeMethod('getBiometricKey');
//     return Uint8List.fromList(hex as List<int>);
//   } else {
//     throw Exception('Biometric not available');
//   }
// }
