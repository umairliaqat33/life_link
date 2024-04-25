import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:life_link/UI/screens/authentication/login/login_screen.dart';
// import 'package:life_link/UI/screens/authentication/login/login_screen.dart';
// import 'package:life_link/UI/screens/home_screen/home_screen.dart';
import 'package:life_link/UI/screens/onboarding_screen/onboarding_view.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:life_link/firebase_options.dart';
import 'package:life_link/services/dependency_injection.dart';
import 'package:life_link/utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  final prefs = await SharedPreferences.getInstance();
  final onboarding = prefs.getBool('onboarding') ?? false;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp(
    onboarding: onboarding,
  ));
  DependencyInjection.init();
}

class MyApp extends StatelessWidget {
  final bool onboarding;
  const MyApp({super.key, this.onboarding = false});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        primaryColor: primaryColor,
        // textTheme: GoogleFonts.interTextTheme(),
        scaffoldBackgroundColor: scaffoldColor,
      ),
      debugShowCheckedModeBanner: false,
      home: onboarding ? const LoginScreen() : const OnboardingView(),
    );
  }
}
