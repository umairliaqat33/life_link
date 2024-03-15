import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:life_link/UI/screens/splash_screen/splash_screen.dart';
import 'package:life_link/firebase_options.dart';
import 'package:life_link/utils/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: primaryColor,
        textTheme: GoogleFonts.interTextTheme(),
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }

  // MaterialColor createMaterialColor(Color color) {
  //   Map<int, Color> swatch = <int, Color>{};

  //   swatch[50] = primaryColor; // Change opacity if necessary
  //   swatch[100] = primaryColor;
  //   swatch[200] = primaryColor;
  //   swatch[300] = primaryColor;
  //   swatch[400] = primaryColor;
  //   swatch[500] = primaryColor;
  //   swatch[600] = primaryColor;
  //   swatch[700] = primaryColor;
  //   swatch[800] = primaryColor;
  //   swatch[900] = primaryColor;

  //   return MaterialColor(color.value, swatch);
  // }
}
