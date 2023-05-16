import 'package:cfl/view/screens/profile/profile_settings.dart';
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
            appbarColor = AppColors.accentColor;
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
            expandedHeight: 130,
            iconTheme: IconThemeData(
              color: appbarColor,
            ),
            title: Text(
              'badges'.tr(),
              style: GoogleFonts.dmSans(
                color: appbarColor,
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(children: <Widget>[
                ClipPath(
                  clipper: HeaderClipper(
                    avatarRadius: 0,
                  ),
                  child: CustomPaint(
                    size: const Size.fromHeight(200),
                    painter: HeaderPainter(
                        color: AppColors.primaryColor, avatarRadius: 0),
                  ),
                ),
              ]),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 16,
                    right: 16,
                    top: 16,
                    bottom: 200,
                  ),
                  child: SingleChildScrollView(
                    physics: const NeverScrollableScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 39),
                        Text(
                          'unlcoked_badge_title'.tr(),
                          style: GoogleFonts.dmSans(
                            fontSize: 14,
                            color: AppColors.primaryColor,
                          ),
                        ),
                        const SizedBox(height: 37),
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 0.9,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
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
                radius: 30,
                child: Image.asset(
                  badgePath,
                  width: 20,
                  height: 20,
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
