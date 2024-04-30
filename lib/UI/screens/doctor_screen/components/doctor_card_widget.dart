import 'package:flutter/material.dart';
import 'package:life_link/UI/screens/doctor_screen/components/doctor_viewing_alert.dart';
import 'package:life_link/UI/widgets/alerts/doctor_deletion_alert.dart';
import 'package:life_link/UI/widgets/switchs/custom_switch.dart';
import 'package:life_link/config/size_config.dart';
import 'package:life_link/models/doctor_model/doctor_model.dart';
import 'package:life_link/utils/assets.dart';
import 'package:life_link/utils/colors.dart';
import 'package:life_link/utils/enums.dart';

class DoctorCardWidget extends StatefulWidget {
  const DoctorCardWidget({
    super.key,
    required this.doctorModel,
    required this.isAvailable,
  });
  final DoctorModel doctorModel;
  final bool isAvailable;

  @override
  State<DoctorCardWidget> createState() => _DoctorCardWidgetState();
}

class _DoctorCardWidgetState extends State<DoctorCardWidget> {
  late bool _toggleValue;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _toggleValue = widget.isAvailable;
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
                  widget.doctorModel.name,
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
                  child: widget.doctorModel.profileImage.isEmpty
                      ? Image.asset(
                          Assets.blankProfilePicture,
                          height: SizeConfig.height10(context) * 10,
                          width: SizeConfig.width10(context) * 8,
                        )
                      : ClipOval(
                          child: Image.network(
                            widget.doctorModel.profileImage,
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
                              ? doctorAvailableBubbleBorderColor
                              : doctorNotAvailableBubbleBorderColor,
                        ),
                        color: _toggleValue
                            ? doctorAvailableBubbleColor
                            : doctorNotAvailableBubbleColor,
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
                    Text(
                      widget.doctorModel.speciality,
                      style: TextStyle(
                        fontSize: SizeConfig.font12(context),
                        color: appTextColor,
                      ),
                    ),
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
                          onPressed: () => _viewDoctorButton(
                            context,
                            widget.doctorModel,
                          ),
                          child: Text(
                            "View Doctor",
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
                          onPressed: () => _deleteDoctor(
                            context,
                            widget.doctorModel.doctorId,
                          ),
                          child: Text(
                            "Delete Doctor",
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

  void _viewDoctorButton(
    BuildContext context,
    DoctorModel doc,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DoctorViewingAlert(doctorModel: doc);
      },
    );
  }

  void _deleteDoctor(BuildContext context, String id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DoctorDeletionAlert(
          uid: id,
        );
      },
    );
  }

  void _toggleOnChanged(bool toggle) {
    _toggleValue = !_toggleValue;
    setState(() {});
  }
}
