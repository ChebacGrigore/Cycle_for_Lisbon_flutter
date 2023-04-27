import 'package:cfl/shared/buildcontext_ext.dart';
import 'package:cfl/view/screens/auth/signin.dart';
import 'package:cfl/view/screens/auth/splash.dart';
import 'package:cfl/view/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
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
                      icon: const Icon(Icons.close)),
                ],
              ),
              const SizedBox(height: 43),
              Text(
                'Sign Up',
                style: GoogleFonts.dmSans(
                  color: AppColors.shadowColor,
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 14),
              Text(
                'Enter your email address to sign up',
                style: GoogleFonts.dmSans(
                  color: AppColors.blueGrey,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 33),
              AppTextField(
                controller: TextEditingController(),
                hint: 'Email',
              ),
              const SizedBox(height: 20),
              AppTextField(
                controller: TextEditingController(),
                hint: 'Password',
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {},
                  style: AppComponentThemes.elevatedButtonTheme(),
                  child: Text(
                    'Continue'.toUpperCase(),
                    style: GoogleFonts.dmSans(
                        color: AppColors.black, fontWeight: FontWeight.w700),
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
                      text: 'Already have an account? ',
                      style: GoogleFonts.dmSans(
                        color: AppColors.greyish,
                      ),
                      children: [
                        TextSpan(
                          text: ' Login',
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
            hintText: 'Enter $hint here',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }
}
