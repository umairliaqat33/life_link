import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:life_link/UI/screens/onboarding_screen/onboarding_view.dart';
import 'package:life_link/UI/screens/splash_screen/splash_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:life_link/firebase_options.dart';
import 'package:life_link/services/dependency_injection.dart';
import 'package:life_link/utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final onboarding = prefs.getBool('onboarding') ?? false;
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
<<<<<<< HEAD
  runApp(const MyApp());
  // DependencyInjection.init();
=======
  runApp(MyApp(
    onboarding: onboarding,
  ));
  DependencyInjection.init();
>>>>>>> 8a9bd0003335ef246e8c1d6b921e2850bb5f6e57
}

class MyApp extends StatelessWidget {
  final bool onboarding;
  const MyApp({super.key, this.onboarding = false});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        primaryColor: primaryColor,
        textTheme: GoogleFonts.interTextTheme(),
        scaffoldBackgroundColor: scaffoldColor,
      ),
      debugShowCheckedModeBanner: false,
      home: onboarding ? const SplashScreen() : const OnboardingView(),
    );
  }
}
