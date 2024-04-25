// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:life_link/UI/screens/authentication/login/login_screen.dart';
import 'package:life_link/UI/widgets/buttons/custom_button.dart';
import 'package:life_link/UI/widgets/general_widgets/app_bar_widget.dart';
import 'package:life_link/UI/widgets/general_widgets/circular_loader_widget.dart';
import 'package:life_link/UI/widgets/text_fields/text_form_field_widget.dart';
import 'package:life_link/config/size_config.dart';
import 'package:life_link/controllers/auth_controller.dart';
import 'package:life_link/utils/colors.dart';
import 'package:life_link/utils/exceptions.dart';
import 'package:life_link/utils/utils.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: appBarWidget(
          title: "",
          context: context,
          backButton: true,
        ),
        body: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: EdgeInsets.only(
                  top: SizeConfig.height8(context),
                  left: (SizeConfig.width8(context) * 2),
                  right: (SizeConfig.width8(context) * 2),
                ),
                child: Column(
                  children: <Widget>[
                    TextFormFieldWidget(
                      hintText: "johndoe@gmail.com",
                      controller: _emailController,
                      validator: (value) => Utils.emailValidator(value),
                      label: "Email",
                    ),
                    Text(
                      "Sending link to email above. Click on the button below to reset your password",
                      style: TextStyle(
                        fontSize: SizeConfig.font12(context),
                        fontWeight: FontWeight.w400,
                        color: greyColor,
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: (SizeConfig.height15(context) * 2),
                      ),
                      child: _isLoading
                          ? const CircularLoaderWidget()
                          : SizedBox(
                              width: double.infinity,
                              child: CustomButton(
                                buttonColor: primaryColor,
                                title: "RESET PASSWORD",
                                onPressed: () => _forgotPassword(),
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _forgotPassword() async {
    setState(() {
      _isLoading = true;
    });
    try {
      if (_formKey.currentState!.validate()) {
        AuthController authController = AuthController();
        bool result =
            await authController.checkIfUserExists(_emailController.text);
        if (result) {
          authController.resetPassword(_emailController.text);
          Fluttertoast.showToast(
            msg: "Please check your email inbox.",
          );
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const LoginScreen(),
            ),
            (route) => false,
          );
        } else {
          Fluttertoast.showToast(
            msg: "No account found for this email",
          );
        }
      }
    } on UserNotFoundException catch (e) {
      Fluttertoast.showToast(
        msg: e.message,
      );
    } on NoInternetException catch (e) {
      Fluttertoast.showToast(
        msg: e.message,
      );
    } on UnknownException catch (e) {
      Fluttertoast.showToast(
        msg: e.message,
      );
    }
    setState(() {
      _isLoading = false;
    });
  }
}
