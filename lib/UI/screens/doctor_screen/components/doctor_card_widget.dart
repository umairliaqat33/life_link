import 'package:flutter/material.dart';
import 'package:life_link/config/size_config.dart';
import 'package:life_link/models/doctor_model/doctor_model.dart';
import 'package:life_link/utils/assets.dart';
import 'package:life_link/utils/colors.dart';
import 'package:life_link/utils/enums.dart';

class DoctorCardWidget extends StatelessWidget {
  const DoctorCardWidget({
    super.key,
    required this.doctorModel,
    required this.isAvailable,
  });
  final DoctorModel doctorModel;
  final bool isAvailable;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(SizeConfig.width5(context)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              doctorModel.name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: SizeConfig.font18(context),
                color: appTextColor,
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                doctorModel.profileImage.isEmpty
                    ? Image.asset(
                        Assets.blankProfilePicture,
                        height: SizeConfig.height10(context) * 10,
                        width: SizeConfig.width10(context) * 8,
                      )
                    : Image.network(
                        doctorModel.profileImage,
                        height: SizeConfig.height10(context) * 10,
                        width: SizeConfig.width10(context) * 8,
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
                          color: isAvailable
                              ? doctorAvailableBubbleBorderColor
                              : doctorNotAvailableBubbleBorderColor,
                        ),
                        color: isAvailable
                            ? doctorAvailableBubbleColor
                            : doctorNotAvailableBubbleColor,
                      ),
                      padding: EdgeInsets.all(
                        SizeConfig.height5(context),
                      ),
                      child: Text(
                        isAvailable
                            ? Availability.available.name
                            : Availability.unavailable.name,
                        style: TextStyle(
                          fontSize: SizeConfig.font12(context),
                          color: whiteColor,
                        ),
                      ),
                    ),
                    Text(
                      doctorModel.speciality,
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
                          onPressed: () {},
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
                          onPressed: () {},
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
}
