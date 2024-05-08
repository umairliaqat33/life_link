import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:life_link/UI/screens/onboarding_screen/onboarding_view.dart';
import 'package:life_link/UI/screens/splash_screen/splash_screen.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:life_link/firebase_options.dart';
import 'package:life_link/services/notification_service.dart';
import 'package:life_link/utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final onboarding = prefs.getBool('onboarding') ?? false;
  final NotificationService notificationService = NotificationService();
  await notificationService.initLocalNotification();
  await FirebaseMessaging.instance.getInitialMessage();
  runApp(MyApp(
    onboarding: onboarding,
  ));
  //DependencyInjection.init();
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
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      home: onboarding ? const SplashScreen() : const OnboardingView(),
      routes: {
        SplashScreen.route: (context) => const SplashScreen(),
      },
    );
  }
}
