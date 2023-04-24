import 'package:cfl/view/screens/auth/splash.dart';
import 'package:cfl/view/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cycle For Lisbon',
      theme: ThemeData(
        primarySwatch: AppColors.accentColor,
        fontFamily: GoogleFonts.dmSans().fontFamily,
      ),
      home: const SplashScreen(),
    );
  }
}
