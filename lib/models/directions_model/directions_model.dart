import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DirectionsModel {
  final LatLngBounds bounds;
  final List<PointLatLng> polylintPoints;
  final String totalDistance;
  final String totalDuration;

  const DirectionsModel({
    required this.bounds,
    required this.polylintPoints,
    required this.totalDistance,
    required this.totalDuration,
  });
  factory DirectionsModel.fromMap(Map<String, dynamic> map) {
    PolylinePoints polylinePoints = PolylinePoints();

    final data = Map<String, dynamic>.from(map['routes'][0]);
    //Bounds
    final northEast = data['bounds']['northeast'];
    final southWest = data['bounds']['southwest'];
    final bounds = LatLngBounds(
      southwest: LatLng(southWest['lat'], southWest['lng']),
      northeast: LatLng(northEast['lat'], northEast['lng']),
    );
    String distance = '';
    String duration = '';
    if ((data['legs'] as List).isNotEmpty) {
      final leg = data['legs'][0];
      distance = leg['distance']['text'];
      duration = leg['duration']['leg'];
    }
    return DirectionsModel(
      bounds: bounds,
      polylintPoints:
          polylinePoints.decodePolyline(data['overview_polyline']['points']),
      totalDistance: distance,
      totalDuration: duration,
    );
  }
}
