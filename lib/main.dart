import 'package:cfl/bloc/trip/bloc/trip_bloc.dart';
import 'package:cfl/controller/auth/auth.dart';
import 'package:cfl/routes/app_route.dart';
import 'package:cfl/view/styles/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'bloc/app/bloc/app_bloc.dart';
import 'bloc/auth/bloc/auth_bloc.dart';
// import 'view/screens/auth/signin.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  final container = ProviderContainer();
  await Future.delayed(const Duration(milliseconds: 5000));

  runApp(
    UncontrolledProviderScope(
      container: container,
      child: EasyLocalization(
        supportedLocales: const [
          Locale('en', 'US'),
          Locale('pt', 'BR'),
        ],
        path: 'assets/translations',
        fallbackLocale: const Locale('en', 'US'),
        child: const MyApp(),
      ),
      //child: const TestAdPurchaseProviderScreen(),
      //child: const TestInAppPurchaseProviderScreen(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<String?> tokenFuture;

  // final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  @override
  void initState() {
    super.initState();
    tokenFuture = auth.getFromLocalStorage(value: 'token');
    auth.initForgotPasswordDeepLinkHandling();
    auth.initSocialAuthDeepLinkHandling();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc()),
        BlocProvider(create: (context) => AppBloc()),
        BlocProvider(create: (context) => TripBloc()),
      ],
      child: MaterialApp.router(
        title: 'Cycle For Lisbon',
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        routerConfig: appRoutes,
        theme: ThemeData(
          primarySwatch: AppColors.accentColor,
          fontFamily: 'DmSans',
          appBarTheme: const AppBarTheme(
            centerTitle: true,
          ),
        ),
        // home: const Splash(),
      ),
    );
  }
}
