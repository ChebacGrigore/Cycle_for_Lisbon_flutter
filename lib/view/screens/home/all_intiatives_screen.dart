import 'package:cfl/shared/shared.dart';
import 'package:cfl/view/screens/home/single_initiative.dart';
import 'package:cfl/view/styles/styles.dart';
import 'package:cfl/view/widgets/widgets.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InitiativeScreen extends StatelessWidget {
  const InitiativeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 100),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 42),
              Text(
                'available_initiatives'.tr(),
                style: GoogleFonts.dmSans(
                  fontSize: 18,
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 24),
              ListView.builder(
                shrinkWrap: true,
                itemCount: 4,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: GestureDetector(
                      onTap: () {
                        context.push(const SingleInitiative());
                      },
                      child: const InitiativeCard(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
