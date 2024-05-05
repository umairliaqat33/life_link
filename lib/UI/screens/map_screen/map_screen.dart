import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _mapController;
  final LatLng _center = const LatLng(31.5006602, 74.3295742);
  @override
  void dispose() {
    _mapController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 16,
          ),
          myLocationButtonEnabled: true,
          myLocationEnabled: true,
          onMapCreated: (GoogleMapController controller) {
            _mapController = controller;
          },
          zoomControlsEnabled: false,
          // onCameraMove: (value) {
          //   _customInfoWindowController.onCameraMove!();
          // },
        ),
      ),
    );
  }
}
