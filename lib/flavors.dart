import 'package:firebase_core/firebase_core.dart';
import 'package:recon/firebase_options.dart';

enum Flavor {
  dev,
  uat,
  prod,
}

class F {
  static late final Flavor appFlavor;

  static String get name => appFlavor.name;

  static String get title {
    switch (appFlavor) {
      case Flavor.dev:
        return 'Recon dev';
      case Flavor.uat:
        return 'Recon uat';
      case Flavor.prod:
        return 'Recon';
    }
  }


  static FirebaseOptions? get firebaseOptions {
    switch (appFlavor) {
      case Flavor.dev:
      case Flavor.uat:
      case Flavor.prod:
        return DefaultFirebaseOptions.currentPlatform;
      }
  }

}
