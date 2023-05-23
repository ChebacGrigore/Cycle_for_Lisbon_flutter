import 'package:cfl/shared/buildcontext_ext.dart';
import 'package:cfl/view/screens/auth/setup_profile.dart';
import 'package:cfl/view/screens/auth/signin.dart';
import 'package:cfl/view/screens/auth/splash.dart';
import 'package:cfl/view/styles/styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  void initState() {
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    super.initState();
  }

  @override
  void dispose() {
    FlutterStatusbarcolor.setStatusBarWhiteForeground(true);

    super.dispose();
  }

  bool obsecure = true;
  TextEditingController passController = TextEditingController();
  TextEditingController emailController = TextEditingController();
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
              padding: const EdgeInsets.all(20.0),
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
                    prefixIcon: CFLIcons.mail,
                    isObsecure: false,
                    controller: emailController,
                    hint: 'email'.tr(),
                  ),
                  const SizedBox(height: 20),
                  AppTextField(
                    isObsecure: obsecure,
                    prefixIcon: CFLIcons.lock,
                    sufixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          obsecure = !obsecure;
                        });
                      },
                      child: Icon(
                        obsecure ? CFLIcons.visibilityOff : CFLIcons.visibility,
                      ),
                    ),
                    controller: passController,
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
                        'continue'.tr(),
                        style: GoogleFonts.dmSans(
                            color: AppColors.black,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                  const SizedBox(height: 42),
                  const SocialLogins(color: AppColors.black, fill: false),
                  const SizedBox(height: 42),
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
    this.prefixIcon,
    this.sufixIcon,
    this.isObsecure = false,
    super.key,
  });
  final String hint;
  final IconData? prefixIcon;
  final Widget? sufixIcon;
  final bool isObsecure;

  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          hint,
          style: GoogleFonts.dmSans(
            fontWeight: FontWeight.normal,
            color: AppColors.primaryColor,
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 46,
          child: TextFormField(
            obscureText: isObsecure,
            controller: controller,
            decoration: InputDecoration(
              prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
              suffixIcon: sufixIcon,
              hintText: '${'enter'.tr()} $hint',
              hintStyle: GoogleFonts.dmSans(
                fontSize: 14,
                color: AppColors.primaryColor.withOpacity(0.50),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
