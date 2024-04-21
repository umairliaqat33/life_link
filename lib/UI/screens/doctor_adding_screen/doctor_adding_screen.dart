import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:life_link/UI/widgets/buttons/custom_button.dart';
import 'package:life_link/UI/widgets/general_widgets/app_bar_widget.dart';
import 'package:life_link/UI/widgets/text_fields/text_form_field_widget.dart';
import 'package:life_link/config/size_config.dart';
import 'package:life_link/controllers/firestore_controller.dart';
import 'package:life_link/models/doctor_model/doctor_model.dart';
import 'package:life_link/services/services.dart';
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
    TimeOfDay? timeOfDay = await Services.timePicker(context);
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

  void _uploadDoctorData() {
    try {
      FirestoreController firestoreController = FirestoreController();
      if (_formKey.currentState!.validate()) {
        firestoreController.uploadDoctor(
          DoctorModel(
            email: _emailController.text,
            name: _nameController.text,
            comingTime: _arrivingTimeController.text,
            leavingTime: _leavingTimeController.text,
            education: _educationController.text,
            speciality: _specialityController.text,
            otherExperiences: _otherExperienceController.text,
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
}
