import 'package:flutter/material.dart';
import 'package:life_link/UI/screens/map_screen/map_screen.dart';
import 'package:life_link/config/size_config.dart';
import 'package:life_link/models/driver_model/driver_model.dart';
import 'package:life_link/models/hospital_model/hospital_model.dart';
import 'package:life_link/models/request_model/request_model.dart';
import 'package:life_link/services/app_shifter_service.dart';
import 'package:life_link/utils/assets.dart';
import 'package:life_link/utils/colors.dart';
import 'package:life_link/utils/enums.dart';

class RideInProgressScreen extends StatefulWidget {
  const RideInProgressScreen({
    super.key,
    required this.requestModel,
    required this.hospitalModel,
    required this.driverModel,
  });
  final RequestModel requestModel;
  final HospitalModel hospitalModel;
  final DriverModel driverModel;

  @override
  State<RideInProgressScreen> createState() => _RideInProgressScreenState();
}

class _RideInProgressScreenState extends State<RideInProgressScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            MapScreen(
              marker1Longitude: widget.requestModel.patientLon,
              marker1Latitude: widget.requestModel.patientLat,
              marker2Longitude: 74.3289704,
              marker2Latitude: 31.5003713,
              userType: UserType.patient,
            ),
            Container(
              height: SizeConfig.height(context),
              width: SizeConfig.width(context),
              decoration: BoxDecoration(
                color: lightGreyColor.withOpacity(0.7),
              ),
              child: TextButton(
                onPressed: () {
                  AppShifterServices.launchGoogleMaps(
                    widget.requestModel.patientLat,
                    widget.requestModel.patientLon,
                  );
                },
                child: Row(
                  children: [
                    Image.asset(
                      Assets.googleMapsImage,
                      height: SizeConfig.height20(context) * 4,
                      width: SizeConfig.width20(context) * 4,
                    ),
                    Text(
                      "Go to google maps",
                      style: TextStyle(
                        fontSize: SizeConfig.font24(context) + 1,
                        color: blackColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
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
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: SizeConfig.font20(context),
                                    ),
                                  ),
                                  Text(
                                    "From : ${widget.hospitalModel.name}",
                                    style: TextStyle(
                                      fontSize: SizeConfig.font12(context),
                                      color: greyColor,
                                    ),
                                  ),
                                  SizedBox(
                                    height: SizeConfig.height8(context),
                                  ),
                                  Text(
                                    "Arriving in : 20 min",
                                    style: TextStyle(
                                      fontSize: SizeConfig.font18(context),
                                      color: greyColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
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
}
