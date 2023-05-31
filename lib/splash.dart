import 'dart:async';

import 'package:cfl/shared/buildcontext_ext.dart';
import 'package:cfl/view/screens/auth/splash.dart';
import 'package:cfl/view/styles/assets.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      context.push(const SplashScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Image.asset(
        AppAssets.splash,
        fit: BoxFit.fill,
        height: double.infinity,
      ),
    );
  }
}
