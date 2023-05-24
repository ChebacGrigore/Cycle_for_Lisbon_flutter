import 'package:cfl/view/styles/styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({this.showAppBar = true, super.key});
  final bool showAppBar;
  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  String _buildMedal(int position) {
    switch (position) {
      case 0:
        return AppAssets.medal1;
      case 1:
        return AppAssets.medal2;
      case 2:
        return AppAssets.medal3;

      default:
        return (position + 1).toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: widget.showAppBar ? true : false,
            centerTitle: true,
            stretch: true,
            floating: true,
            pinned: true,
            expandedHeight: 340,
            backgroundColor: AppColors.primaryColor,
            actions: [
              Container(
                margin: const EdgeInsets.only(right: 20),
                width: 40,
                height: 40,
                child: Image.asset(AppAssets.share),
              ),
            ],
            iconTheme: const IconThemeData(color: AppColors.white),
            title: Text(
              'leaderboard'.tr(),
              style: GoogleFonts.dmSans(
                color: AppColors.white,
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  color: AppColors.primaryColor,
                  image: DecorationImage(
                    alignment: Alignment.bottomCenter,
                    image: AssetImage(
                      AppAssets.leaderBoardBg,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 45,
                    left: 16.0,
                    right: 16,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: AppColors.white,
                        child: Image.asset(
                          AppAssets.avatar,
                          width: 62,
                          height: 62,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'you'.tr(),
                        style: GoogleFonts.dmSans(
                          color: AppColors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '@jane123',
                        style: GoogleFonts.dmSans(
                          color: AppColors.white,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 37),
                      Container(
                        decoration: BoxDecoration(
                            color: AppColors.white.withOpacity(0.06),
                            borderRadius: BorderRadius.circular(10)),
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            LeaderboardActivityCount(
                              count: 23,
                              title: 'total_km'.tr(),
                              unit: 'km',
                              icon: AppAssets.roadHz,
                            ),
                            const SizedBox(width: 6),
                            LeaderboardActivityCount(
                              count: 12,
                              title: 'total_rides'.tr(),
                              unit: 'x',
                              icon: AppAssets.bicycle,
                            ),
                            const SizedBox(width: 6),
                            LeaderboardActivityCount(
                              count: 120,
                              title: 'total_earned'.tr(),
                              unit: '',
                              icon: AppAssets.handCoins,
                            ),
                            const SizedBox(width: 6),
                            LeaderboardActivityCount(
                              count: 23,
                              title: 'position'.tr(),
                              unit: '',
                              icon: AppAssets.medal,
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
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                padding: const EdgeInsets.only(bottom: 150),
                decoration: const BoxDecoration(
                  color: AppColors.background,
                  gradient: AppColors.whiteBg3Gradient,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 5,
                  itemBuilder: (ctx, idx) {
                    return ListTile(
                      title: Row(
                        children: [
                          idx <= 2
                              ? Image.asset(
                                  _buildMedal(idx),
                                  width: 48,
                                  height: 48,
                                )
                              : CircleAvatar(
                                  radius: 23,
                                  backgroundColor: AppColors.tertiaryColor,
                                  child: Text(
                                    _buildMedal(idx),
                                    style: GoogleFonts.dmSans(
                                      color: AppColors.accentColor,
                                    ),
                                  ),
                                ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(
                                  text: 'Wade  ',
                                  children: [
                                    TextSpan(
                                      text: '@username',
                                      style: GoogleFonts.dmSans(
                                        fontSize: 12,
                                        color: AppColors.primaryColor
                                            .withOpacity(0.60),
                                      ),
                                    ),
                                  ],
                                  style: GoogleFonts.dmSans(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  LeaderboardActivityCount(
                                    showTitle: false,
                                    count: 232,
                                    title: '',
                                    unit: 'km'.tr(),
                                    icon: AppAssets.roadHz,
                                  ),
                                  const SizedBox(width: 20),
                                  LeaderboardActivityCount(
                                    showTitle: false,
                                    count: 20,
                                    title: 'rides'.tr(),
                                    unit: 'x',
                                    icon: AppAssets.bicycle,
                                  ),
                                  const SizedBox(width: 20),
                                  const LeaderboardActivityCount(
                                    showTitle: false,
                                    count: 20,
                                    title: '',
                                    unit: '',
                                    icon: AppAssets.handCoins,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (ctx, idx) {
                    return const Divider();
                  },
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}

class LeaderboardActivityCount extends StatelessWidget {
  const LeaderboardActivityCount({
    super.key,
    required this.count,
    required this.title,
    required this.icon,
    required this.unit,
    this.showTitle = true,
  });
  final String title;
  final int count;
  final String icon;
  final String unit;
  final bool showTitle;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showTitle == true) ...[
          Text(
            '$title:',
            style: GoogleFonts.dmSans(
              color: AppColors.white.withOpacity(0.60),
              fontSize: 10,
            ),
          ),
          const SizedBox(height: 5),
        ],
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              icon,
              color: AppColors.accentColor,
              width: 25,
            ),
            const SizedBox(width: 8),
            Text(
              title.contains('Rides') ? '$unit$count' : '$count $unit',
              style: GoogleFonts.dmSans(
                color: showTitle ? AppColors.white : AppColors.primaryColor,
                fontWeight: showTitle ? FontWeight.bold : FontWeight.normal,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
