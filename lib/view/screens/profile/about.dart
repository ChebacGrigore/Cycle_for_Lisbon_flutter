import 'package:cfl/shared/app_bar_clip.dart';

import 'package:cfl/view/styles/styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
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
            foregroundColor: appbarColor,
            backgroundColor: AppColors.background,
            floating: true,
            pinned: true,
            snap: true,
            centerTitle: true,
            expandedHeight: 290,
            title: Text(
              'about'.tr(),
              style: GoogleFonts.dmSans(),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                children: <Widget>[
                  const MyArc(
                    diameter: double.infinity,
                  ),
                  Image.asset(AppAssets.appBarBg),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 150),
                        SvgPicture.asset(AppAssets.logoSvg),
                        const SizedBox(height: 6),
                        Text(
                          'CYCLE FOR LISBON',
                          style: GoogleFonts.dmSans(
                            color: AppColors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 39),
                        SvgPicture.asset(
                          AppAssets.aboutArrow,
                          height: 13,
                          width: 6,
                          color: AppColors.silvery.withOpacity(0.50),
                        ),
                        const SizedBox(height: 17),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                    color: AppColors.background,
                  ),
                  child: SingleChildScrollView(
                    physics: const NeverScrollableScrollPhysics(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'about_desc'.tr(),
                          textAlign: TextAlign.start,
                          style: GoogleFonts.dmSans(
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 42),
                        Text(
                          '${'developed_by'.tr()}: ',
                          style: GoogleFonts.dmSans(),
                        ),
                        const SizedBox(height: 24),
                        Image.asset(
                          AppAssets.p1,
                          width: 154,
                          height: 32,
                        ),
                        const SizedBox(height: 32),
                        const Divider(),
                        const SizedBox(height: 32),
                        Text(
                          '${'project'.tr()}: ',
                          style: GoogleFonts.dmSans(),
                        ),
                        const SizedBox(height: 24),
                        Image.asset(
                          AppAssets.p2,
                          width: 150,
                          height: 32,
                        ),
                        const SizedBox(height: 32),
                        const Divider(),
                        const SizedBox(height: 32),
                        Text(
                          '${'co_financed'.tr()}: ',
                          style: GoogleFonts.dmSans(),
                        ),
                        const SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset(
                              AppAssets.p5,
                              width: 90,
                              height: 32,
                            ),
                            const SizedBox(width: 32),
                            Image.asset(
                              AppAssets.p3,
                              width: 90,
                              height: 32,
                            ),
                            // const SizedBox(width: 32),
                            Image.asset(
                              AppAssets.p4,
                              width: 90,
                              height: 32,
                            ),
                          ],
                        ),
                        const SizedBox(height: 32),
                        const Divider(),
                        TextButton(
                          onPressed: ()  async{
                            await launchUrl(Uri.parse('https://dashboard.cycleforlisbon.com/policy'));
                          },
                          child: Text(
                            'privacy_GDPR'.tr(),
                            style: GoogleFonts.dmSans(
                              color: AppColors.primaryColor,
                              decoration: TextDecoration.underline,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        // const SizedBox(height: 20),
                        TextButton(
                          onPressed: () async{
                            await launchUrl(Uri.parse('https://dashboard.cycleforlisbon.com/terms-conditions'));
                          },
                          child: Text(
                            'terms_condition'.tr(),
                            style: GoogleFonts.dmSans(
                              color: AppColors.primaryColor,
                              decoration: TextDecoration.underline,
                              fontSize: 14,
                            ),
                          ),
                        )
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
