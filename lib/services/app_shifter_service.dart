import 'package:url_launcher/url_launcher.dart';

class AppShifterServices {
  AppShifterServices._();
  static Future<void> launchGoogleMaps(
    double destinationLatitude,
    double destinationLongitude,
  ) async {
    launchUrl(
      Uri.parse(
          "google.navigation:q=$destinationLatitude,$destinationLongitude"),
    );
  }

  static Future<void> contactAdmin() async {
    launchUrl(
      Uri.parse(
          "mailto:umairliaqat552@gmail.com?subject=Account%20Approval&body=Hello!"),
    );
  }
}
