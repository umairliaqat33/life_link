// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:life_link/UI/screens/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:life_link/UI/widgets/buttons/custom_button.dart';
import 'package:life_link/UI/widgets/general_widgets/app_bar_widget.dart';
import 'package:life_link/UI/widgets/general_widgets/circular_loader_widget.dart';
import 'package:life_link/UI/widgets/image_pickers/big_image_picker.dart';
import 'package:life_link/UI/widgets/text_fields/text_form_field_widget.dart';
import 'package:life_link/config/size_config.dart';
import 'package:life_link/controllers/firestore_controller.dart';
import 'package:life_link/models/hospital_model/hospital_model.dart';
import 'package:life_link/models/patient_model/patient_model.dart';
import 'package:life_link/models/user_model/user_model.dart';
import 'package:life_link/services/location_service.dart';
import 'package:life_link/services/media_service.dart';
import 'package:life_link/utils/colors.dart';
import 'package:life_link/utils/enums.dart';
import 'package:life_link/utils/utils.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({
    super.key,
  });

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cnicController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _diseaseController = TextEditingController();
  PlatformFile? _profilePlatformFile;
  final _formKey = GlobalKey<FormState>();
  String? _imageLink;
  bool _btnSpinner = false;
  UserModel? _userModel;
  HospitalModel? _hospitalModel;
  PatientModel? _patientModel;
  final FirestoreController _firestoreController = FirestoreController();
  UserType _userType = UserType.admin;
  Gender _gender = Gender.male;
  bool _isLocationUpdated = false;
  LatLng? _position;

  bool _noImage = false;

  @override
  void initState() {
    super.initState();
    _checkUserType();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(
        title: "Edit Profile",
        context: context,
        backButton: true,
      ),
      body: Padding(
        padding: EdgeInsets.only(
          top: SizeConfig.height12(context),
          left: (SizeConfig.width8(context) * 2),
          right: (SizeConfig.width8(context) * 2),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: _userType == UserType.patient
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
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
                              height: SizeConfig.height12(context),
                            ),
                            TextFormFieldWidget(
                              fieldEnabled: false,
                              hintText: "Email",
                              controller: _emailController,
                              validator: (value) => Utils.emailValidator(value),
                              label: 'Email',
                            ),
                            SizedBox(
                              height: SizeConfig.height12(context),
                            ),
                            TextFormFieldWidget(
                              hintText: "John Doe",
                              controller: _nameController,
                              validator: (value) => Utils.nameValidator(value),
                              label: 'Name',
                            ),
                            SizedBox(
                              height: SizeConfig.height12(context),
                            ),
                            TextFormFieldWidget(
                              hintText: "Enter your diseases",
                              controller: _diseaseController,
                              validator: (value) =>
                                  Utils.diseaseValidator(value),
                              label: 'Disease',
                            ),
                            SizedBox(
                              height: SizeConfig.height12(context),
                            ),
                            TextFormFieldWidget(
                              hintText: "_____-_______-_",
                              controller: _cnicController,
                              validator: (value) => Utils.cnicValidator(value),
                              label: 'CNIC',
                            ),
                            SizedBox(
                              height: SizeConfig.height12(context),
                            ),
                            RadioListTile<Gender>(
                              title: Text(
                                Gender.male.name.toUpperCase(),
                                style: TextStyle(
                                  color: blackColor,
                                  fontWeight: FontWeight.w400,
                                  fontSize: SizeConfig.font16(context),
                                ),
                              ),
                              value: Gender.male,
                              groupValue: _gender,
                              onChanged: (value) => _selectGender(value!),
                            ),
                            SizedBox(
                              height: SizeConfig.height12(context),
                            ),
                            TextFormFieldWidget(
                              hintText: "More than 18 years",
                              controller: _ageController,
                              validator: (value) => Utils.ageValidator(value),
                              label: 'Age',
                            ),
                            SizedBox(
                              height: SizeConfig.height12(context),
                            ),
                            TextFormFieldWidget(
                              hintText: "0312-1234567",
                              controller: _phoneController,
                              validator: (value) =>
                                  Utils.phoneNumberValidator(value),
                              label: 'Phone Number',
                            ),
                            SizedBox(
                              height: SizeConfig.height12(context),
                            ),
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
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
                                    'add a close-up image of your hospital max size is 2 MB',
                                onPressed: () async => _selectProfileImage(),
                                platformFile: _profilePlatformFile,
                                imgUrl: _imageLink,
                              ),
                            ),
                            SizedBox(
                              height: SizeConfig.height12(context),
                            ),
                            TextFormFieldWidget(
                              fieldEnabled: false,
                              hintText: "Email",
                              controller: _emailController,
                              validator: (value) => Utils.emailValidator(value),
                              label: 'Email',
                            ),
                            SizedBox(
                              height: SizeConfig.height12(context),
                            ),
                            TextFormFieldWidget(
                              hintText: "John Doe",
                              controller: _nameController,
                              validator: (value) => Utils.nameValidator(value),
                              label: 'Name',
                            ),
                            SizedBox(
                              height: SizeConfig.height12(context),
                            ),
                            TextFormFieldWidget(
                              hintText: "Enter your address",
                              controller: _addressController,
                              validator: (value) =>
                                  Utils.addressValidator(value),
                              label: 'Disease',
                            ),
                            SizedBox(
                              height: SizeConfig.height12(context),
                            ),
                            TextFormFieldWidget(
                              hintText: "0312-1234567",
                              controller: _phoneController,
                              validator: (value) =>
                                  Utils.phoneNumberValidator(value),
                              label: 'Phone Number',
                            ),
                            SizedBox(
                              height: SizeConfig.height12(context),
                            ),
                            Row(
                              children: [
                                TextButton(
                                  onPressed: () => _updateLocation(),
                                  child: Text(
                                    _isLocationUpdated
                                        ? "Updated ✓"
                                        : "Updated location?",
                                    style: TextStyle(
                                      color: _isLocationUpdated
                                          ? primaryColor
                                          : redColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                ),
              ),
            ),
            _btnSpinner
                ? const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: CircularLoaderWidget(),
                  )
                : Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(
                        bottom: (SizeConfig.width8(context) * 2)),
                    child: CustomButton(
                      buttonColor: primaryColor,
                      title: "SAVE",
                      onPressed: () async => _updateData(),
                    ),
                  ),
          ],
        ),
      ),
    );
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
      log("Exception in _SelectiPRofileImage in EditProfileclass: ${e.toString()}");
    }
  }

  Future<void> _updateData() async {
    setState(() {
      _btnSpinner = true;
    });
    try {
      if (_formKey.currentState!.validate()) {
        if (_profilePlatformFile == null &&
            _imageLink != null &&
            _imageLink!.isEmpty) {
          Fluttertoast.showToast(msg: "Please select an image as well");
          setState(() {
            _noImage = true;
            _btnSpinner = false;
          });
          return;
        } else {
          setState(() {
            _noImage = false;
          });
        }
        _imageLink = _imageLink != null && _imageLink!.isEmpty ||
                _profilePlatformFile != null
            ? (await MediaService.uploadFile(
                userType: UserType.hospital.name,
                platformFile: _profilePlatformFile,
              ))!
            : _imageLink;
        if (_userModel!.name != _nameController.text) {
          _firestoreController.updateUserData(
            UserModel(
              email: _userModel!.email,
              name: _nameController.text,
              userType: _userModel!.userType,
              uid: _userModel!.uid,
              profileImage: _userModel!.profileImage,
            ),
          );
        }
        if (_userType == UserType.patient) {
          _firestoreController.updatePatient(
            PatientModel(
              email: _emailController.text,
              name: _nameController.text,
              uid: _patientModel!.uid,
              fcmToken: _patientModel!.fcmToken,
              profilePicture: _imageLink!,
              age: int.parse(_ageController.text),
              cnic: _cnicController.text,
              disease: _diseaseController.text,
              gender: _gender.name,
              phoneNumber: _phoneController.text,
            ),
          );
        } else {
          _firestoreController.updateHospital(
            HospitalModel(
              email: _emailController.text,
              name: _nameController.text,
              address: _addressController.text,
              uid: _hospitalModel!.uid,
              hospitalLat: _position!.latitude,
              hospitalLon: _position!.longitude,
              fcmToken: _hospitalModel!.fcmToken,
              phoneNumber: _phoneController.text,
              profilePicture: _imageLink!,
              isApproved: _hospitalModel!.isApproved,
            ),
          );
        }
      }
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const BottomNavBar(
            screenIndex: 2,
          ),
        ),
        (route) => false,
      );
    } catch (e) {
      log("Exception in _updateData in editProfileScreen: ${e.toString()}");
    }

    setState(() {
      _btnSpinner = false;
    });
  }

  Future<void> _getAndSetPatientData() async {
    try {
      _patientModel = await _firestoreController.getPatientData();
      if (_patientModel != null) {
        _userType = UserType.patient;
        _nameController.text = _patientModel!.name;
        _emailController.text = _patientModel!.email;
        _diseaseController.text = _patientModel!.disease;
        _cnicController.text = _patientModel!.cnic;
        _ageController.text = _patientModel!.age.toString();
        _gender = _patientModel!.gender == Gender.male.name
            ? Gender.male
            : Gender.female;
        _phoneController.text = _patientModel!.phoneNumber;
        _imageLink = _patientModel!.profilePicture;
      }
    } catch (e) {
      log(e.toString());
    }
    setState(() {});
  }

  Future<void> _getAndSetHospitalData() async {
    try {
      _hospitalModel = await _firestoreController.getHospitalData();
      if (_hospitalModel != null) {
        _userType = UserType.hospital;

        _nameController.text = _hospitalModel!.name;
        _emailController.text = _hospitalModel!.email;
        _addressController.text = _hospitalModel!.address;
        _phoneController.text = _hospitalModel!.phoneNumber;
        _position = LatLng(
          _hospitalModel!.hospitalLat,
          _hospitalModel!.hospitalLon,
        );
      }
    } catch (e) {
      log(e.toString());
    }
    if (!mounted) return;
    setState(() {});
  }

  Future<void> _checkUserType() async {
    try {
      _userModel = await _firestoreController.getUserData();
      if (_userModel != null) {
        if (_userModel!.userType == UserType.patient.name) {
          _getAndSetPatientData();
        } else if (_userModel!.userType == UserType.hospital.name) {
          _getAndSetHospitalData();
        }
      }
      setState(() {});
    } catch (e) {
      log(e.toString());
    }
  }

  void _selectGender(Gender value) {
    setState(() {
      _gender = value;
    });
    log(_gender.name);
  }

  void _updateLocation() async {
    Position? position = await LocationService.getCurrentPosition();
    if (position != null) {
      _position = LatLng(position.latitude, position.longitude);
    }
    _isLocationUpdated = true;
    setState(() {});
  }
}
