import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:life_link/UI/screens/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:life_link/config/size_config.dart';
import 'package:life_link/UI/screens/authentication/login/login_screen.dart';
import 'package:life_link/controllers/firestore_controller.dart';
import 'package:life_link/models/user_model/user_model.dart';
import 'package:life_link/repositories/auth_repository.dart';
import 'package:life_link/services/notification_service.dart';
import 'package:life_link/utils/assets.dart';
import 'package:life_link/utils/strings.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const route = '/splash-screen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  UserModel? userModel;
  final _notificationService = NotificationService();

  @override
  void initState() {
    super.initState();
    _createSplash();
    if (AuthRepository.userLoginStatus()) {
      _notificationService.firebaseNotification(context);
      getUserData();
    }
  }

  Future<void> getUserData() async {
    FirestoreController firestoreController = FirestoreController();
    userModel = await firestoreController.getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(Assets.primaryBackgroundImage),
                fit: BoxFit.cover),
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    Assets.logo,
                    width: SizeConfig.width20(context) * 7.5,
                    height: SizeConfig.height20(context) * 7.5,
                  ),
                  SizedBox(
                    height: SizeConfig.height8(context),
                  ),
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
            builder: (context) =>
                user == null ? const LoginScreen() : const BottomNavBar(),
          ),
          (route) => false,
        );
      },
    );
  }
}
