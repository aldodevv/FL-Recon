import 'app.dart';
import 'package:recon/flavors.dart';
import 'package:flutter/material.dart';

void main() {
  F.appFlavor = Flavor.uat;
  runApp(App());
}
