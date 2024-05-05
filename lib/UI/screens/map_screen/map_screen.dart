import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:life_link/models/request_model/request_model.dart';
import 'package:life_link/services/image_to_marker.dart';
import 'package:life_link/utils/assets.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({
    super.key,
    required this.requestModel,
  });
  final RequestModel requestModel;

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _mapController;
  final LatLng _center = const LatLng(31.5006602, 74.3295742);
  final Set<Marker> _marketList = {};
  String? _mapStyle;
  @override
  void initState() {
    super.initState();
    rootBundle.loadString('assets/map.txt').then((string) {
      _mapStyle = string;
    });
    _setMarkers(
      markerLongitude: widget.requestModel.patientLon,
      markerLatitude: widget.requestModel.patientLat,
      image: Assets.patientOnGroundIcon,
      markerId: "Patient",
      infoWindowText: "I am here come pick me up",
      markerSize: 100,
    );
    _setMarkers(
      markerLongitude: 74.2901811,
      markerLatitude: 31.5817799,
      image: Assets.ambulanceIcon,
      markerId: "Driver",
      infoWindowText: "I am driver",
      markerSize: 100,
    );
  }

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
          onMapCreated: _onMapCreated,
          markers: _marketList,
          zoomControlsEnabled: false,
          // onCameraMove: (value) {
          //   _customInfoWindowController.onCameraMove!();
          // },
        ),
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    _mapController!.setMapStyle(_mapStyle);
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
    setState(() {});
  }
}
