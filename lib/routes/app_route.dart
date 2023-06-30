import 'package:cfl/bloc/auth/bloc/auth_bloc.dart';
import 'package:cfl/shared/buildcontext_ext.dart';
import 'package:cfl/shared/global/global_var.dart';
import 'package:cfl/splash.dart';
// import 'package:cfl/splash.dart';
import 'package:cfl/view/screens/auth/signin.dart';
import 'package:cfl/view/screens/auth/signup.dart';
import 'package:cfl/view/screens/auth/splash.dart';
import 'package:cfl/view/screens/home/layout.dart';
import 'package:cfl/view/screens/profile/about.dart';
import 'package:cfl/view/screens/profile/badges.dart';
import 'package:cfl/view/screens/profile/help_center.dart';
import 'package:cfl/view/screens/profile/leaderboard.dart';
import 'package:cfl/view/screens/profile/trip_history.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../view/screens/profile/profile_screen.dart';
import 'app_route_paths.dart';

final GoRouter appRoutes = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      // redirect: (_, state){
      //   if(auth.isTokenExpired(accessToken) == false){
      //     return AppRoutePath.home;
      //   }else{
      //     return '${AppRoutePath.splash}/0';
      //   }
      // },
      // redirect: (_, state) => auth.isTokenExpired(accessToken) == false ? AppRoutePath.home : '${AppRoutePath.splash}/0',

      builder: (BuildContext context, GoRouterState state) {
        return const Splash();
      },
    ),
    // GoRoute(
    //   path: '/',
    //   // redirect: (_, state){
    //   //   if(auth.isTokenExpired(accessToken) == false){
    //   //     return AppRoutePath.home;
    //   //   }else{
    //   //     return '${AppRoutePath.splash}/0';
    //   //   }
    //   // },
    //   // redirect: (_, state) => auth.isTokenExpired(accessToken) == false ? AppRoutePath.home : '${AppRoutePath.splash}/0',
    //
    //   builder: (BuildContext context, GoRouterState state) {
    //     return const SplashScreen();
    //   },
    // ),
    GoRoute(
      path: '${AppRoutePath.splash}/:code',
      builder: (BuildContext context, GoRouterState state) {
        final code = state.pathParameters['code'];
        final redirect = state.queryParameters['redirect'];
        print('This is the code >>> $code');
        if (redirect == 'true' && code != null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.read<AuthBloc>().add(AuthGoogleAuthorization(
                  code: code.split('&')[0],
                ));
          });
        }
        return const SplashScreen();
      },
    ),
    GoRoute(
      path: '${AppRoutePath.signin}/:code',
      builder: (BuildContext context, GoRouterState state) {
        final code = state.pathParameters['code'];
        final deepLink = state.queryParameters['deepLink'];
        if (deepLink == 'true' && code != null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.showAppDialog(ResetPasswordDialog(
              code: code,
            ));
          });
        }
        return SignIn(
          // ignore: sdk_version_since
          isDeepLink: bool.tryParse(deepLink!),
          code: code,
        );
      },
    ),
    GoRoute(
      path: AppRoutePath.signup,
      builder: (BuildContext context, GoRouterState state) {
        return const SignUp();
      },
    ),
    GoRoute(
      path: AppRoutePath.home,
      builder: (BuildContext context, GoRouterState state) {
        return const Layout();
      },
    ),
    GoRoute(
      path: AppRoutePath.profile,
      builder: (BuildContext context, GoRouterState state) {
        return const ProfileScreen();
      },
    ),
    GoRoute(
      path: AppRoutePath.badges,
      builder: (BuildContext context, GoRouterState state) {
        return const BadgesScreen();
      },
    ),
    GoRoute(
      path: AppRoutePath.leaderBoard,
      builder: (BuildContext context, GoRouterState state) {
        return const LeaderboardScreen();
      },
    ),
    GoRoute(
      path: AppRoutePath.tripHistory,
      builder: (BuildContext context, GoRouterState state) {
        return const TripHistoryScreen();
      },
    ),
    GoRoute(
      path: AppRoutePath.helpCenter,
      builder: (BuildContext context, GoRouterState state) {
        return const HelpCenter();
      },
    ),
    GoRoute(
      path: AppRoutePath.about,
      builder: (BuildContext context, GoRouterState state) {
        return const AboutScreen();
      },
    ),


  ],
);
