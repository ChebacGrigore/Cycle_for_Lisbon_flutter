import 'package:cfl/view/screens/profile/profile_settings.dart';
import 'package:cfl/view/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            foregroundColor: AppColors.white,
            backgroundColor: AppColors.background,
            floating: true,
            pinned: true,
            snap: true,
            expandedHeight: 400,
            // iconTheme: const IconThemeData(
            //   color: AppColors.white,
            // ),
            title: Text(
              'About',
              style: GoogleFonts.dmSans(
                  // color: AppColors.white,
                  ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                children: <Widget>[
                  ClipPath(
                    clipper: HeaderClipper(
                      avatarRadius: 0,
                    ),
                    child: CustomPaint(
                      size: const Size.fromHeight(325),
                      painter: HeaderPainter(
                        color: AppColors.primaryColor,
                        avatarRadius: 0,
                      ),
                    ),
                  ),
                  Image.asset(AppAssets.appBarBg),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(AppAssets.logoSvg),
                        const SizedBox(height: 8),
                        Text(
                          'CYCLE FOR LISBON',
                          style: GoogleFonts.dmSans(
                            color: AppColors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 39),
                        Icon(
                          Icons.keyboard_arrow_down,
                          color: AppColors.silvery.withOpacity(0.50),
                          size: 40,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          SliverFillRemaining(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
                color: AppColors.background,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
