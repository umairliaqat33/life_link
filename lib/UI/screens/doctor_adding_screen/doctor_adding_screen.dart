import 'dart:developer';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:life_link/UI/widgets/buttons/custom_button.dart';
import 'package:life_link/UI/widgets/general_widgets/app_bar_widget.dart';
import 'package:life_link/UI/widgets/image_pickers/big_image_picker.dart';
import 'package:life_link/UI/widgets/text_fields/text_form_field_widget.dart';
import 'package:life_link/config/size_config.dart';
import 'package:life_link/controllers/firestore_controller.dart';
import 'package:life_link/models/doctor_model/doctor_model.dart';
import 'package:life_link/services/date_and_time_service.dart';
import 'package:life_link/services/media_service.dart';
import 'package:life_link/utils/enums.dart';
import 'package:life_link/utils/exceptions.dart';
import 'package:life_link/utils/utils.dart';

class DoctorAddingScreen extends StatefulWidget {
  const DoctorAddingScreen({super.key});

  @override
  State<DoctorAddingScreen> createState() => _DoctorAddingScreenState();
}

class _DoctorAddingScreenState extends State<DoctorAddingScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _arrivingTimeController = TextEditingController();
  final TextEditingController _leavingTimeController = TextEditingController();
  final TextEditingController _educationController = TextEditingController();
  final TextEditingController _specialityController = TextEditingController();
  final TextEditingController _otherExperienceController =
      TextEditingController();

  final _formKey = GlobalKey<FormState>();
  PlatformFile? _profilePlatformFile;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: appBarWidget(
          title: "Add Doctors",
          context: context,
          backButton: true,
        ),
        body: Padding(
          padding: EdgeInsets.all(SizeConfig.height15(context) + 1),
          child: CustomScrollView(
            scrollDirection: Axis.vertical,
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Column(
                        children: [
                          ImagePickerBigWidget(
                            heading: 'Profile Photo',
                            description:
                                'add a close-up image of yourself max size is 2 MB',
                            onPressed: () async => _selectProfileImage(),
                            platformFile: _profilePlatformFile,
                            imgUrl: null,
                          ),
                          SizedBox(
                            height: SizeConfig.height8(context),
                          ),
                          TextFormFieldWidget(
                            controller: _nameController,
                            validator: (value) => Utils.nameValidator(value),
                            label: "Name",
                            inputAction: TextInputAction.next,
                            hintText: "Doctor's name i.e. Muhammad Irfan",
                          ),
                          SizedBox(
                            height: SizeConfig.height8(context),
                          ),
                          TextFormFieldWidget(
                            controller: _emailController,
                            validator: (value) => Utils.emailValidator(value),
                            label: "Email",
                            inputAction: TextInputAction.next,
                            hintText: "Doctor's email",
                          ),
                          SizedBox(
                            height: SizeConfig.height8(context),
                          ),
                          TextFormFieldWidget(
                            controller: _educationController,
                            validator: (value) =>
                                Utils.educationValidator(value),
                            label: "Education",
                            inputAction: TextInputAction.next,
                            hintText: "Doctor's Education",
                          ),
                          SizedBox(
                            height: SizeConfig.height8(context),
                          ),
                          TextFormFieldWidget(
                            controller: _arrivingTimeController,
                            validator: (value) => Utils.simpleValidator(value),
                            label: "Arriving Time",
                            inputAction: TextInputAction.next,
                            hintText: "Doctor's arriving time",
                            suffixIcon: Icons.access_time_rounded,
                            suffixIconFunction: () =>
                                _selectTime(_arrivingTimeController),
                          ),
                          SizedBox(
                            height: SizeConfig.height8(context),
                          ),
                          TextFormFieldWidget(
                            controller: _leavingTimeController,
                            validator: (value) => Utils.simpleValidator(value),
                            label: "Leaving time",
                            inputAction: TextInputAction.next,
                            hintText: "Doctor's leaving time",
                            suffixIcon: Icons.access_time_rounded,
                            suffixIconFunction: () =>
                                _selectTime(_leavingTimeController),
                          ),
                          SizedBox(
                            height: SizeConfig.height8(context),
                          ),
                          TextFormFieldWidget(
                            controller: _specialityController,
                            validator: (value) =>
                                Utils.specialityValidator(value),
                            label: "Speciality",
                            inputAction: TextInputAction.next,
                            hintText: "Doctor's speciality",
                          ),
                          SizedBox(
                            height: SizeConfig.height8(context),
                          ),
                          TextFormFieldWidget(
                            controller: _otherExperienceController,
                            validator: (value) => Utils.simpleValidator(value),
                            label: "Other Experience",
                            inputAction: TextInputAction.next,
                            hintText: "Any other disease doctor works on?",
                          ),
                        ],
                      ),
                      SizedBox(
                        height: SizeConfig.height8(context),
                      ),
                      CustomButton(
                        title: "SAVE",
                        onPressed: () => _uploadDoctorData(),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectTime(TextEditingController controller) async {
    TimeOfDay? timeOfDay = await DateAndTimeService.timePicker(context);
    if (timeOfDay == null) {
      Fluttertoast.showToast(msg: "Please select some time");
    } else {
      log(timeOfDay.toString());
      DateTime now = DateTime.now();
      String time = DateFormat('hh:mm a').format(
        DateTime(
            now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute),
      );
      log(time);
      setState(() {
        controller.text = time;
      });
    }
  }

  Future<void> _uploadDoctorData() async {
    try {
      FirestoreController firestoreController = FirestoreController();
      if (_formKey.currentState!.validate()) {
        String? imageLink = await MediaService.uploadFile(
          userType: UserType.hospital.name,
          platformFile: _profilePlatformFile,
        );
        firestoreController.uploadDoctor(
          DoctorModel(
            email: _emailController.text,
            name: _nameController.text,
            comingTime: _arrivingTimeController.text,
            leavingTime: _leavingTimeController.text,
            education: _educationController.text,
            speciality: _specialityController.text,
            otherExperiences: _otherExperienceController.text,
            profileImage: imageLink!,
          ),
        );
        Fluttertoast.showToast(msg: "Doctor's data uploaded successfully");
        Navigator.of(context).pop();
      }
    } on NoInternetException catch (e) {
      Fluttertoast.showToast(
        msg: e.message,
      );
    } on FormatParsingException catch (e) {
      Fluttertoast.showToast(
        msg: e.message,
      );
    } on UnknownException catch (e) {
      Fluttertoast.showToast(
        msg: e.message,
      );
    }
  }

  Future<void> _selectProfileImage() async {
    try {
      _profilePlatformFile = await MediaService.selectFile();
      if (_profilePlatformFile != null) {
        log("Big Image Clicked");
        log(_profilePlatformFile!.name);
      } else {
        log("no file selected");
        return;
      }
      setState(() {});
    } catch (e) {
      Fluttertoast.showToast(
        msg: e.toString(),
      );
    }
  }
}
