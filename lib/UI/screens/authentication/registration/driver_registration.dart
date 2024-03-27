// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:life_link/UI/screens/authentication/components/auth_label_widget.dart';
import 'package:life_link/UI/screens/authentication/components/other_auth_option.dart';
import 'package:life_link/UI/screens/authentication/design_layers/layer_two.dart';
import 'package:life_link/UI/screens/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:life_link/config/size_config.dart';
import 'package:life_link/controllers/auth_controller.dart';
import 'package:life_link/controllers/firestore_controller.dart';
import 'package:life_link/models/driver_model/driver_model.dart';
import 'package:life_link/models/user_model/user_model.dart';
import 'package:life_link/utils/assets.dart';
import 'package:life_link/utils/colors.dart';
import 'package:life_link/utils/enums.dart';
import 'package:life_link/utils/exceptions.dart';
import 'package:life_link/utils/utils.dart';
import 'package:life_link/UI/widgets/buttons/custom_button.dart';
import 'package:life_link/UI/widgets/text_fields/password_text_field.dart';
import 'package:life_link/UI/widgets/text_fields/text_field_widget.dart';

class DriverRegistration extends StatefulWidget {
  const DriverRegistration({super.key});

  @override
  State<DriverRegistration> createState() => _DriverRegistrationState();
}

class _DriverRegistrationState extends State<DriverRegistration> {
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _nameController = TextEditingController();
  final _licenceController = TextEditingController();
  final _ageController = TextEditingController();
  final _phoneController = TextEditingController();
  final _employeeidController = TextEditingController();
  final _ambulanceidController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _showSpinner = false;
  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
    _nameController.dispose();
    _licenceController.dispose();
    _ageController.dispose();
    _phoneController.dispose();
    _employeeidController.dispose();
    _ambulanceidController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: AssetImage(Assets.primaryBackgroundImage),
            fit: BoxFit.fill,
          )),
          child: Stack(
            children: [
              Positioned(
                  top: SizeConfig.height20(context) * 8,
                  right: 0,
                  bottom: 0,
                  child: const LayerTwo()),

              Center(
                child: Padding(
                  padding: EdgeInsets.only(
                    top: SizeConfig.height10(context) * 8,
                  ),
                  child:
                      const AuthLabelWidget(authLabel: "Register as a Driver"),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: SizeConfig.height20(context) * 9,
                  left: SizeConfig.width8(context) * 2,
                  right: SizeConfig.width8(context) * 2,
                ),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        SizedBox(
                          height: SizeConfig.height20(context) * 3,
                        ),
                        Column(
                          children: [
                            TextFormFieldWidget(
                              label: 'Name',
                              controller: _nameController,
                              validator: (value) => Utils.nameValidator(value),
                              hintText: "John Doe",
                              inputType: TextInputType.name,
                              inputAction: TextInputAction.next,
                            ),
                            SizedBox(
                              height: SizeConfig.height8(context),
                            ),
                            TextFormFieldWidget(
                              label: 'Age',
                              controller: _ageController,
                              validator: (value) => Utils.nameValidator(value),
                              hintText: "above 18",
                              inputType: TextInputType.number,
                              inputAction: TextInputAction.next,
                            ),
                            SizedBox(
                              height: SizeConfig.height8(context),
                            ),
                            TextFormFieldWidget(
                              label: 'Phone Number',
                              controller: _phoneController,
                              validator: (value) =>
                                  Utils.phoneNumberValidator(value),
                              hintText: "03201234569",
                              inputType: TextInputType.number,
                              inputAction: TextInputAction.next,
                            ),
                            SizedBox(
                              height: SizeConfig.height8(context),
                            ),
                            TextFormFieldWidget(
                              label: 'Licence No',
                              controller: _licenceController,
                              validator: (value) => Utils.nameValidator(value),
                              hintText: "LE-1345",
                              inputType: TextInputType.text,
                              inputAction: TextInputAction.next,
                            ),
                            SizedBox(
                              height: SizeConfig.height8(context),
                            ),
                            TextFormFieldWidget(
                              label: 'Employee Id',
                              controller: _employeeidController,
                              validator: (value) => Utils.nameValidator(value),
                              hintText: "EM-123454",
                              inputType: TextInputType.text,
                              inputAction: TextInputAction.next,
                            ),
                            SizedBox(
                              height: SizeConfig.height8(context),
                            ),
                            TextFormFieldWidget(
                              label: 'Ambulance No',
                              controller: _ambulanceidController,
                              validator: (value) => Utils.nameValidator(value),
                              hintText: "LEA-1345",
                              inputType: TextInputType.text,
                              inputAction: TextInputAction.next,
                            ),
                            SizedBox(
                              height: SizeConfig.height8(context),
                            ),
                            TextFormFieldWidget(
                              label: 'Email',
                              controller: _emailController,
                              validator: (value) => Utils.emailValidator(value),
                              hintText: "Johndoe@gmail.com",
                              inputType: TextInputType.emailAddress,
                              inputAction: TextInputAction.next,
                            ),
                            SizedBox(
                              height: SizeConfig.height8(context),
                            ),
                            PasswordTextField(controller: _passController),
                            SizedBox(
                              height: SizeConfig.height12(context),
                            ),
                            _showSpinner
                                ? Container(
                                    margin: EdgeInsets.only(
                                      left: SizeConfig.width12(context) * 10,
                                      right: SizeConfig.width12(context) * 10,
                                    ),
                                    child: const CircularProgressIndicator(
                                      color: primaryColor,
                                    ),
                                  )
                                : SizedBox(
                                    width: double.infinity,
                                    child: CustomButton(
                                      onPressed: () => signup(),
                                      title: 'Sign up',
                                    ),
                                  ),
                          ],
                        ),
                        SizedBox(
                          height: SizeConfig.height20(context),
                        ),
                        const OtherAuthOption(
                          optionText: 'Already',
                          authOptiontext: 'Sign in',
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              //Positioned(top: SizeConfig.height20(context)*8, right: 0, bottom: 28, child: LayerTwo()),
            ],
          ),
        ),
      ),
    );
  }

  void signup() async {
    FocusManager.instance.primaryFocus?.unfocus();
    AuthController authController = AuthController();
    FirestoreController firestoreController = FirestoreController();
    UserCredential? userCredential;

    setState(() {
      _showSpinner = true;
    });
    try {
      if (_formKey.currentState!.validate()) {
        log("going to register");
        userCredential = await authController.signUp(
          _emailController.text,
          _passController.text,
        );
        if (userCredential != null) {
          firestoreController.uploadUserInformation(
            UserModel(
              email: _emailController.text,
              name: _nameController.text,
              uid: userCredential.user!.uid,
              userType: UserType.driver.name,
            ),
          );
          firestoreController.uploadDriverInformation(
            DriverModel(
              email: _emailController.text,
              name: _nameController.text,
              age: int.parse(
                _ageController.text,
              ),
              uid: userCredential.user!.uid,
              employeeId: _employeeidController.text,
              licenseNumber: _licenceController.text,
            ),
          );
          log("Signup Successful");
          Fluttertoast.showToast(msg: 'Signup Successful');
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const BottomNavBar(),
            ),
            (route) => false,
          );
        }
      }
    } on EmailAlreadyExistException catch (e) {
      Fluttertoast.showToast(msg: e.message);
      log("Signup failed");
      Fluttertoast.showToast(msg: 'Signup Failed');
    } on UnknownException catch (e) {
      Fluttertoast.showToast(msg: e.message);
      log("Signup failed");
      Fluttertoast.showToast(msg: 'Signup Failed');
    }
    setState(() {
      _showSpinner = false;
    });
  }
}
