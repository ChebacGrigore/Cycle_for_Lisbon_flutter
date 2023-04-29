import 'package:cfl/view/screens/auth/signup.dart';
import 'package:cfl/view/styles/styles.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SetupProfile extends StatelessWidget {
  const SetupProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              'Complete your profile by adding additional info about yourself',
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
              child: const Text('Change Avatar'),
            ),
            const SizedBox(height: 32),
            AppTextField(
              hint: 'First Name',
              controller: TextEditingController(),
            ),
            const SizedBox(height: 16),
            AppTextField(
              hint: 'Last Name',
              controller: TextEditingController(),
            ),
            const SizedBox(height: 16),
            AppTextField(
              hint: 'Nickname',
              controller: TextEditingController(),
            ),
            const SizedBox(height: 16),
            AppTextField(
              hint: 'Email',
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
                      fontSize: 13,
                    ),
                    text: 'I agree to the ',
                    children: [
                      TextSpan(
                        text: 'Terms of Service ',
                        style: GoogleFonts.dmSans(
                          color: AppColors.accentColor,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()..onTap = () {},
                      ),
                      const TextSpan(
                        text: 'and ',
                      ),
                      TextSpan(
                        text: 'Privacy Policy',
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
                  'Save',
                  style: GoogleFonts.dmSans(
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
