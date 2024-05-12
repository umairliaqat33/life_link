import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:life_link/constants/constants.dart';
import 'package:life_link/models/directions_model/directions_model.dart';

class DirectionsAPISerivce {
  static const String _baseUrl =
      "https://maps.googleapis.com/maps/api/directions/json";
  final Dio _dio = Dio();
  Future<DirectionsModel?> getDirections({
    required LatLng origin,
    required LatLng destination,
  }) async {
    final response = await _dio.get(
      _baseUrl,
      queryParameters: {
        'origin': '${origin.latitude},${origin.longitude}',
        'destination': '${destination.latitude},${destination.longitude}',
        'key': mapsAPIKey,
      },
    );
    if (response.statusCode == 200) {
      return DirectionsModel.fromMap(response.data);
    } else {
      return null;
    }
  }
}
