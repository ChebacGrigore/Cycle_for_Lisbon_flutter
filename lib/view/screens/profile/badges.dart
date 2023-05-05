import 'package:cfl/view/screens/profile/profile_settings.dart';
import 'package:cfl/view/styles/assets.dart';
import 'package:cfl/view/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BadgesScreen extends StatefulWidget {
  const BadgesScreen({this.showAppBar = true, super.key});
  final bool showAppBar;
  @override
  State<BadgesScreen> createState() => _BadgesScreenState();
}

class _BadgesScreenState extends State<BadgesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: AppColors.background,
            floating: true,
            pinned: true,
            snap: true,
            centerTitle: true,
            automaticallyImplyLeading: widget.showAppBar ? true : false,
            expandedHeight: 150,
            iconTheme: const IconThemeData(
              color: AppColors.white,
            ),
            title: Text(
              'Badges',
              style: GoogleFonts.dmSans(
                color: AppColors.white,
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(children: <Widget>[
                ClipPath(
                  clipper: HeaderClipper(
                    avatarRadius: 0,
                  ),
                  child: CustomPaint(
                    size: const Size.fromHeight(220),
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
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  child: SingleChildScrollView(
                    physics: const NeverScrollableScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 39),
                        Text(
                          'You have Unlocked 3 Badges out of 15',
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
                            crossAxisSpacing: 41,
                            mainAxisSpacing: 24,
                          ),
                          itemCount: 150,
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
