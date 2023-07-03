// import 'dart:async';

// import 'package:cfl/shared/buildcontext_ext.dart';
// import 'package:cfl/view/screens/auth/splash.dart';
import 'package:cfl/controller/app/trip_service.dart';
import 'package:cfl/routes/app_route_paths.dart';
import 'package:cfl/shared/global/global_var.dart';
import 'package:cfl/view/styles/assets.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'controller/auth/auth.dart';
import 'models/user.model.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    // TripService().getCurrentLocation().then((value) {
    //   currentLocation = value!;
      getStoredData();
      // context.go("${AppRoutePath.splash}/0?redirect=false");
    // });
    //Timesr(const Duration(seconds: 2), () {});
  }

  Future<void> getStoredData() async {
    final token = await auth.getFromLocalStorage(value: 'token');
    final user = await auth.getFromLocalStorage(value: 'user');
    if (token == null || user == null) {
      context.go("${AppRoutePath.splash}/0?redirect=false");
    } else {
      if (auth.isTokenExpired(token) == false) {
        accessToken = token;
        currentUser = User.fromRawJson(user);
        context.pushReplacement(AppRoutePath.home);
      } else {
        context.go("${AppRoutePath.splash}/0?redirect=false");
      }
    }

    // print(accessToken);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Image.asset(
        AppAssets.splash,
        fit: BoxFit.cover,
        height: double.infinity,
        width: double.infinity,
      ),
    );
  }
}
