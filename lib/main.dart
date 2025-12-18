import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:recon/core/injection.dart';
import 'package:recon/core/log/logger.dart';

import 'app.dart';
import 'flavors.dart';

FutureOr<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();

  if (kReleaseMode) {
    debugPrint = (String? message, {int? wrapWidth}) {};
  }
  runZonedGuarded(
    () {
      FlutterError.onError = (details) {
        talker.error(
          'FlutterError',
          details.exception,
          details.stack
        );
      };
      runApp(const App());
    },
    (error, stack) {
      talker.critical(
        'ZoneError',
        error,
        stack
      );
    },
  );

  await dotenv.load(fileName: ".env");

  F.appFlavor = Flavor.values.firstWhere((element) => element.name == appFlavor, orElse: () => Flavor.dev);

  runApp(App());
}
