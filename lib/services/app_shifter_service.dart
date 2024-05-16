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
}
