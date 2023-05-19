import 'package:cfl/shared/buildcontext_ext.dart';
import 'package:cfl/view/screens/auth/signup.dart';
import 'package:cfl/view/screens/auth/splash.dart';
import 'package:cfl/view/screens/home/layout.dart';
import 'package:cfl/view/styles/styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
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
                    'sign_in'.tr(),
                    style: GoogleFonts.dmSans(
                      color: AppColors.primaryColor,
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    'login_to_account'.tr(),
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
                        obsecure ? CFLIcons.visibility : CFLIcons.visibilityOff,
                      ),
                    ),
                    controller: passController,
                    hint: 'password'.tr(),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        context.showAppDialog(const RecoverPasswordDialog());
                      },
                      child: Text(
                        'recover_password'.tr(),
                        style: GoogleFonts.dmSans(
                          color: AppColors.accentColor,
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: () {
                        context.push(const Layout());
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
                  const SizedBox(height: 57),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        context.pop();
                        context.showAppDialog(const SignUp());
                      },
                      child: RichText(
                        text: TextSpan(
                          text: '${'no_account_sign_up'.tr()} ',
                          style: GoogleFonts.dmSans(
                            color: AppColors.greyish,
                          ),
                          children: [
                            TextSpan(
                              text: 'sign_up'.tr(),
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

class RecoverPasswordDialog extends StatelessWidget {
  const RecoverPasswordDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 22),
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: MediaQuery.of(context).size.height * 0.2,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.white,
      ),
      child: Material(
        color: AppColors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  AppAssets.logo2Svg,
                  width: 25,
                  height: 25,
                ),
                const SizedBox(height: 8),
                Text(
                  'CYCLE FOR LISBON',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.dmSans(
                    fontWeight: FontWeight.w500,
                    fontSize: 22,
                    color: AppColors.black,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              'recover_password'.tr(),
              textAlign: TextAlign.center,
              style: GoogleFonts.dmSans(
                fontWeight: FontWeight.w500,
                fontSize: 22,
                color: AppColors.primaryColor,
              ),
            ),
            const SizedBox(height: 14),
            Text(
              'enter_email_recover'.tr(),
              textAlign: TextAlign.center,
              style: GoogleFonts.dmSans(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: AppColors.primaryColor.withOpacity(0.80),
              ),
            ),
            const SizedBox(height: 16),
            AppTextField(hint: 'Email', controller: TextEditingController()),
            const SizedBox(height: 45),
            SizedBox(
              width: double.infinity,
              height: 49,
              child: ElevatedButton(
                style: AppComponentThemes.elevatedButtonTheme(
                  color: AppColors.secondaryColor,
                  borderColor: Colors.transparent,
                ),
                onPressed: () {},
                child: Text(
                  '${'send'.tr()} Email',
                  style: GoogleFonts.dmSans(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
