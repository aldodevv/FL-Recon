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

}
