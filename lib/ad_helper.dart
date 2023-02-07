import 'dart:io';

class AdHelper {
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-5218177686730446/9342660051";
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }
}