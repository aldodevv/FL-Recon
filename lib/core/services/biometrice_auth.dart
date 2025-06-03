import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_darwin/local_auth_darwin.dart';

class BiometriceAuth {
  static final _auth = LocalAuthentication();
  
  /// Mengecek apakah perangkat mendukung biometrik
  static Future<bool> isDeviceSupported() async {
    try {
      final canCheck = await _auth.canCheckBiometrics;
      final isSupported = await _auth.isDeviceSupported();
      return canCheck && isSupported;
    } catch (e) {
      return false;
    }
  }

  /// Melakukan autentikasi biometrik
  static Future<bool> authenticate({
    String? title,
    String? hint,
    String? description,
    String? cancelLabel,
  }) async {
    try {
      return await _auth.authenticate(
        localizedReason: description ?? 'Scan sidik jari untuk login!',
        options: const AuthenticationOptions(
          biometricOnly: true,
        ),
        authMessages: <AuthMessages>[
          AndroidAuthMessages(
            signInTitle: title ?? 'Autentikasi Biometrik',
            biometricHint: hint,
            cancelButton: cancelLabel ?? 'Batalkan',
          ),
          IOSAuthMessages(
            cancelButton: cancelLabel ?? 'Batalkan',
          ),
        ],
      );
    } catch (e) {
      return false;
    }
  }
}
