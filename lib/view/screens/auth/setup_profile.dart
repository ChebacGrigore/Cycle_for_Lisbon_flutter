import 'package:cfl/controller/auth/auth.dart';
import 'package:cfl/shared/buildcontext_ext.dart';
import 'package:cfl/view/screens/auth/signup.dart';

import 'package:cfl/view/screens/home/layout.dart';
import 'package:cfl/view/styles/styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:google_fonts/google_fonts.dart';

class SetupProfile extends ConsumerStatefulWidget {
  const SetupProfile({
    required this.emai,
    required this.password,
    super.key,
  });
  final String emai;
  final String password;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SetupProfile2State();
}

class _SetupProfile2State extends ConsumerState<SetupProfile> {
  @override
  void initState() {
    email = TextEditingController(text: widget.emai);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    super.initState();
  }

  @override
  void dispose() {
    FlutterStatusbarcolor.setStatusBarWhiteForeground(true);

    super.dispose();
  }

  TextEditingController email = TextEditingController();
  final TextEditingController fName = TextEditingController();
  final TextEditingController lName = TextEditingController();
  final TextEditingController nickName = TextEditingController();
  bool isCheked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.whiteBgGradient),
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: SafeArea(
              child: Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              top: 57,
              bottom: 67,
            ),
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
                  controller: fName,
                ),
                const SizedBox(height: 16),
                AppTextField(
                  hint: 'last_name'.tr(),
                  controller: lName,
                ),
                const SizedBox(height: 16),
                AppTextField(
                  hint: 'nickname'.tr(),
                  controller: nickName,
                ),
                const SizedBox(height: 16),
                AppTextField(
                  hint: 'email'.tr(),
                  controller: email,
                  sufixIcon: const Icon(Icons.check),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Checkbox(
                        value: isCheked,
                        onChanged: (val) {
                          isCheked = val ?? false;
                          setState(() {});
                        },
                        activeColor: AppColors.accentColor,
                        checkColor: Colors.white,
                      ),
                    ),
                    Flexible(
                      child: RichText(
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        text: TextSpan(
                          style: GoogleFonts.dmSans(
                            color: AppColors.primaryColor,
                            fontSize: 13,
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
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                SizedBox(
                  height: 49,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: AppComponentThemes.elevatedButtonTheme(),
                    onPressed: () async {
                      await ref.watch(
                        registerUserProvider(
                          email: widget.emai,
                          password: widget.password,
                          fName: fName.text,
                          lName: lName.text,
                        ),
                      );
                      if (context.mounted) {
                        context.pushReplacement(const Layout());
                      }
                    },
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
      ),
    );
  }
}
