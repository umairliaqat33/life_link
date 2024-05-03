import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:life_link/UI/widgets/buttons/custom_button.dart';
import 'package:life_link/UI/widgets/general_widgets/circular_loader_widget.dart';
import 'package:life_link/UI/widgets/text_fields/password_text_field.dart';
import 'package:life_link/config/size_config.dart';
import 'package:life_link/controllers/auth_controller.dart';
import 'package:life_link/utils/colors.dart';
import 'package:life_link/utils/exceptions.dart';

class HospitalReSignInAlert extends StatefulWidget {
  const HospitalReSignInAlert({
    super.key,
    required this.email,
  });
  final String email;
  @override
  State<HospitalReSignInAlert> createState() => _HospitalReSignInAlertState();
}

class _HospitalReSignInAlertState extends State<HospitalReSignInAlert> {
  final TextEditingController _passwordController = TextEditingController();
  bool _showSpinner = false;
  @override
  void dispose() {
    super.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: EdgeInsets.zero,
      title: const Icon(
        Icons.security,
        color: primaryColor,
        size: 15,
      ),
      content: SingleChildScrollView(
        child: Column(
          children: [
            const Text(
              "sor Security purpose enter your password to verify your identity",
              style: TextStyle(
                color: redColor,
                fontWeight: FontWeight.w400,
                fontSize: 14,
              ),
            ),
            PasswordTextField(
              controller: _passwordController,
            ),
            SizedBox(
              height: SizeConfig.height8(context),
            ),
            _showSpinner
                ? const CircularLoaderWidget()
                : SizedBox(
                    width: double.infinity,
                    child: CustomButton(
                      title: "Done",
                      onPressed: () => _signIn(),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Future<void> _signIn() async {
    setState(() {
      _showSpinner = true;
    });
    try {
      AuthController authController = AuthController();
      UserCredential? userCredential = await authController.signIn(
        'somehospital@hospital.com',
        _passwordController.text,
      );
      if (userCredential != null) {
        setState(() {
          _showSpinner = false;
        });
        Navigator.pop(context);
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
