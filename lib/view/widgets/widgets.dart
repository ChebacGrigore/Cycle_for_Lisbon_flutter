//TODO: move later

import 'package:cfl/view/styles/styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InitiativeCard extends StatelessWidget {
  const InitiativeCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 185,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      width: double.infinity,
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: AssetImage(AppAssets.fishBg),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 260,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Kayaku',
                  style: GoogleFonts.dmSans(
                    fontSize: 10,
                    color: AppColors.white.withOpacity(0.80),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Cycling for a better world',
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.dmSans(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc eget augue nec massa volutpat aliquam fringilla.',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: GoogleFonts.dmSans(
                    fontSize: 12,
                    color: AppColors.white.withOpacity(0.80),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 26),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ActvityCount(
                    count: 13,
                    title: 'goal'.tr(),
                  ),
                  const SizedBox(height: 4),
                  ActvityCount(
                    count: 13,
                    title: 'collected'.tr(),
                  ),
                ],
              ),
              // builder here
              Row(
                children: [
                  Image.asset(
                    AppAssets.waterSticker,
                    width: 32,
                    height: 32,
                  ),
                  const SizedBox(width: 10),
                  Image.asset(
                    AppAssets.energySticker,
                    width: 32,
                    height: 32,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ActivityBadge extends StatelessWidget {
  const ActivityBadge(
    this.sticker, {
    super.key,
  });

  final String sticker;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 32,
      height: 32,
      child: Image.asset(
        sticker,
        width: 32,
        height: 32,
      ),
    );
  }
}

class ActvityCount extends StatelessWidget {
  const ActvityCount({
    super.key,
    required this.count,
    required this.title,
    this.color = AppColors.accentColor,
  });
  final int count;
  final String title;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '$title: ',
          style: GoogleFonts.dmSans(
            fontSize: 14,
            color: AppColors.white,
          ),
        ),
        const SizedBox(width: 4),
        const Icon(
          CFLIcons.coin1,
          color: AppColors.secondaryColor,
          size: 16,
        ),
        const SizedBox(width: 4),
        Text(
          count.toString(),
          style: GoogleFonts.dmSans(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: AppColors.white,
          ),
        ),
      ],
    );
  }
}

class PillContainer extends StatelessWidget {
  const PillContainer({
    super.key,
    required this.title,
    required this.count,
    required this.icon,
  });
  final String title;
  final int count;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 25,
        vertical: 7,
      ),
      decoration: BoxDecoration(
        color: AppColors.tertiaryColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: GoogleFonts.dmSans(
              fontSize: 12,
              color: AppColors.primaryColor.withOpacity(0.80),
            ),
          ),
          const SizedBox(width: 6),
          Icon(
            icon,
            color: AppColors.secondaryColor,
          ),
          const SizedBox(width: 6),
          Text(
            count.toString(),
            style: GoogleFonts.dmSans(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
