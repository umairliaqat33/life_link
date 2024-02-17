// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:life_link/UI/screens/home_screen/home_screen.dart';

import 'package:life_link/config/size_config.dart';
import 'package:life_link/UI/screens/authentication/registration/registration_screen.dart';
import 'package:life_link/controllers/auth_controller.dart';
import 'package:life_link/utils/colors.dart';
import 'package:life_link/utils/exceptions.dart';
import 'package:life_link/utils/utils.dart';
import 'package:life_link/UI/widgets/buttons/round_button.dart';
import 'package:life_link/UI/widgets/text_fields/password_text_field.dart';
import 'package:life_link/UI/widgets/text_fields/text_field_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _showSpinner = false;

  @override
  void dispose() {
    _passController.dispose();
    _emailController.dispose();
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: SizeConfig.height18(context) * 3,
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
                  // Align(
                  //   alignment: Alignment.centerRight,
                  //   child: Padding(
                  //     padding: EdgeInsets.only(
                  //       top: SizeConfig.height8(context),
                  //     ),
                  //     child: GestureDetector(
                  //       onTap: () {
                  //         Navigator.of(context).push(
                  //           MaterialPageRoute(
                  //             builder: (context) =>
                  //                 const ForgotPasswordScreen(),
                  //           ),
                  //         );
                  //       },
                  //       child: const Text(
                  //         "Forgot password?",
                  //         style: TextStyle(
                  //           color: primaryColor,
                  //           fontSize: 12,
                  //           fontWeight: FontWeight.w500,
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
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
                          child: RoundedButton(
                            buttonColor: primaryColor,
                            onPressed: () => signin(),
                            title: 'Signin',
                          ),
                        ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text('Don\'t have an account? '),
                      TextButton(
                        style: const ButtonStyle(
                            splashFactory: NoSplash
                                .splashFactory //removing onClick splash color
                            ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RegistrationScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          "SignUp",
                          style: TextStyle(
                            color: primaryColor,
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
      ),
    );
  }

  void signin() async {
    FocusManager.instance.primaryFocus?.unfocus();
    AuthController authController = AuthController();
    UserCredential? userCredential;
    setState(() {
      log("i got set to true");
      _showSpinner = true;
    });
    try {
      if (_formKey.currentState!.validate()) {
        userCredential = await authController.signIn(
          _emailController.text,
          _passController.text,
        );
        if (userCredential != null) {
          log("SignIn successful");
          Fluttertoast.showToast(msg: "SignIn successful");
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ),
            (route) => false,
          );
        }
      }
    } on IncorrectPasswordOrUserNotFound catch (e) {
      Fluttertoast.showToast(msg: e.message);
      log(e.message);
    } on NoInternetException catch (e) {
      Fluttertoast.showToast(msg: e.message);
      log(e.message);
    } on UnknownException catch (e) {
      Fluttertoast.showToast(msg: e.message);
      log(e.message);
    }
    setState(() {
      _showSpinner = false;
    });
  }
}
