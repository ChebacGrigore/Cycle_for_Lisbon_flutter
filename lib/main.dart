import 'package:cfl/splash.dart';
import 'package:cfl/view/styles/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'bloc/app/bloc/app_bloc.dart';
import 'bloc/auth/bloc/auth_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  final container = ProviderContainer();
  await Future.delayed(const Duration(milliseconds: 5000));

  runApp(
    UncontrolledProviderScope(
      // Our riverpod provider scope container
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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc()),
        BlocProvider(create: (context) => AppBloc())
      ],
      child: MaterialApp(
        title: 'Cycle For Lisbon',
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        theme: ThemeData(
            primarySwatch: AppColors.accentColor,
            fontFamily: 'DmSans',
            appBarTheme: const AppBarTheme(
              centerTitle: true,
            )),
        home: const Splash(),
      ),
    );
  }
}
