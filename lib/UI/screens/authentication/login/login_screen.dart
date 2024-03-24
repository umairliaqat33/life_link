// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:life_link/UI/screens/authentication/components/auth_label_widget.dart';
import 'package:life_link/UI/screens/authentication/components/other_auth_option.dart';
import 'package:life_link/UI/screens/authentication/design_layers/layer_one.dart';
import 'package:life_link/UI/screens/authentication/design_layers/layer_two.dart';
import 'package:life_link/UI/screens/authentication/forgot_password_screen.dart/forgot_password_screen.dart';
import 'package:life_link/UI/screens/home_screen/home_screen.dart';

import 'package:life_link/config/size_config.dart';
import 'package:life_link/controllers/auth_controller.dart';
import 'package:life_link/utils/colors.dart';
import 'package:life_link/utils/exceptions.dart';
import 'package:life_link/utils/utils.dart';
import 'package:life_link/UI/widgets/buttons/custom_button.dart';
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
        backgroundColor: scaffoldColor,
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/Registration/primaryBg.png'),
                fit: BoxFit.fill,
              )),
          child: Stack(
            children: [
              Positioned(top: SizeConfig.height20(context)*10.5, right: -50, bottom: 0,left: 0, child: LayerOne()),
              Positioned(top: SizeConfig.height20(context)*12, right: -50, bottom: 0,left: 6, child: LayerTwo()),

              Padding(
                padding: EdgeInsets.only(
                  top: SizeConfig.height10(context) * 12,
                  left: SizeConfig.height10(context)*8,
                ),
                child: const AuthLabelWidget(authLabel: "Sign In"),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: SizeConfig.height10(context) * 20,
                  left: SizeConfig.width8(context) * 5,
                  right: SizeConfig.width8(context) * 2,
                ),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[

                        SizedBox(
                          height: SizeConfig.height20(context) * 7,
                        ),
                        Column(
                          children: [
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
                            Align(
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding: EdgeInsets.only(
                                  top: SizeConfig.height8(context),
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const ForgotPasswordScreen(),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    "Forgot password?",
                                    style: TextStyle(
                                      color: greyColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ),
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
                                      onPressed: () => signin(),
                                      title: 'Signin',
                                    ),
                                  ),
                          ],
                        ),
                        SizedBox(
                          height: SizeConfig.height20(context) ,
                        ),
                        const OtherAuthOption(
                          optionText: 'Don\'t',
                          authOptiontext: 'Sign up',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
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
