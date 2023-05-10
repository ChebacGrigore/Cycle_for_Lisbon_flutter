import 'package:cfl/view/screens/auth/onboarding.dart';
import 'package:cfl/view/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:i18n_extension/i18n_widget.dart';

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
      // localizationsDelegates: [
      //   // GlobalMaterialLocalizations.delegate,
      //   // GlobalWidgetsLocalizations.delegate,
      //   // GlobalCupertinoLocalizations.delegate,
      // ],
      supportedLocales: const [
        Locale('en', "US"),
        Locale('pt', "BR"),
      ],
      theme: ThemeData(
        primarySwatch: AppColors.accentColor,
        fontFamily: GoogleFonts.dmSans().fontFamily,
      ),
      home: I18n(
        initialLocale: const Locale("pt", "BR"),
        child: const Onboarding(),
      ),
    );
  }
}
