import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:life_link/UI/screens/doctor_screen/components/doctor_card_widget.dart';
import 'package:life_link/UI/widgets/general_widgets/app_bar_widget.dart';
import 'package:life_link/config/size_config.dart';
import 'package:life_link/models/doctor_model/doctor_model.dart';
import 'package:life_link/utils/assets.dart';
import 'package:life_link/utils/colors.dart';

class DoctorScreen extends StatelessWidget {
  const DoctorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: appBarWidget(
          title: "Manage Doctors",
          context: context,
          backButton: true,
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: primaryColor,
          onPressed: () {},
          child: const Icon(
            Icons.add,
            color: whiteColor,
          ),
        ),
        body: Padding(
          padding: EdgeInsets.only(
            left: SizeConfig.width10(context),
            right: SizeConfig.width10(context),
          ),
          child: ListView.builder(
            itemCount: 1,
            itemBuilder: (BuildContext context, int index) {
              return const DoctorCardWidget(
                doctorModel: DoctorModel(
                  email: "someDoctor@doctor.com",
                  name: "Some Doctor",
                  comingTime: "11:00 AM",
                  leavingTime: "2:00 PM",
                  education: "MBBS",
                  speciality: "Ear Specialist",
                  profileImage:
                      "https://static.vecteezy.com/system/resources/thumbnails/024/585/326/small/3d-happy-cartoon-doctor-cartoon-doctor-on-transparent-background-generative-ai-png.png",
                  otherExperiences: "Mouth,Throat,Eyes,Nose",
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
