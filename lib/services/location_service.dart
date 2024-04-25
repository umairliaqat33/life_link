import 'dart:developer';

import 'package:geolocator/geolocator.dart';

class LocationService {
  static Future<Position?> getCurrentPosition() async {
    LocationPermission permission;

    Position? position;
    try {
      await Geolocator.isLocationServiceEnabled();
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return Future.error('Location permissions are denied');
        }
      }
      if (permission == LocationPermission.deniedForever) {
        Geolocator.openLocationSettings();
        return Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      }
      position = await Geolocator.getCurrentPosition();
    } catch (e) {
      log(e.toString());
    }
    return position;
  }
}
