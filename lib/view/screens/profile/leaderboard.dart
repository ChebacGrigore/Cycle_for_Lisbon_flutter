import 'package:cfl/shared/global/global_var.dart';
import 'package:cfl/view/styles/styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';

import '../../../bloc/app/bloc/app_bloc.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({this.showAppBar = true, super.key});
  final bool showAppBar;
  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  @override
  void initState() {
    context.read<AppBloc>().add(AppLeaderboard(token: accessToken));
    super.initState();
  }

  String _buildMedal(int position) {
    switch (position) {
      case 1:
        return AppAssets.medal1;
      case 2:
        return AppAssets.medal2;
      case 3:
        return AppAssets.medal3;

      default:
        return (position).toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: BlocBuilder<AppBloc, AppState>(
        builder: (context, state) {
          if (state.status.isLoading) {
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  automaticallyImplyLeading: widget.showAppBar ? true : false,
                  leading: widget.showAppBar
                      ? IconButton(
                          icon: const Icon(Icons.arrow_back),
                          onPressed: () => Navigator.pop(context),
                        )
                      : null,
                  centerTitle: true,
                  stretch: true,
                  floating: true,
                  pinned: true,
                  expandedHeight: 340,
                  backgroundColor: AppColors.primaryColor,
                  actions: [
                    GestureDetector(
                      onTap: () => Share.share(
                          'Total km ${currentUser.totalDist.round()}, Total Rides ${currentUser.tripCount}, Total Earned ${currentUser.credits.round()}, Position ${state.userPosition},',
                          subject: 'Leaderboard for @${currentUser.username}'),
                      child: Container(
                        margin: const EdgeInsets.only(right: 20),
                        width: 40,
                        height: 40,
                        child: Image.asset(AppAssets.share),
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
                              backgroundImage: NetworkImage(
                                currentProfilePic,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              currentUser.name,
                              style: GoogleFonts.dmSans(
                                color: AppColors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '@${currentUser.username}',
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  LeaderboardActivityCount(
                                    count: currentUser.totalDist.round(),
                                    title: 'total_km'.tr(),
                                    unit: 'km',
                                    icon: AppAssets.roadHz,
                                  ),
                                  const SizedBox(width: 6),
                                  LeaderboardActivityCount(
                                    count: currentUser.tripCount,
                                    title: 'total_rides'.tr(),
                                    unit: 'x',
                                    icon: AppAssets.bicycle,
                                  ),
                                  const SizedBox(width: 6),
                                  LeaderboardActivityCount(
                                    count: currentUser.credits.round(),
                                    title: 'total_earned'.tr(),
                                    unit: '',
                                    icon: AppAssets.handCoins,
                                  ),
                                  const SizedBox(width: 6),
                                  LeaderboardActivityCount(
                                    count: state.userPosition,
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
                  delegate: SliverChildListDelegate(
                    [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.50,
                        padding: const EdgeInsets.only(bottom: 150),
                        decoration: const BoxDecoration(
                          color: AppColors.background,
                          gradient: AppColors.whiteBg3Gradient,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(24),
                            topRight: Radius.circular(24),
                          ),
                        ),
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            );
          } else if (state.status.isError) {
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  automaticallyImplyLeading: widget.showAppBar ? true : false,
                  leading: widget.showAppBar
                      ? IconButton(
                          icon: const Icon(Icons.arrow_back),
                          onPressed: () => Navigator.pop(context),
                        )
                      : null,
                  centerTitle: true,
                  stretch: true,
                  floating: true,
                  pinned: true,
                  expandedHeight: 340,
                  backgroundColor: AppColors.primaryColor,
                  actions: [
                    GestureDetector(
                      onTap: () => Share.share(
                          'Total km ${currentUser.totalDist.round()}, Total Rides ${currentUser.tripCount}, Total Earned ${currentUser.credits.round()}, Position ${state.userPosition},',
                          subject: 'Leaderboard for @${currentUser.username}'),
                      child: Container(
                        margin: const EdgeInsets.only(right: 20),
                        width: 40,
                        height: 40,
                        child: Image.asset(AppAssets.share),
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
                              backgroundImage: NetworkImage(
                                currentProfilePic,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              currentUser.name,
                              style: GoogleFonts.dmSans(
                                color: AppColors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '@${currentUser.username}',
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  LeaderboardActivityCount(
                                    count: currentUser.totalDist.round(),
                                    title: 'total_km'.tr(),
                                    unit: 'km',
                                    icon: AppAssets.roadHz,
                                  ),
                                  const SizedBox(width: 6),
                                  LeaderboardActivityCount(
                                    count: currentUser.tripCount,
                                    title: 'total_rides'.tr(),
                                    unit: 'x',
                                    icon: AppAssets.bicycle,
                                  ),
                                  const SizedBox(width: 6),
                                  LeaderboardActivityCount(
                                    count: currentUser.credits.round(),
                                    title: 'total_earned'.tr(),
                                    unit: '',
                                    icon: AppAssets.handCoins,
                                  ),
                                  const SizedBox(width: 6),
                                  LeaderboardActivityCount(
                                    count: state.userPosition,
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
                  delegate: SliverChildListDelegate(
                    [
                      Container(
                        padding: const EdgeInsets.only(bottom: 160),
                        decoration: const BoxDecoration(
                          color: AppColors.background,
                          gradient: AppColors.whiteBg3Gradient,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(24),
                            topRight: Radius.circular(24),
                          ),
                        ),
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                AppAssets.empty,
                                height: 110,
                              ),
                              const Center(
                                child: Text(
                                  'No Leaderboard added yet!',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            );
          } else if (state.status.isEntries) {
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  automaticallyImplyLeading: widget.showAppBar ? true : false,
                  leading: widget.showAppBar
                      ? IconButton(
                          icon: const Icon(Icons.arrow_back),
                          onPressed: () => Navigator.pop(context),
                        )
                      : null,
                  centerTitle: true,
                  stretch: true,
                  floating: true,
                  pinned: true,
                  expandedHeight: 340,
                  backgroundColor: AppColors.primaryColor,
                  actions: [
                    GestureDetector(
                      onTap: () => Share.share(
                          'Total km ${currentUser.totalDist.round()}, Total Rides ${currentUser.tripCount}, Total Earned ${currentUser.credits.round()}, Position ${state.userPosition},',
                          subject: 'Leaderboard for @${currentUser.username}'),
                      child: Container(
                        margin: const EdgeInsets.only(right: 20),
                        width: 40,
                        height: 40,
                        child: Image.asset(AppAssets.share),
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
                              backgroundImage: NetworkImage(
                                currentProfilePic,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              currentUser.name,
                              style: GoogleFonts.dmSans(
                                color: AppColors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '@${currentUser.username}',
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  LeaderboardActivityCount(
                                    count: currentUser.totalDist.round(),
                                    title: 'total_km'.tr(),
                                    unit: 'km',
                                    icon: AppAssets.roadHz,
                                  ),
                                  const SizedBox(width: 6),
                                  LeaderboardActivityCount(
                                    count: currentUser.tripCount,
                                    title: 'total_rides'.tr(),
                                    unit: 'x',
                                    icon: AppAssets.bicycle,
                                  ),
                                  const SizedBox(width: 6),
                                  LeaderboardActivityCount(
                                    count: currentUser.credits.round(),
                                    title: 'total_earned'.tr(),
                                    unit: '',
                                    icon: AppAssets.handCoins,
                                  ),
                                  const SizedBox(width: 6),
                                  LeaderboardActivityCount(
                                    count: state.userPosition,
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
                  delegate: SliverChildListDelegate(
                    [
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
                            final entry = state.entries[idx];
                            return ListTile(
                              title: Row(
                                children: [
                                  entry.position <= 3
                                      ? Image.asset(
                                          _buildMedal(entry.position),
                                          width: 48,
                                          height: 48,
                                        )
                                      : CircleAvatar(
                                          radius: 23,
                                          backgroundColor:
                                              AppColors.tertiaryColor,
                                          child: Text(
                                            _buildMedal(entry.position),
                                            style: GoogleFonts.dmSans(
                                              color: AppColors.accentColor,
                                            ),
                                          ),
                                        ),
                                  const SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          text: '${entry.name} ',
                                          children: [
                                            TextSpan(
                                              text: '@${entry.username}',
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          LeaderboardActivityCount(
                                            showTitle: false,
                                            count: entry.totalDist.round(),
                                            title: '',
                                            unit: 'km'.tr(),
                                            icon: AppAssets.roadHz,
                                          ),
                                          const SizedBox(width: 20),
                                          LeaderboardActivityCount(
                                            showTitle: false,
                                            count: entry.tripCount,
                                            title: 'rides'.tr(),
                                            unit: 'x',
                                            icon: AppAssets.bicycle,
                                          ),
                                          const SizedBox(width: 20),
                                          LeaderboardActivityCount(
                                            showTitle: false,
                                            count: entry.credits.round(),
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
                    ],
                  ),
                )
              ],
            );
          }
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                automaticallyImplyLeading: widget.showAppBar ? true : false,
                leading: widget.showAppBar
                    ? IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () => Navigator.pop(context),
                      )
                    : null,
                centerTitle: true,
                stretch: true,
                floating: true,
                pinned: true,
                expandedHeight: 340,
                backgroundColor: AppColors.primaryColor,
                actions: [
                  GestureDetector(
                    onTap: () => Share.share(
                        'Total km ${currentUser.totalDist.round()}, Total Rides ${currentUser.tripCount}, Total Earned ${currentUser.credits.round()}, Position ${state.userPosition},',
                        subject: 'Leaderboard for @${currentUser.username}'),
                    child: Container(
                      margin: const EdgeInsets.only(right: 20),
                      width: 40,
                      height: 40,
                      child: Image.asset(AppAssets.share),
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
                            backgroundImage: NetworkImage(
                              currentProfilePic,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            currentUser.name,
                            style: GoogleFonts.dmSans(
                              color: AppColors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '@${currentUser.username}',
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
                                  count: currentUser.totalDist.round(),
                                  title: 'total_km'.tr(),
                                  unit: 'km',
                                  icon: AppAssets.roadHz,
                                ),
                                const SizedBox(width: 6),
                                LeaderboardActivityCount(
                                  count: currentUser.tripCount,
                                  title: 'total_rides'.tr(),
                                  unit: 'x',
                                  icon: AppAssets.bicycle,
                                ),
                                const SizedBox(width: 6),
                                LeaderboardActivityCount(
                                  count: currentUser.credits.round(),
                                  title: 'total_earned'.tr(),
                                  unit: '',
                                  icon: AppAssets.handCoins,
                                ),
                                const SizedBox(width: 6),
                                LeaderboardActivityCount(
                                  count: state.userPosition,
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
                              state.entries[idx].position <= 3
                                  ? Image.asset(
                                      _buildMedal(state.entries[idx].position),
                                      width: 48,
                                      height: 48,
                                    )
                                  : CircleAvatar(
                                      radius: 23,
                                      backgroundColor: AppColors.tertiaryColor,
                                      child: Text(
                                        _buildMedal(
                                            state.entries[idx].position),
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
                                      text: state.entries[idx].name ?? 'N/A',
                                      children: [
                                        TextSpan(
                                          text:
                                              '@${state.entries[idx].username ?? 'N/A'}',
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
                                        count: state.entries[idx].totalDist
                                            .round(),
                                        title: '',
                                        unit: 'km'.tr(),
                                        icon: AppAssets.roadHz,
                                      ),
                                      const SizedBox(width: 20),
                                      LeaderboardActivityCount(
                                        showTitle: false,
                                        count: state.entries[idx].tripCount,
                                        title: 'rides'.tr(),
                                        unit: 'x',
                                        icon: AppAssets.bicycle,
                                      ),
                                      const SizedBox(width: 20),
                                      LeaderboardActivityCount(
                                        showTitle: false,
                                        count:
                                            state.entries[idx].credits.round(),
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
          );
        },
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
  final dynamic count;
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
