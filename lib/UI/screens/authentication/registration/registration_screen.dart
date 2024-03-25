// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:life_link/UI/screens/authentication/components/auth_label_widget.dart';
import 'package:life_link/UI/screens/authentication/components/other_auth_option.dart';
import 'package:life_link/UI/screens/home_screen/home_screen.dart';

import 'package:life_link/config/size_config.dart';
import 'package:life_link/controllers/auth_controller.dart';
import 'package:life_link/controllers/firestore_controller.dart';
import 'package:life_link/models/user_model/user_model.dart';
import 'package:life_link/utils/colors.dart';
import 'package:life_link/utils/exceptions.dart';
import 'package:life_link/utils/utils.dart';
import 'package:life_link/UI/widgets/buttons/custom_button.dart';
import 'package:life_link/UI/widgets/text_fields/password_text_field.dart';
import 'package:life_link/UI/widgets/text_fields/text_field_widget.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _showSpinner = false;
  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.only(
            top: SizeConfig.height10(context) * 10,
            left: SizeConfig.width8(context) * 2,
            right: SizeConfig.width8(context) * 2,
          ),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  const AuthLabelWidget(authLabel: "Sign up"),
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
                                title: 'Signup',
                              ),
                            ),
                    ],
                  ),
                  SizedBox(
                    height: SizeConfig.height20(context) * 9.3,
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
        firestoreController.uploadUserInformation(
          UserModel(
            email: _emailController.text,
            name: _nameController.text,
            uid: userCredential!.user!.uid,
          ),
        );
        log("Signup Successful");
        Fluttertoast.showToast(msg: 'Signup Successful');
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
          (route) => false,
        );
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
