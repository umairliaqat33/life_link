import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:life_link/config/size_config.dart';
import 'package:life_link/services/directins_api_service.dart';
import 'package:life_link/services/image_to_marker.dart';
import 'package:life_link/utils/assets.dart';
import 'package:life_link/utils/colors.dart';
import 'package:life_link/utils/enums.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({
    super.key,
    required this.marker1Longitude,
    required this.marker1Latitude,
    required this.marker2Longitude,
    required this.marker2Latitude,
    required this.userType,
  });
  final double marker1Longitude;
  final double marker1Latitude;
  final double marker2Longitude;
  final double marker2Latitude;
  final UserType userType;

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng _center = const LatLng(31.5003713, 74.3289704);
  GoogleMapController? _mapController;
  final Set<Marker> _marketList = {};
  final Set<Polyline> _polylineList = {};
  final List<LatLng> _positionsList = [];

  String? _mapStyle;
  @override
  void initState() {
    super.initState();
    _setCenter();
    _addMarkers();
    _addPolyline();
    _setMapStyle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 16,
            ),
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            onMapCreated: _onMapCreated,
            markers: _marketList,
            zoomControlsEnabled: false,
            polylines: _polylineList,
            // onCameraMove: (value) {
            //   _customInfoWindowController.onCameraMove!();
            // },
          ),
        ],
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

  void _getDirections() async {
    final DirectionsAPISerivce directionsAPISerivce = DirectionsAPISerivce();
    final directions = await directionsAPISerivce.getDirections(
      origin: LatLng(widget.marker1Latitude, widget.marker1Longitude),
      destination: LatLng(widget.marker2Latitude, widget.marker2Longitude),
    );
    if (directions != null) {
      _polylineList.add(
        Polyline(
          polylineId: const PolylineId("New PolyLine"),
          color: orangeColor,
          width: SizeConfig.width5(context),
          points: directions.polylintPoints
              .map((e) => LatLng(e.latitude, e.longitude))
              .toList(),
        ),
      );
    }

    setState(() {});
  }

  void _addPolyline() {
    _positionsList.add(LatLng(widget.marker1Latitude, widget.marker1Longitude));
    _positionsList.add(LatLng(widget.marker2Latitude, widget.marker2Longitude));
    for (int i = 0; i < _positionsList.length; i++) {
      _polylineList.add(
        Polyline(
          polylineId: PolylineId("polylineId $i"),
          points: _positionsList,
          width: 2,
        ),
      );
    }
  }

  void _addMarkers() {
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

  void _setMapStyle() {
    rootBundle.loadString('assets/map.txt').then((string) {
      _mapStyle = string;
    });
  }

  void _setCenter() {
    _center = widget.userType == UserType.driver
        ? LatLng(widget.marker1Latitude, widget.marker1Longitude)
        : LatLng(widget.marker2Latitude, widget.marker2Longitude);
    setState(() {});
  }
}
