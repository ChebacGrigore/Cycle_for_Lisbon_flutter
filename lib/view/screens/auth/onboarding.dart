import 'package:cfl/shared/buildcontext_ext.dart';
import 'package:cfl/view/screens/auth/splash.dart';
import 'package:cfl/view/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  List<OnboardingItem> items = <OnboardingItem>[
    const OnboardingItem(
      title: 'Welcom to Cycle for Lisbon',
      description:
          'Get ready to explore the city of Lisbon on two wheels while making a positive impact on NGO initiatives.',
      imagePath: AppAssets.onboarding5,
      patners: [],
    ),
    const OnboardingItem(
      title: 'Support an Initiative',
      description:
          'Choose the initiative you want to support and learn more about its goal and promoters.',
      imagePath: AppAssets.onboarding2,
      patners: [],
    ),
    const OnboardingItem(
      title: 'Earn Coins',
      description:
          'For every kilometer you ride, you will earn coins that can be converted into real money to support the initiative you selected. Cycle for Lisbon is made possible by the generous support of sponsors.',
      imagePath: AppAssets.onboarding1,
      patners: [],
    ),
    const OnboardingItem(
      title: 'Help the Community',
      description:
          'The coins you earn will automatically be donated to your selected initiative. You can only have one active initiative at a time. When the initiative\'s goal is reached, you will be prompted to select a new one.',
      imagePath: AppAssets.onboarding4,
      patners: [],
    ),
    const OnboardingItem(
      title: 'The Project',
      description:
          'Cycle for Lisbon is developed by Pensar Mais for Vox Pop, a project co-financed by Câmara Municipal de Lisboa and the European Regional Development Fund through the European Urban Initiative.',
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
                        'Skip',
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
                        width: 100,
                        height: 49,
                        child: ElevatedButton(
                            style: AppComponentThemes.elevatedButtonTheme(),
                            onPressed: () {
                              setState(() {
                                if (currentIndex == 4) {
                                  context.pushReplacement(const SplashScreen());
                                } else {
                                  currentIndex += 1;
                                }
                              });
                            },
                            child: Text(
                              'Next',
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
