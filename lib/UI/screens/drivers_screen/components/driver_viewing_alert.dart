import 'package:flutter/material.dart';
import 'package:life_link/UI/screens/drivers_screen/driver_adding_screen.dart';
import 'package:life_link/UI/widgets/cards/info_card_widget.dart';
import 'package:life_link/config/size_config.dart';
import 'package:life_link/models/driver_model/driver_model.dart';
import 'package:life_link/utils/assets.dart';
import 'package:life_link/utils/colors.dart';

class DriverViewingAlert extends StatelessWidget {
  const DriverViewingAlert({
    super.key,
    required this.driverModel,
  });
  final DriverModel driverModel;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: scaffoldColor,
      title: Row(
        children: [
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  driverModel.name,
                  style: TextStyle(
                    fontSize: SizeConfig.font14(context),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  driverModel.email,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: SizeConfig.font12(context) + 1,
                    color: greyColor,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () => _editDriverButton(context),
            icon: const Icon(
              Icons.edit,
              color: primaryColor,
            ),
          ),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            driverModel.profilePicture.isEmpty
                ? Image.asset(
                    Assets.blankProfilePicture,
                    height: SizeConfig.height10(context) * 10,
                    width: SizeConfig.width10(context) * 8,
                  )
                : Image.network(
                    driverModel.profilePicture,
                    height: SizeConfig.height10(context) * 10,
                    width: SizeConfig.width10(context) * 8,
                  ),
            InfoCardWidget(
              item1: driverModel.licenseNumber,
              item2: driverModel.ambulanceRegistrationNo,
              item3: driverModel.isApproved.toString(),
              item4: driverModel.isAvailable.toString(),
              item5: driverModel.driverPassword,
              item1Title: 'License number',
              item2Title: 'Ambulance number',
              item3Title: 'Approval status',
              item4Title: 'Availability',
              item5Title: 'Password',
            ),
          ],
        ),
      ),
    );
  }

  void _editDriverButton(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => DriverAddingScreen(
          driverModel: driverModel,
        ),
      ),
    );
  }
}
