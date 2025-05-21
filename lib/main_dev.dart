import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:async';
import 'app.dart';
import 'package:recon/flavors.dart';
import 'package:flutter/material.dart';


FutureOr<void> main() async {
  if (kReleaseMode) {
    debugPrint = (String? message, {int? wrapWidth}) {};
  }

  await dotenv.load(fileName: ".env.dev");
  F.appFlavor = Flavor.uat;

  runApp(App());
}

