import 'package:cfl/bloc/auth/bloc/auth_bloc.dart';
import 'package:cfl/shared/buildcontext_ext.dart';
import 'package:cfl/splash.dart';
import 'package:cfl/view/screens/auth/signin.dart';
import 'package:cfl/view/screens/auth/signup.dart';
import 'package:cfl/view/screens/auth/splash.dart';
import 'package:cfl/view/screens/home/layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'app_route_paths.dart';

final GoRouter appRoutes = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const Splash();
      },
    ),
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
  ],
);
