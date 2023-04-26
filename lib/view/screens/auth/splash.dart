import 'package:cfl/shared/shared.dart';
import 'package:cfl/view/screens/auth/signin.dart';
import 'package:cfl/view/screens/auth/signup.dart';
import 'package:cfl/view/styles/styles.dart';
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
                      'Cycle For Lisbon',
                      style: GoogleFonts.dmSans(
                        color: AppColors.white,
                        fontSize: 48,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sit adipiscing sit enim enim id iaculis tristique.',
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
                      child: OutlinedButton(
                        onPressed: () {
                          context.showAppDialog(const SignIn());
                        },
                        style: AppComponentThemes.outlinedButtonTheme(),
                        child: const Text(
                          'Sign In',
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
                        child: const Text('Sign Up',
                            style: TextStyle(
                              color: AppColors.black,
                            )),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 34),
              const SocialLogins(),
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
  });
  final Color? color;
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
              'OR',
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
              icon: Icons.facebook,
              color: color ?? AppColors.white,
              onTap: () {},
            ),
            const SizedBox(width: 16),
            AppRoundedButton(
              color: color ?? AppColors.white,
              icon: Icons.g_mobiledata,
              onTap: () {},
            ),
            const SizedBox(width: 16),
            AppRoundedButton(
              color: color ?? AppColors.white,
              icon: Icons.apple,
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
  });
  final VoidCallback? onTap;
  final IconData icon;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onTap,
      elevation: 0,
      fillColor: color != null
          ? color!.withOpacity(0.16)
          : Colors.white.withOpacity(0.16),
      padding: const EdgeInsets.all(15.0),
      shape: const CircleBorder(),
      child: Icon(
        icon,
        size: 35.0,
        color: color ?? AppColors.white,
      ),
    );
  }
}
