import 'dart:ffi';

import 'package:cfl/shared/app_bar_clip.dart';

import 'package:cfl/view/styles/assets.dart';
import 'package:cfl/view/styles/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';

import 'package:google_fonts/google_fonts.dart';

class BadgeModel {
  final double value;
  final String badgeName;
  final String badgePath;
  BadgeModel(this.value, this.badgeName, this.badgePath);
}

class BadgesScreen extends StatefulWidget {
  const BadgesScreen({this.showAppBar = true, super.key});
  final bool showAppBar;
  @override
  State<BadgesScreen> createState() => _BadgesScreenState();
}

class _BadgesScreenState extends State<BadgesScreen> {
  ScrollController scrollController = ScrollController();
  Color appbarColor = AppColors.white;

  @override
  void initState() {
    super.initState();

    FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
    scrollController.addListener(() {
      setState(
        () {
          if (scrollController.offset > 170) {
            appbarColor = AppColors.primaryColor;
            FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
          } else {
            appbarColor = AppColors.white;
            FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
          }
        },
      );
    });
  }

  final List<BadgeModel> badgeList = [
    BadgeModel(1, "Beginner", AppAssets.barBellBadge),
    BadgeModel(1, "Traveler", AppAssets.barBellBadge),
    BadgeModel(1, "Pro", AppAssets.barBellBadge),
    BadgeModel(0.8, "Training Wheels", AppAssets.barBellBadge),
    BadgeModel(0.7, "Steady Rider", AppAssets.barBellBadge),
    BadgeModel(0.6, "Road Chamption", AppAssets.barBellBadge),
    BadgeModel(0.4, "Good Kid", AppAssets.barBellBadge),
    BadgeModel(0.4, "Heart of Gold", AppAssets.barBellBadge),
    BadgeModel(0.3, "Philantrophist", AppAssets.barBellBadge),
    BadgeModel(0.2, "Gatherer", AppAssets.barBellBadge),
    BadgeModel(0.0, "Hoarder", AppAssets.barBellBadge),
    BadgeModel(0.1, "Treasure Master", AppAssets.barBellBadge),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        controller: scrollController,
        slivers: [
          SliverAppBar(
            backgroundColor: AppColors.background,
            foregroundColor: AppColors.accentColor,
            floating: true,
            pinned: true,
            snap: true,
            centerTitle: true,
            automaticallyImplyLeading: widget.showAppBar ? true : false,
            expandedHeight: 110,
            iconTheme: IconThemeData(
              color: appbarColor,
            ),
            title: Text(
              'badges'.tr(),
              style: GoogleFonts.dmSans(
                color: appbarColor,
              ),
            ),
            flexibleSpace: const FlexibleSpaceBar(
              background: MyArc(
                diameter: double.infinity,
                color: AppColors.primaryColor,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 38,
                    right: 38,
                    top: 32,
                    bottom: 100,
                  ),
                  child: SingleChildScrollView(
                    physics: const NeverScrollableScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'unlcoked_badge_title'.tr(),
                          style: GoogleFonts.dmSans(
                            fontSize: 14,
                            color: AppColors.primaryColor.withOpacity(0.50),
                          ),
                        ),
                        const SizedBox(height: 37),
                        GridView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              childAspectRatio: 0.9,
                              crossAxisSpacing: 35.0,
                              mainAxisSpacing: 24.0,
                            ),
                            itemCount: badgeList.length,
                            itemBuilder: (context, index) => Badge(
                                  value: badgeList[index].value,
                                  badgePath: badgeList[index].badgePath,
                                  badgeName: badgeList[index].badgeName,
                                )),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Badge extends StatelessWidget {
  const Badge({
    super.key,
    required this.value,
    required this.badgePath,
    required this.badgeName,
  });
  final double value;
  final String badgePath;
  final String badgeName;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
          children: [
            Positioned.fill(
              child: CircularProgressIndicator(
                backgroundColor: AppColors.tertiaryColor,
                value: value,
                color: AppColors.secondaryColor,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: CircleAvatar(
                backgroundColor: value >= 1
                    ? AppColors.secondaryColor
                    : AppColors.tertiaryColor,
                radius: 29,
                child: Image.asset(
                  badgePath,
                  width: 25,
                  height: 25,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          badgeName,
          softWrap: true,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.dmSans(
            fontWeight: FontWeight.w500,
            color: AppColors.primaryColor,
            fontSize: 12,
          ),
        )
      ],
    );
  }
}
