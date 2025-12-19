import 'package:recon/core/network/dio_client.dart';

class AppFailure {
  final String message;
  final ResultType type;
  final int? rc;

  const AppFailure({required this.message, required this.type, this.rc});
}
