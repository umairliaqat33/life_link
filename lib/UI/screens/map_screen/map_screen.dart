import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:life_link/config/size_config.dart';
import 'package:life_link/models/driver_model/driver_model.dart';
import 'package:life_link/models/hospital_model/hospital_model.dart';
import 'package:life_link/models/request_model/request_model.dart';
import 'package:life_link/services/image_to_marker.dart';
import 'package:life_link/utils/assets.dart';
import 'package:life_link/utils/colors.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({
    super.key,
    required this.requestModel,
    required this.hospitalModel,
    required this.driverModel,
  });
  final RequestModel requestModel;
  final HospitalModel hospitalModel;
  final DriverModel driverModel;

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
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          alignment: Alignment.bottomCenter,
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
              // onCameraMove: (value) {
              //   _customInfoWindowController.onCameraMove!();
              // },
            ),
            Padding(
              padding: EdgeInsets.all(SizeConfig.height15(context)),
              child: BottomSheet(
                onClosing: () {},
                builder: (BuildContext context) {
                  return Padding(
                    padding: EdgeInsets.all(SizeConfig.height8(context)),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: SizeConfig.width10(context) * 8 / 2,
                                child: widget.driverModel.profilePicture.isEmpty
                                    ? Image.asset(
                                        Assets.blankProfilePicture,
                                        height:
                                            SizeConfig.height10(context) * 10,
                                        width: SizeConfig.width10(context) * 8,
                                      )
                                    : ClipOval(
                                        child: Image.network(
                                          widget.driverModel.profilePicture,
                                          height:
                                              SizeConfig.height10(context) * 10,
                                          width:
                                              SizeConfig.width10(context) * 8,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                              ),
                              SizedBox(
                                width: SizeConfig.width8(context),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.driverModel.name.toUpperCase(),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20,
                                    ),
                                  ),
                                  Text(
                                    "From : ${widget.hospitalModel.name}",
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: greyColor,
                                    ),
                                  ),
                                  SizedBox(
                                    height: SizeConfig.height8(context),
                                  ),
                                  const Text(
                                    "Arriving in : 20 min",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: greyColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
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
    if (!mounted) return;
    setState(() {});
  }
}
