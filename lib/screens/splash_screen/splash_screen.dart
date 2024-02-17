import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:life_link/config/size_config.dart';
import 'package:life_link/screens/authentication/login/login_screen.dart';
import 'package:life_link/utils/strings.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // UserModel? userModel;
  @override
  void initState() {
    super.initState();
    _createSplash();
    // if (AuthRepository.userLoginStatus()) {
    //   getUserData();
    // }
  }

  // Future<void> getUserData() async {
  //   FirestoreController firestoreController = FirestoreController();
  //   userModel = await firestoreController.getUserData();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: SizeConfig.width20(context) * 9,
                child: Text(
                  AppStrings.slogan,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: SizeConfig.font22(context),
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _createSplash() {
    Future.delayed(
      const Duration(seconds: 3),
      () {
        log("I am in splash duration");
        User? user = FirebaseAuth.instance.currentUser;
        if (user == null) {
          log('No user logged in');
        }
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ),
          (route) => false,
        );
      },
    );
  }
}
