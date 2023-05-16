import 'package:cfl/view/styles/styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({this.showAppBar = true, super.key});
  final bool showAppBar;
  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
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
            expandedHeight: 325,
            actions: [
              Container(
                margin: const EdgeInsets.only(right: 20),
                padding: const EdgeInsets.all(12),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: AppColors.blackShareButtonGradient,
                ),
                child: const Icon(
                  Icons.share_outlined,
                  color: AppColors.accentColor,
                  size: 24,
                ),
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
                      AppAssets.appBarBg,
                    ),
                    fit: BoxFit.contain,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const CircleAvatar(
                        radius: 45,
                        backgroundColor: AppColors.white,
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
                              icon: CFLIcons.roadhz,
                            ),
                            const SizedBox(width: 6),
                            LeaderboardActivityCount(
                              count: 12,
                              title: 'total_rides'.tr(),
                              unit: 'x',
                              icon: CFLIcons.bicycle,
                            ),
                            const SizedBox(width: 6),
                            LeaderboardActivityCount(
                              count: 120,
                              title: 'total_earned'.tr(),
                              unit: '',
                              icon: CFLIcons.coin1,
                            ),
                            const SizedBox(width: 6),
                            LeaderboardActivityCount(
                              count: 23,
                              title: 'position'.tr(),
                              unit: '',
                              icon: CFLIcons.bmedalmilitary,
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
                  gradient: AppColors.whiteBgGradient,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                  color: AppColors.white,
                ),
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 5,
                  itemBuilder: (ctx, idx) {
                    return ListTile(
                      leading: const CircleAvatar(radius: 45),
                      title: RichText(
                        text: TextSpan(
                          text: 'Wade  ',
                          children: [
                            TextSpan(
                              text: '@username',
                              style: GoogleFonts.dmSans(
                                fontSize: 12,
                                color: AppColors.primaryColor.withOpacity(0.60),
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
                      subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          LeaderboardActivityCount(
                            showTitle: false,
                            count: 232,
                            title: '',
                            unit: 'km'.tr(),
                            icon: CFLIcons.roadhz,
                          ),
                          const SizedBox(width: 20),
                          LeaderboardActivityCount(
                            showTitle: false,
                            count: 20,
                            title: 'rides'.tr(),
                            unit: 'x',
                            icon: CFLIcons.bicycle,
                          ),
                          const SizedBox(width: 20),
                          const LeaderboardActivityCount(
                            showTitle: false,
                            count: 20,
                            title: '',
                            unit: '',
                            icon: CFLIcons.coin1,
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
  final IconData icon;
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
            Icon(
              icon,
              color: AppColors.accentColor,
              size: showTitle ? 25 : 15,
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
