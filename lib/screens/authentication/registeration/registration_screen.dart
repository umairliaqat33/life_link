// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:life_link/config/size_config.dart';
import 'package:life_link/screens/authentication/login/login_screen.dart';
import 'package:life_link/utils/colors.dart';
import 'package:life_link/utils/utils.dart';
import 'package:life_link/widgets/buttons/round_button.dart';
import 'package:life_link/widgets/text_fields/password_text_field.dart';
import 'package:life_link/widgets/text_fields/text_field_widget.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _businessNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final bool _showSpinner = false;
  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
    _businessNameController.dispose();
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
                    label: 'Business Name',
                    controller: _businessNameController,
                    validator: (value) => Utils.businessNameValidator(value),
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
                          child: RoundedButton(
                            buttonColor: primaryColor,
                            onPressed: () => signup(),
                            title: 'Signup',
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
                              builder: (context) => const LoginScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          "Signin",
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

  void signup() async {
    Fluttertoast.showToast(msg: "I am in Registration Screen");
    // FocusManager.instance.primaryFocus?.unfocus();
    // AuthController authController = AuthController();
    // FirestoreController firestoreController = FirestoreController();
    // UserCredential? userCredential;

    // setState(() {
    //   _showSpinner = true;
    // });
    // try {
    //   if (_formKey.currentState!.validate()) {
    //     log("going to register");
    //     userCredential = await authController.signUp(
    //       _emailController.text,
    //       _passController.text,
    //     );
    //     firestoreController.uploadUserInformation(
    //       UserModel(
    //         email: _emailController.text,
    //         businessName: _businessNameController.text,
    //         uid: userCredential!.user?.uid,
    //       ),
    //     );
    //     log("Signup Successful");
    //     Fluttertoast.showToast(msg: 'Signup Successful');
    //     Navigator.of(context).pushAndRemoveUntil(
    //       MaterialPageRoute(
    //         builder: (context) => const BottomNavigationBarScreen(),
    //       ),
    //       (route) => false,
    //     );
    //   }
    // } on EmailAlreadyExistException catch (e) {
    //   Fluttertoast.showToast(msg: e.message);
    //   log("Signup failed");
    //   Fluttertoast.showToast(msg: 'Signup Failed');
    // } on UnknownException catch (e) {
    //   Fluttertoast.showToast(msg: e.message);
    //   log("Signup failed");
    //   Fluttertoast.showToast(msg: 'Signup Failed');
    // }
    // setState(() {
    //   _showSpinner = false;
    // });
  }
}
