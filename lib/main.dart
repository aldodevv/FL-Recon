import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:recon/core/di/servicelocator_di.dart';

import 'app.dart';
import 'flavors.dart';

FutureOr<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();

  if (kReleaseMode) {
    debugPrint = (String? message, {int? wrapWidth}) {};
  }

  await dotenv.load(fileName: ".env");
  F.appFlavor = Flavor.values.firstWhere(
    (element) => element.name == appFlavor,
  );

  runApp(App());
}
