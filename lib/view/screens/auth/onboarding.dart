import 'package:cfl/shared/buildcontext_ext.dart';
import 'package:cfl/view/screens/auth/signup.dart';
import 'package:cfl/view/styles/styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  int currentIndex = 0;
  Color actionColor = AppColors.white;
  @override
  Widget build(BuildContext context) {
    List<OnboardingItem> items = <OnboardingItem>[
      OnboardingItem(
        title: 'onboard_welcome_title'.tr(),
        description: 'onboard_welcome_desc'.tr(),
        imagePath: AppAssets.onboarding5,
        patners: [],
      ),
      OnboardingItem(
        title: 'onboard_initiative_title'.tr(),
        description: 'onboard_initiative_desc'.tr(),
        imagePath: AppAssets.onboarding2,
        patners: [],
      ),
      OnboardingItem(
        title: 'onboard_coin_title'.tr(),
        description: 'onboard_coin_desc'.tr(),
        imagePath: AppAssets.onboarding1,
        patners: [],
      ),
      OnboardingItem(
        title: 'onboard_help_title'.tr(),
        description: 'onboard_help_desc'.tr(),
        imagePath: AppAssets.onboarding4,
        patners: [],
      ),
      OnboardingItem(
        title: 'onboard_project_title'.tr(),
        description: 'onboard_project_desc'.tr(),
        imagePath: AppAssets.onboarding6,
        patners: [
          AppAssets.p1,
          AppAssets.p2,
          AppAssets.p3,
          AppAssets.p4,
        ],
      ),
    ];
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 2 + 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    items[currentIndex].imagePath,
                  ),
                ),
              ),
              child: SafeArea(
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            style: AppComponentThemes.textButtonTheme(
                              color: actionColor,
                            ),
                            onPressed: () {
                              context.pushReplacement(const SignUp());
                            },
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'skip'.tr(),
                                  style: GoogleFonts.dmSans(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: actionColor,
                                  ),
                                ),
                                SvgPicture.asset(
                                  AppAssets.skip,
                                  width: 25,
                                  height: 25,
                                  color: actionColor,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
              child: Container(
                height: 355,
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                decoration: const BoxDecoration(
                  color: AppColors.white,
                  gradient: AppColors.whiteBgGradient,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(),
                    Text(
                      items[currentIndex].title,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.dmSans(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      items[currentIndex].description,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.dmSans(
                        color: AppColors.primaryColor.withOpacity(0.80),
                        fontSize: 14,
                      ),
                    ),
                    if (items[currentIndex].patners.isEmpty) const Spacer(),
                    if (items[currentIndex].patners.isNotEmpty) ...[
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: items[currentIndex]
                            .patners
                            .map((partner) => Image.asset(
                                  partner,
                                  height: 20,
                                ))
                            .toList(),
                      ),
                      const SizedBox(height: 27),
                    ],
                    if (items[currentIndex].patners.isEmpty)
                      const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: items
                          .map(
                            (e) => OnboardingIndicator(
                              isCurrentIndex:
                                  items.indexOf(e) == currentIndex &&
                                      currentIndex != items.length,
                            ),
                          )
                          .toList(),
                    ),
                    const SizedBox(height: 24),
                    const Spacer(),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: SizedBox(
                        width: 130,
                        height: 49,
                        child: ElevatedButton(
                            style: AppComponentThemes.elevatedButtonTheme(),
                            onPressed: () {
                              setState(() {
                                if (currentIndex == 1 || currentIndex == 3) {
                                  FlutterStatusbarcolor
                                      .setStatusBarWhiteForeground(false);
                                  actionColor = AppColors.primaryColor;
                                } else {
                                  FlutterStatusbarcolor
                                      .setStatusBarWhiteForeground(true);
                                  actionColor = AppColors.white;
                                }
                                if (currentIndex == 4) {
                                  context.pushReplacement(const SignUp());
                                } else {
                                  currentIndex += 1;
                                }
                              });
                            },
                            child: Text(
                              'next'.tr(),
                              style: GoogleFonts.dmSans(
                                color: AppColors.black,
                              ),
                            )),
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          ),
          // const Spacer(),
        ],
      ),
    );
  }
}

class OnboardingIndicator extends StatelessWidget {
  const OnboardingIndicator({required this.isCurrentIndex, super.key});
  final bool isCurrentIndex;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60.6,
      height: 4,
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        color: AppColors.primaryColor.withOpacity(0.10),
        borderRadius: BorderRadius.circular(20),
      ),
      child: isCurrentIndex
          ? Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: 50,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.secondaryColor,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            )
          : null,
    );
  }
}

class OnboardingItem {
  final String title;
  final String description;
  final String imagePath;
  final List<String> patners;
  const OnboardingItem({
    required this.title,
    required this.description,
    required this.imagePath,
    required this.patners,
  });
}
