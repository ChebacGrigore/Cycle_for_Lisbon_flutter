import 'package:cfl/view/screens/auth/signup.dart';
import 'package:cfl/view/styles/styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SetupProfile extends StatelessWidget {
  const SetupProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text(
                'complete_profile_heading'.tr(),
                textAlign: TextAlign.center,
                style: GoogleFonts.dmSans(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 32),
              const CircleAvatar(radius: 40),
              TextButton(
                onPressed: () {},
                child: Text('change_avatar'.tr()),
              ),
              const SizedBox(height: 32),
              AppTextField(
                hint: 'first_name'.tr(),
                controller: TextEditingController(),
              ),
              const SizedBox(height: 16),
              AppTextField(
                hint: 'last_name'.tr(),
                controller: TextEditingController(),
              ),
              const SizedBox(height: 16),
              AppTextField(
                hint: 'nickname'.tr(),
                controller: TextEditingController(),
              ),
              const SizedBox(height: 16),
              AppTextField(
                hint: 'email'.tr(),
                controller: TextEditingController(),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(value: true, onChanged: (val) {}),
                  RichText(
                    text: TextSpan(
                      style: GoogleFonts.dmSans(
                        color: AppColors.primaryColor,
                        fontSize: 11,
                      ),
                      text: '${'agree'.tr()} ',
                      children: [
                        TextSpan(
                          text: '${'terms'.tr()} ',
                          style: GoogleFonts.dmSans(
                            color: AppColors.accentColor,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()..onTap = () {},
                        ),
                        TextSpan(
                          text: '${'and'.tr()} ',
                        ),
                        TextSpan(
                          text: 'privacy'.tr(),
                          style: GoogleFonts.dmSans(
                            color: AppColors.accentColor,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()..onTap = () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              SizedBox(
                height: 49,
                width: double.infinity,
                child: ElevatedButton(
                  style: AppComponentThemes.elevatedButtonTheme(),
                  onPressed: () {},
                  child: Text(
                    'save'.tr(),
                    style: GoogleFonts.dmSans(
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
              )
            ],
          ),
        )),
      ),
    );
  }
}
