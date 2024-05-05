import 'package:flutter/material.dart';
import 'package:life_link/UI/screens/drivers_screen/components/driver_viewing_alert.dart';
import 'package:life_link/UI/widgets/alerts/deletion_alert.dart';
import 'package:life_link/UI/widgets/switchs/custom_switch.dart';
import 'package:life_link/config/size_config.dart';
import 'package:life_link/controllers/firestore_controller.dart';
import 'package:life_link/models/driver_model/driver_model.dart';
import 'package:life_link/utils/assets.dart';
import 'package:life_link/utils/colors.dart';
import 'package:life_link/utils/enums.dart';

class DriverCardWidget extends StatefulWidget {
  const DriverCardWidget({
    super.key,
    required this.driverModel,
  });
  final DriverModel driverModel;

  @override
  State<DriverCardWidget> createState() => _DriverCardWidgetState();
}

class _DriverCardWidgetState extends State<DriverCardWidget> {
  late bool _toggleValue;

  @override
  void initState() {
    super.initState();
    _toggleValue = widget.driverModel.isAvailable;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(SizeConfig.width5(context)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.driverModel.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: SizeConfig.font18(context),
                    color: appTextColor,
                  ),
                ),
                CustomSwitch(
                  value: _toggleValue,
                  onChanged: (value) => _toggleOnChanged(value),
                  activeColor: Colors.green,
                  inactiveColor: Colors.red,
                )
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: SizeConfig.width10(context) * 8 / 2,
                  child: widget.driverModel.profilePicture.isEmpty
                      ? Image.asset(
                          Assets.blankProfilePicture,
                          height: SizeConfig.height10(context) * 10,
                          width: SizeConfig.width10(context) * 8,
                        )
                      : ClipOval(
                          child: Image.network(
                            widget.driverModel.profilePicture,
                            height: SizeConfig.height10(context) * 10,
                            width: SizeConfig.width10(context) * 8,
                            fit: BoxFit.fill,
                          ),
                        ),
                ),
                SizedBox(
                  width: SizeConfig.width5(context),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                        border: Border.all(
                          color: _toggleValue
                              ? driverAvailableBubbleBorderColor
                              : driverNotAvailableBubbleBorderColor,
                        ),
                        color: _toggleValue
                            ? driverAvailableBubbleColor
                            : driverNotAvailableBubbleColor,
                      ),
                      padding: EdgeInsets.all(
                        SizeConfig.height5(context),
                      ),
                      child: Text(
                        _toggleValue
                            ? Availability.available.name
                            : Availability.unavailable.name,
                        style: TextStyle(
                          fontSize: SizeConfig.font12(context),
                          color: whiteColor,
                        ),
                      ),
                    ),
                    // Text(
                    //   widget.driverModel.speciality,
                    //   style: TextStyle(
                    //     fontSize: SizeConfig.font12(context),
                    //     color: appTextColor,
                    //   ),
                    // ),
                    Row(
                      children: [
                        MaterialButton(
                          color: primaryColor,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(
                                10,
                              ),
                            ),
                          ),
                          onPressed: () => _viewDriverButton(
                            context,
                            widget.driverModel,
                          ),
                          child: Text(
                            "View Driver",
                            style: TextStyle(
                              color: whiteColor,
                              fontSize: SizeConfig.font12(context),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: SizeConfig.width8(context),
                        ),
                        MaterialButton(
                          color: redColor,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(
                                10,
                              ),
                            ),
                          ),
                          onPressed: () => _deleteDriver(
                            context,
                            widget.driverModel.uid,
                          ),
                          child: Text(
                            "Delete Driver",
                            style: TextStyle(
                              color: whiteColor,
                              fontSize: SizeConfig.font12(context),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _viewDriverButton(
    BuildContext context,
    DriverModel driver,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DriverViewingAlert(driverModel: driver);
      },
    );
  }

  void _deleteDriver(BuildContext context, String id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DeletionAlert(
          uid: id,
          userType: UserType.driver,
        );
      },
    );
  }

  void _toggleOnChanged(bool toggle) {
    _toggleValue = !_toggleValue;
    FirestoreController firestoreController = FirestoreController();
    firestoreController.updateDriverData(
      DriverModel(
        email: widget.driverModel.email,
        name: widget.driverModel.name,
        ambulanceRegistrationNo: widget.driverModel.ambulanceRegistrationNo,
        uid: widget.driverModel.uid,
        hospitalId: widget.driverModel.hospitalId,
        hospitalName: widget.driverModel.hospitalName,
        driverPassword: widget.driverModel.driverPassword,
        licenseNumber: widget.driverModel.licenseNumber,
        profilePicture: widget.driverModel.profilePicture,
        isAvailable: _toggleValue,
      ),
    );
    setState(() {});
  }
}
