// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:life_link/UI/screens/drivers_screen/components/hospital_re_sign_in_alert.dart';
import 'package:life_link/UI/widgets/buttons/custom_button.dart';
import 'package:life_link/UI/widgets/general_widgets/app_bar_widget.dart';
import 'package:life_link/UI/widgets/general_widgets/circular_loader_widget.dart';
import 'package:life_link/UI/widgets/image_pickers/big_image_picker.dart';
import 'package:life_link/UI/widgets/text_fields/password_text_field.dart';
import 'package:life_link/UI/widgets/text_fields/text_form_field_widget.dart';
import 'package:life_link/config/size_config.dart';
import 'package:life_link/controllers/auth_controller.dart';
import 'package:life_link/controllers/firestore_controller.dart';
import 'package:life_link/models/driver_model/driver_model.dart';
import 'package:life_link/models/hospital_model/hospital_model.dart';
import 'package:life_link/services/id_service.dart';
import 'package:life_link/services/media_service.dart';
import 'package:life_link/utils/colors.dart';
import 'package:life_link/utils/enums.dart';
import 'package:life_link/utils/exceptions.dart';
import 'package:life_link/utils/utils.dart';

class DriverAddingScreen extends StatefulWidget {
  const DriverAddingScreen({
    super.key,
    this.driverModel,
  });
  final DriverModel? driverModel;

  @override
  State<DriverAddingScreen> createState() => _DriverAddingScreenState();
}

class _DriverAddingScreenState extends State<DriverAddingScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _ambulanceRegistrationNumberController =
      TextEditingController();
  final TextEditingController _licenseNumberController =
      TextEditingController();

  final _formKey = GlobalKey<FormState>();
  PlatformFile? _profilePlatformFile;
  bool _spinner = false;
  bool _noImage = false;
  String _imageLink = '';

  @override
  void initState() {
    super.initState();
    if (widget.driverModel != null) {
      _setValues();
    }
  }

  // @override
  // void dispose() {
  //   _licenseNumberController.dispose();
  //   _ambulanceRegistrationNumberController.dispose();
  //   _passwordController.dispose();
  //   _emailController.dispose();
  //   _nameController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: appBarWidget(
          title: "Add Driver",
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
                          Container(
                            decoration: BoxDecoration(
                                border: _noImage
                                    ? Border.all(
                                        color: redColor,
                                        width: 1,
                                      )
                                    : null,
                                borderRadius: _noImage
                                    ? const BorderRadius.all(
                                        Radius.circular(10),
                                      )
                                    : null),
                            child: ImagePickerBigWidget(
                              heading: 'Profile Photo',
                              description:
                                  'add a close-up image of yourself max size is 2 MB',
                              onPressed: () async => _selectProfileImage(),
                              platformFile: _profilePlatformFile,
                              imgUrl: _imageLink,
                            ),
                          ),
                          SizedBox(
                            height: SizeConfig.height8(context),
                          ),
                          TextFormFieldWidget(
                            controller: _nameController,
                            validator: (value) => Utils.nameValidator(value),
                            label: "Name",
                            inputAction: TextInputAction.next,
                            hintText: "Driver's name",
                          ),
                          SizedBox(
                            height: SizeConfig.height8(context),
                          ),
                          TextFormFieldWidget(
                            controller: _emailController,
                            validator: (value) => Utils.emailValidator(value),
                            label: "Email",
                            inputAction: TextInputAction.next,
                            hintText: "Driver's email",
                          ),
                          SizedBox(
                            height: SizeConfig.height8(context),
                          ),
                          PasswordTextField(controller: _passwordController),
                          SizedBox(
                            height: SizeConfig.height8(context),
                          ),
                          TextFormFieldWidget(
                            controller: _ambulanceRegistrationNumberController,
                            validator: (value) =>
                                Utils.ambulanceRegistrationNumberValidator(
                                    value),
                            label: "Ambulance Registration Number",
                            inputAction: TextInputAction.next,
                            hintText: "LEY-2021",
                          ),
                          SizedBox(
                            height: SizeConfig.height8(context),
                          ),
                          TextFormFieldWidget(
                            controller: _licenseNumberController,
                            validator: (value) =>
                                Utils.licenseNumberValidator(value),
                            label: "License number",
                            inputAction: TextInputAction.next,
                            hintText: "Driver's license number",
                          ),
                        ],
                      ),
                      SizedBox(
                        height: SizeConfig.height8(context),
                      ),
                      _spinner
                          ? const CircularLoaderWidget()
                          : CustomButton(
                              title: "SAVE",
                              onPressed: () => _saveDriverDataButton(),
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

  Future<void> _saveDriverDataButton() async {
    try {
      setState(() {
        _spinner = true;
      });
      FirestoreController firestoreController = FirestoreController();
      HospitalModel hospitalModel = await firestoreController.getHospitalData();
      if (_formKey.currentState!.validate()) {
        if (_profilePlatformFile == null && _imageLink.isEmpty) {
          Fluttertoast.showToast(msg: "Please select an image as well");
          setState(() {
            _noImage = true;
            _spinner = false;
          });
          return;
        } else {
          setState(() {
            _noImage = false;
          });
        }
        _imageLink = _imageLink.isEmpty
            ? (await MediaService.uploadFile(
                userType: UserType.driver.name,
                platformFile: _profilePlatformFile,
              ))!
            : _imageLink;

        String id = await IdService.createID();
        log(id);
        widget.driverModel != null
            ? firestoreController.updateDriverData(
                DriverModel(
                  email: _emailController.text,
                  name: _nameController.text,
                  ambulanceRegistrationNo:
                      _ambulanceRegistrationNumberController.text,
                  uid: widget.driverModel!.uid,
                  hospitalId: widget.driverModel!.hospitalId,
                  hospitalName: widget.driverModel!.hospitalName,
                  licenseNumber: _licenseNumberController.text,
                  profilePicture: _imageLink,
                  isAvailable: true,
                  fcmToken: widget.driverModel!.fcmToken,
                ),
              )
            : createDriverAccount(
                hospitalModel.uid,
                hospitalModel.name,
                hospitalModel.email,
                _imageLink,
              );
        if (widget.driverModel == null) {
          // Navigator.of(context).pop();
        }
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
    setState(() {
      _spinner = false;
    });
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

  void _setValues() {
    _emailController.text = widget.driverModel!.email;
    _nameController.text = widget.driverModel!.name;
    _licenseNumberController.text = widget.driverModel!.licenseNumber;
    _ambulanceRegistrationNumberController.text =
        widget.driverModel!.ambulanceRegistrationNo;
    _imageLink = widget.driverModel!.profilePicture;
    setState(() {});
  }

  void createDriverAccount(
    String hospitalId,
    String hospitalName,
    String hospitalEmail,
    String profileImage,
  ) async {
    FocusManager.instance.primaryFocus?.unfocus();
    AuthController authController = AuthController();
    UserCredential? userCredential;

    try {
      if (_formKey.currentState!.validate()) {
        log("going to register");
        FirebaseAuth.instance.signOut();
        userCredential = await authController.signUp(
          _emailController.text,
          _passwordController.text,
        );

        if (userCredential != null) {
          FirebaseAuth.instance.signOut();

          Future.delayed(
              const Duration(
                seconds: 1,
              ), () {
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) {
                return HospitalReSignInAlert(
                  hospitalEmail: hospitalEmail,
                  drvierUid: userCredential!.user!.uid,
                  hospitalId: hospitalId,
                  hospitalName: hospitalName,
                  profileImage: profileImage,
                  driverEmail: _emailController.text,
                  driverName: _nameController.text,
                  licenseNumber: _licenseNumberController.text,
                  ambulanceRegistration:
                      _ambulanceRegistrationNumberController.text,
                  driverPassword: _passwordController.text,
                );
              },
            );
            log("Driver Account Creation Successful");
            Fluttertoast.showToast(msg: 'Driver Account Creation Successful');
          });
        }
      }
    } on EmailAlreadyExistException catch (e) {
      Fluttertoast.showToast(msg: e.message);
      log("Driver Account Creation failed");
      Fluttertoast.showToast(msg: 'Driver Account Creation Failed');
    } on UnknownException catch (e) {
      Fluttertoast.showToast(msg: e.message);
      log("Driver Account Creation failed");
      Fluttertoast.showToast(msg: 'Driver Account Creation Failed');
    }
  }
}
