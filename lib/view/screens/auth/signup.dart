import 'package:cfl/shared/buildcontext_ext.dart';
import 'package:cfl/view/screens/auth/setup_profile.dart';
import 'package:cfl/view/screens/auth/signin.dart';
import 'package:cfl/view/screens/auth/splash.dart';
import 'package:cfl/view/styles/styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(gradient: AppColors.whiteBgGradient),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(
                            AppAssets.logo2Svg,
                            width: 25,
                            height: 25,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Cycle for Lisbon'.toUpperCase(),
                            style: GoogleFonts.dmSans(
                              color: AppColors.primaryColor,
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                            ),
                          )
                        ],
                      ),
                      IconButton(
                        onPressed: () {
                          context.pop();
                        },
                        icon: const Icon(Icons.close),
                      ),
                    ],
                  ),
                  const SizedBox(height: 43),
                  Text(
                    'Sign Up',
                    style: GoogleFonts.dmSans(
                      color: AppColors.primaryColor,
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    'enter_email_sign_up'.tr(),
                    style: GoogleFonts.dmSans(
                      color: AppColors.blueGrey,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 33),
                  AppTextField(
                    controller: TextEditingController(),
                    hint: 'email'.tr(),
                  ),
                  const SizedBox(height: 20),
                  AppTextField(
                    controller: TextEditingController(),
                    hint: 'password'.tr(),
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: () {
                        context.pushReplacement(const SetupProfile());
                      },
                      style: AppComponentThemes.elevatedButtonTheme(),
                      child: Text(
                        'continue'.tr().toUpperCase(),
                        style: GoogleFonts.dmSans(
                            color: AppColors.black,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  const SizedBox(height: 42),
                  const SocialLogins(color: AppColors.black, fill: false),
                  const SizedBox(height: 57),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        context.pop();
                        context.showAppDialog(const SignIn());
                      },
                      child: RichText(
                        text: TextSpan(
                          text: '${'already_have_account_sign_in'.tr()} ',
                          style: GoogleFonts.dmSans(
                            color: AppColors.greyish,
                          ),
                          children: [
                            TextSpan(
                              text: 'sign_in'.tr(),
                              style: GoogleFonts.dmSans(
                                decoration: TextDecoration.underline,
                                color: AppColors.accentColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AppTextField extends StatelessWidget {
  const AppTextField({
    required this.hint,
    required this.controller,
    super.key,
  });
  final String hint;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          hint.toUpperCase(),
          style: GoogleFonts.dmSans(
            fontWeight: FontWeight.bold,
            color: AppColors.blueGrey,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintText: '${'enter'.tr()} $hint',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }
}
