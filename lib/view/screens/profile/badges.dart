import 'package:cfl/shared/app_bar_clip.dart';

import 'package:cfl/view/styles/assets.dart';
import 'package:cfl/view/styles/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:flutter_svg/svg.dart';

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

  final List<BadgeModel> rides = [
    BadgeModel(1, "Beginner", AppAssets.biginner),
    BadgeModel(1, 'traveler'.tr(), AppAssets.traveler),
    BadgeModel(1, "Pro", AppAssets.pro),
  ];
  final List<BadgeModel> kilometers = [
    BadgeModel(0.8, 'training_wheels'.tr(), AppAssets.trainingWheels),
    BadgeModel(0.7, 'steady_rider'.tr(), AppAssets.steadyRider),
    BadgeModel(0.6, 'road_champion'.tr(), AppAssets.roadChampion),
  ];

  final List<BadgeModel> supportedInitiatives = [
    BadgeModel(0.4, 'good_kid'.tr(), AppAssets.goodKid),
    BadgeModel(0.4, 'heart_of_gold'.tr(), AppAssets.heartOfGold),
    BadgeModel(0.3, 'philanthropist'.tr(), AppAssets.philantrophist),
  ];

  final List<BadgeModel> coinearned = [
    BadgeModel(0.2, 'gatherer'.tr(), AppAssets.gatherer),
    BadgeModel(0.0, "Hoader", AppAssets.hoarder),
    BadgeModel(0.1, 'treasure_master'.tr(), AppAssets.treasureMaster),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
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
                        Text(
                          'number_of_rides'.tr(),
                          style: const TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 16.0),
                        ),
                        const SizedBox(height: 18.0),
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
                          itemCount: rides.length,
                          itemBuilder: (context, index) => Badge(
                            value: rides[index].value,
                            badgePath: rides[index].badgePath,
                            badgeName: rides[index].badgeName,
                          ),
                        ),
                        const SizedBox(height: 40.0),
                        const Text(
                          "Kilometres",
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 16.0),
                        ),
                        const SizedBox(height: 18.0),
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
                          itemCount: kilometers.length,
                          itemBuilder: (context, index) => Badge(
                            value: kilometers[index].value,
                            badgePath: kilometers[index].badgePath,
                            badgeName: kilometers[index].badgeName,
                          ),
                        ),
                        const SizedBox(height: 50.0),
                        const Text(
                          "Supported Initiatives",
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 16.0),
                        ),
                        const SizedBox(height: 18.0),
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
                          itemCount: supportedInitiatives.length,
                          itemBuilder: (context, index) => Badge(
                            value: supportedInitiatives[index].value,
                            badgePath: supportedInitiatives[index].badgePath,
                            badgeName: supportedInitiatives[index].badgeName,
                          ),
                        ),
                        const SizedBox(height: 50.0),
                        const Text(
                          "Coins earned",
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 16.0),
                        ),
                        const SizedBox(height: 18.0),
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
                          itemCount: coinearned.length,
                          itemBuilder: (context, index) => Badge(
                            value: coinearned[index].value,
                            badgePath: coinearned[index].badgePath,
                            badgeName: coinearned[index].badgeName,
                          ),
                        ),
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
                child: SvgPicture.asset(
                  badgePath,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          badgeName,
          textAlign: TextAlign.center,
          style: GoogleFonts.dmSans(
            fontWeight: FontWeight.w500,
            color: AppColors.primaryColor,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
