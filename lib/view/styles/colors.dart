import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryColor = Color(0xff1D2127);
  static const Color secondaryColor = Color(0xffFDDB30);
  static const Color tertiaryColor = Color(0xffECF0E7);
  static const Color silvery = Color(0xffDFE7D2);
  static const MaterialColor accentColor = MaterialColor(0xffF6B40A, color);
  static const Color shadowColor = Color(0xff093269);
  static const Color blueGrey = Color(0xff323F4B);
  static const Color greyish = Color(0xff7B8794);
  static const Color white = Color(0xffFFFFFF);
  static const Color black = Color(0xff000000);
  static const Color tomatoRed = Color(0xffE12020);
  static const Color cabbageGreen = Color(0xff00CC66);
  static const Color background = Color(0xffF5F5F5);

  static const whiteBgGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color.fromARGB(255, 255, 255, 255),
      Color.fromARGB(255, 223, 231, 210),
    ],
    stops: [0.0, 2],
  );
}

const Map<int, Color> color = {
  50: Color.fromRGBO(136, 14, 79, .1),
  100: Color.fromRGBO(136, 14, 79, .2),
  200: Color.fromRGBO(136, 14, 79, .3),
  300: Color.fromRGBO(136, 14, 79, .4),
  400: Color.fromRGBO(136, 14, 79, .5),
  500: Color.fromRGBO(136, 14, 79, .6),
  600: Color.fromRGBO(136, 14, 79, .7),
  700: Color.fromRGBO(136, 14, 79, .8),
  800: Color.fromRGBO(136, 14, 79, .9),
  900: Color.fromRGBO(136, 14, 79, 1),
};

//0xffFDDB30 convert to RGBO