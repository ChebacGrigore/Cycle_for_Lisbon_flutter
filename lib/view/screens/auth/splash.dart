// ignore_for_file: deprecated_member_use

import 'dart:ui';

// import 'package:cfl/bloc/auth/bloc/auth_bloc.dart';
// import 'package:cfl/routes/app_route.dart';
// import 'package:cfl/routes/app_route_paths.dart';
import 'package:cfl/shared/shared.dart';
import 'package:cfl/view/screens/auth/onboarding.dart';
import 'package:cfl/view/screens/auth/signin.dart';
// import 'package:cfl/view/screens/auth/signin.dart';
import 'package:cfl/view/styles/styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
// import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

// import '../../../controller/auth/auth.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Material(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                AppAssets.bg01Png,
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: DropdownButton(
                      underline: const SizedBox(),
                      borderRadius: BorderRadius.circular(8),
                      dropdownColor: AppColors.greyish,
                      style: GoogleFonts.dmSans(color: AppColors.white),
                      icon: const Icon(
                        Icons.language,
                        color: AppColors.white,
                      ),
                      items: [
                        DropdownMenuItem(
                          value: 'en',
                          child: Text(
                            'english'.tr(),
                          ),
                        ),
                        DropdownMenuItem(
                          value: 'pt',
                          child: Text(
                            'portugues'.tr(),
                          ),
                        ),
                      ],
                      onChanged: (v) {
                        if (v == 'pt') {
                          context.setLocale(
                            const Locale('pt', 'BR'),
                          );
                        } else {
                          context.setLocale(
                            const Locale('en', 'US'),
                          );
                        }
                        setState(() {});
                      },
                      value: context.locale.languageCode),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(28),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      AppAssets.logoSvg,
                      width: 50,
                      height: 35,
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(right: 60),
                      child: Column(
                        children: [
                          Text(
                            'Cycle For Lisbon'.toUpperCase(),
                            style: GoogleFonts.dmSans(
                              color: AppColors.white,
                              fontSize: 48,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'splash_welcome'.tr(),
                            style: GoogleFonts.dmSans(
                              color: AppColors.white.withOpacity(0.80),
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 49,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Stack(
                                children: [
                                  BackdropFilter(
                                    filter:
                                        ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                                    child: Container(
                                      width: double.infinity,
                                      height: double.infinity,
                                      color: Colors.transparent,
                                    ),
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    height: 49,
                                    child: OutlinedButton(
                                      onPressed: () {
                                        // context.go('/signin/0?deepLink=true');
                                        context.showAppDialog(const SignIn());
                                      },
                                      style: AppComponentThemes
                                          .outlinedButtonTheme(),
                                      child: Text(
                                        'sign_in'.tr(),
                                        style: GoogleFonts.dmSans(
                                          color: AppColors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: SizedBox(
                            height: 49,
                            child: ElevatedButton(
                              onPressed: () {
                                context.showAppDialog(const Onboarding());
                              },
                              style: AppComponentThemes.elevatedButtonTheme(),
                              child: Text(
                                'sign_up'.tr(),
                                style: GoogleFonts.dmSans(
                                  color: AppColors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    // const SizedBox(height: 34),
                    // const SocialLogins(fill: true),
                    // const SizedBox(height: 45),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SocialLogins extends StatelessWidget {
  const SocialLogins({
    this.color,
    super.key,
    required this.fill,
  });
  final Color? color;
  final bool fill;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
                child: Divider(
              color: color ?? AppColors.white,
            )),
            const SizedBox(width: 16),
            Text(
              'or'.tr().toUpperCase(),
              style: TextStyle(
                color: color != null
                    ? color!.withOpacity(0.60)
                    : AppColors.white.withOpacity(0.60),
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
                child: Divider(
              color: color ?? AppColors.white,
            )),
          ],
        ),
        const SizedBox(height: 16),
        //build rounded social login buttons
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppRoundedButton(
              fill: fill,
              icon: AppAssets.facebook,
              color: color ?? AppColors.white,
              onTap: () {},
            ),
            const SizedBox(width: 16),
            AppRoundedButton(
              fill: fill,
              color: color ?? AppColors.white,
              icon: AppAssets.google,
              onTap: () {
                // context.read<AuthBloc>().add(const AuthGoogle());
              },
            ),
            const SizedBox(width: 16),
            AppRoundedButton(
              fill: fill,
              color: color ?? AppColors.white,
              icon: AppAssets.apple,
              onTap: () {},
            ),
          ],
        ),
      ],
    );
  }
}

class AppRoundedButton extends StatelessWidget {
  const AppRoundedButton({
    super.key,
    this.onTap,
    required this.icon,
    this.color,
    this.fill = false,
  });
  final VoidCallback? onTap;
  final String icon;
  final Color? color;
  final bool fill;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 48,
      height: 48,
      child: RawMaterialButton(
        onPressed: onTap,
        elevation: 0,
        fillColor: fill
            ? color != null
                ? color!.withOpacity(0.16)
                : Colors.white.withOpacity(0.16)
            : AppColors.white,
        padding: const EdgeInsets.all(15.0),
        shape: const CircleBorder(),
        child: Center(
          child: SvgPicture.asset(
            icon,
            color: color ?? AppColors.white,
          ),
        ),
      ),
    );
  }
}
