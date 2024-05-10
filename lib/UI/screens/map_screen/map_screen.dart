import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:life_link/services/image_to_marker.dart';
import 'package:life_link/utils/assets.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({
    super.key,
    required this.marker1Longitude,
    required this.marker1Latitude,
    required this.marker2Longitude,
    required this.marker2Latitude,
  });
  final double marker1Longitude;
  final double marker1Latitude;
  final double marker2Longitude;
  final double marker2Latitude;

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final LatLng _center = const LatLng(31.5006602, 74.3295742);
  GoogleMapController? _mapController;
  final Set<Marker> _marketList = {};
  String? _mapStyle;
  @override
  void initState() {
    super.initState();
    rootBundle.loadString('assets/map.txt').then((string) {
      _mapStyle = string;
    });
    _setMarkers(
      markerLongitude: widget.marker1Longitude,
      markerLatitude: widget.marker1Latitude,
      image: Assets.patientOnGroundIcon,
      markerId: "Patient",
      infoWindowText: "I am here come pick me up",
      markerSize: 100,
    );
    _setMarkers(
      markerLongitude: widget.marker2Longitude,
      markerLatitude: widget.marker2Latitude,
      image: Assets.ambulanceIcon,
      markerId: "Driver",
      infoWindowText: "I am driver",
      markerSize: 100,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 16,
        ),
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
        onMapCreated: _onMapCreated,
        markers: _marketList,
        zoomControlsEnabled: false,
        // onCameraMove: (value) {
        //   _customInfoWindowController.onCameraMove!();
        // },
      ),
    );
  }

  Future<void> _setMarkers({
    required double markerLongitude,
    required double markerLatitude,
    required String image,
    required String markerId,
    required String infoWindowText,
    required int markerSize,
  }) async {
    Uint8List markerImage = await ImageTOMarker.getImageFromBytes(
      markerSize,
      image,
    );
    final marker = Marker(
      icon: image.isEmpty
          ? BitmapDescriptor.defaultMarker
          : BitmapDescriptor.fromBytes(markerImage),
      markerId: MarkerId(markerId),
      position: LatLng(markerLatitude, markerLongitude),
    );
    _marketList.add(marker);
    if (!mounted) return;
    setState(() {});
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    _mapController!.setMapStyle(_mapStyle);
  }
}
