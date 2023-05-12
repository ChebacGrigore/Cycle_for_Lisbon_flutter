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
  int currentIndex = 0;
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
              height: MediaQuery.of(context).size.height / 2 + 150,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage(
                    items[currentIndex].imagePath,
                  ),
                ),
              ),
              child: Container(
                color: AppColors.black.withOpacity(0.3),
                child: SafeArea(
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 16.0),
                              child: DropdownButton(
                                  underline: const SizedBox(),
                                  borderRadius: BorderRadius.circular(8),
                                  dropdownColor: AppColors.greyish,
                                  style: GoogleFonts.dmSans(
                                      color: AppColors.white),
                                  icon: const Icon(
                                    Icons.language,
                                    color: AppColors.white,
                                  ),
                                  items: [
                                    DropdownMenuItem(
                                      value: 'en',
                                      child: Text(
                                        'english'.tr(),
                                      ),
                                    ),
                                    DropdownMenuItem(
                                      value: 'pt',
                                      child: Text(
                                        'portugues'.tr(),
                                      ),
                                    ),
                                  ],
                                  onChanged: (v) {
                                    if (v == 'pt') {
                                      context.setLocale(
                                        const Locale('pt', 'BR'),
                                      );
                                    } else {
                                      context.setLocale(
                                        const Locale('en', 'US'),
                                      );
                                    }
                                    setState(() {});
                                  },
                                  value: context.locale.languageCode),
                            ),
                            TextButton.icon(
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
                              label: const Icon(Icons.skip_next_rounded),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
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
                height: MediaQuery.of(context).size.height / 2 - 100,
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 32,
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
                      const SizedBox(height: 24),
                    if (items[currentIndex].patners.isNotEmpty) ...[
                      const SizedBox(height: 19),
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
                    const SizedBox(height: 24),
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
