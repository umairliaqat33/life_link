import 'package:flutter/material.dart';
import 'package:life_link/UI/widgets/cards/info_card_widget.dart';
import 'package:life_link/UI/screens/doctor_screen/doctor_adding_screen.dart';
import 'package:life_link/config/size_config.dart';
import 'package:life_link/models/doctor_model/doctor_model.dart';
import 'package:life_link/utils/assets.dart';
import 'package:life_link/utils/colors.dart';

class DoctorViewingAlert extends StatelessWidget {
  const DoctorViewingAlert({
    super.key,
    required this.doctorModel,
  });
  final DoctorModel doctorModel;
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
                  doctorModel.name,
                  style: TextStyle(
                    fontSize: SizeConfig.font14(context),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  doctorModel.email,
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
            onPressed: () => _editDoctorButton(context),
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
            InfoCardWidget(
              item1: doctorModel.education,
              item2: doctorModel.comingTime,
              item3: doctorModel.leavingTime,
              item4: doctorModel.speciality,
              item5: doctorModel.otherExperiences,
              item1Title: 'Education',
              item2Title: 'Arriving time',
              item3Title: 'Leaving time',
              item4Title: 'Speciality',
              item5Title: 'Other Experience',
            ),
          ],
        ),
      ),
    );
  }

  void _editDoctorButton(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => DoctorAddingScreen(
          doctorModel: doctorModel,
        ),
      ),
    );
  }
}
