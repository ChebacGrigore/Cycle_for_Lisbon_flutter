import 'dart:ui';

import 'package:cfl/shared/shared.dart';
import 'package:cfl/view/screens/auth/signin.dart';
import 'package:cfl/view/screens/auth/signup.dart';
import 'package:cfl/view/styles/styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Material(
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              AppAssets.bg01Png,
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
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
                              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
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
                                  context.showAppDialog(const SignIn());
                                },
                                style: AppComponentThemes.outlinedButtonTheme(),
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
                          context.showAppDialog(const SignUp());
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
              const SizedBox(height: 34),
              const SocialLogins(fill: true),
              const SizedBox(height: 45),
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
              'or'.tr(),
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
              icon: CFLIcons.facebook,
              color: color ?? AppColors.white,
              onTap: () {},
            ),
            const SizedBox(width: 16),
            AppRoundedButton(
              fill: fill,
              color: color ?? AppColors.white,
              icon: CFLIcons.google,
              onTap: () {},
            ),
            const SizedBox(width: 16),
            AppRoundedButton(
              fill: fill,
              color: color ?? AppColors.white,
              icon: CFLIcons.apple,
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
  final IconData icon;
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
          child: Icon(
            icon,
            size: 16,
            color: color ?? AppColors.white,
          ),
        ),
      ),
    );
  }
}
