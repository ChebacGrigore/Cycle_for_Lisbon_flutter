import 'package:cfl/shared/buildcontext_ext.dart';
import 'package:cfl/view/screens/auth/splash.dart';
import 'package:cfl/view/styles/styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
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
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 2 - 20,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage(
                    items[currentIndex].imagePath,
                  ),
                ),
              ),
              child: Container(
                color: AppColors.black.withOpacity(0.5),
                child: SafeArea(
                  child: Align(
                    alignment: Alignment.topRight,
                    child: TextButton.icon(
                      style: AppComponentThemes.textButtonTheme(
                        color: AppColors.white,
                      ),
                      onPressed: () {
                        context.pushReplacement(const SplashScreen());
                      },
                      icon: Text(
                        'skip'.tr(),
                        style: GoogleFonts.dmSans(),
                      ),
                      label: const Icon(CFLIcons.skipArrow),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 51),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      items[currentIndex].title,
                      style: GoogleFonts.dmSans(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 120,
                      child: Text(
                        items[currentIndex].description,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.dmSans(
                          color: AppColors.primaryColor.withOpacity(0.80),
                          fontSize: 14,
                        ),
                      ),
                    ),
                    if (items[currentIndex].patners.isEmpty)
                      const SizedBox(height: 19),
                    if (items[currentIndex].patners.isNotEmpty) ...[
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: items[currentIndex]
                            .patners
                            .map((partner) => Image.asset(
                                  partner,
                                  height: 20,
                                ))
                            .toList(),
                      )
                    ],
                    const SizedBox(height: 29),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    const SizedBox(height: 29),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: SizedBox(
                        width: 130,
                        height: 49,
                        child: ElevatedButton(
                            style: AppComponentThemes.elevatedButtonTheme(),
                            onPressed: () {
                              // context.setLocale(kPT);
                              setState(() {
                                if (currentIndex == 4) {
                                  context.pushReplacement(const SplashScreen());
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
                    )
                  ],
                ),
              ),
            ),
            // const Spacer(),
          ],
        ),
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
      width: 70,
      height: 4,
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
