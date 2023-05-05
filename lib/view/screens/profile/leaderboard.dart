import 'package:cfl/view/styles/styles.dart';
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
            expandedHeight: 370,
            iconTheme: const IconThemeData(color: AppColors.white),
            title: Text(
              'Leaderboard',
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
                        'You',
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
                          children: const [
                            LeaderboardActivityCount(
                              count: 23,
                              title: 'Total km',
                              unit: 'km',
                              icon: Icons.roundabout_right_rounded,
                            ),
                            SizedBox(width: 6),
                            LeaderboardActivityCount(
                              count: 12,
                              title: 'Total Rides',
                              unit: 'x',
                              icon: Icons.pedal_bike_outlined,
                            ),
                            SizedBox(width: 6),
                            LeaderboardActivityCount(
                              count: 120,
                              title: 'Total Earned',
                              unit: '',
                              icon: Icons.attach_money,
                            ),
                            SizedBox(width: 6),
                            LeaderboardActivityCount(
                              count: 23,
                              title: 'Position',
                              unit: '',
                              icon: Icons.grade_outlined,
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
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
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
                        children: const [
                          LeaderboardActivityCount(
                            showTitle: false,
                            count: 232,
                            title: '',
                            unit: 'km',
                            icon: Icons.roundabout_right_outlined,
                          ),
                          SizedBox(width: 20),
                          LeaderboardActivityCount(
                            showTitle: false,
                            count: 20,
                            title: 'Rides',
                            unit: 'x',
                            icon: Icons.pedal_bike,
                          ),
                          SizedBox(width: 20),
                          LeaderboardActivityCount(
                            showTitle: false,
                            count: 20,
                            title: '',
                            unit: '',
                            icon: Icons.attach_money_outlined,
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
