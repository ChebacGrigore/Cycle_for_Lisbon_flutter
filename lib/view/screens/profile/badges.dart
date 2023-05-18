import 'package:cfl/shared/app_bar_clip.dart';

import 'package:cfl/view/styles/assets.dart';
import 'package:cfl/view/styles/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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

    scrollController.addListener(() {
      setState(
        () {
          if (scrollController.offset > 170) {
            appbarColor = AppColors.primaryColor;
          } else {
            appbarColor = AppColors.white;
          }
        },
      );
    });
  }

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
            expandedHeight: 150,
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
                    bottom: 200,
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
                            color: AppColors.primaryColor,
                          ),
                        ),
                        // 47 //  const SizedBox(height: 23),
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 0.8,
                            crossAxisSpacing: 47,
                            mainAxisSpacing: 30,
                          ),
                          itemCount: 12,
                          itemBuilder: (context, index) {
                            return const Badge(
                              value: 0.5,
                              badgePath: AppAssets.barBellBadge,
                              badgeName: 'Badge Name',
                            );
                          },
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
            )),
            Padding(
              padding: const EdgeInsets.all(5),
              child: CircleAvatar(
                backgroundColor: value >= 1
                    ? AppColors.accentColor
                    : AppColors.tertiaryColor,
                radius: 35,
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
