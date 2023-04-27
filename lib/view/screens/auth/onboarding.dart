import 'package:cfl/view/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height / 2,
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(
                  AppAssets.onboarding3,
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
                    onPressed: () {},
                    icon: Text(
                      'Skip',
                      style: GoogleFonts.dmSans(),
                    ),
                    label: const Icon(Icons.skip_next),
                  ),
                ),
              ),
            ),
          ),
          //
          const SizedBox(height: 71),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Welcome to Cycle for Lisbon!',
                  style: GoogleFonts.dmSans(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Get ready to explore the city of Lisbon on two wheels while making a positive impact on NGO initiatives.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.dmSans(
                    color: AppColors.primaryColor.withOpacity(0.80),
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 69),
                //
                const SizedBox(height: 24),
                Align(
                  alignment: Alignment.bottomRight,
                  child: SizedBox(
                    width: 100,
                    height: 49,
                    child: ElevatedButton(
                        style: AppComponentThemes.elevatedButtonTheme(),
                        onPressed: () {},
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
        ],
      ),
    );
  }
}
