// import 'dart:async';

// import 'package:cfl/shared/buildcontext_ext.dart';
// import 'package:cfl/view/screens/auth/splash.dart';
import 'package:cfl/controller/app/trip_service.dart';
import 'package:cfl/routes/app_route_paths.dart';
import 'package:cfl/shared/global/global_var.dart';
import 'package:cfl/view/styles/assets.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    TripService().getCurrentLocation().then((value) {
      currentLocation = value!;
      context.go("${AppRoutePath.splash}/0?redirect=false");
    });
    //Timer(const Duration(seconds: 2), () {});
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
