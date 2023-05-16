import 'package:cfl/view/screens/profile/profile_settings.dart';
import 'package:cfl/view/styles/styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

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
            expandedHeight: 250,
            title: Text(
              'about'.tr(),
              style: GoogleFonts.dmSans(),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                children: <Widget>[
                  ClipPath(
                    clipper: HeaderClipper(
                      avatarRadius: 0,
                    ),
                    child: CustomPaint(
                      size: const Size.fromHeight(300),
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
                        const SizedBox(height: 100),
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
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  padding: const EdgeInsets.all(16),
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
                          '''Lorem ipsum dolor sit amet consectetur. Aliquam vulputate massa id lacus gravida enim pretium sit. Sollicitudin fermentum duis ullamcorper gravida enim phasellus consectetur. Sapien sed varius fermentum dictumst varius pellentesque. Dui aliquam feugiat enim lectus. 

Maecenas magna orci ut sit ultricies. Imperdiet neque libero at euismod. Tincidunt ut ac nibh amet posuere non nisl. Enim at dui in et ullamcorper. Risus tempus rhoncus tristique aliquam interdum. 

Elit mattis consectetur ullamcorper consectetur feugiat tempor aliquam sed tortor. Pellentesque vel cras nunc quis volutpat dictumst mauris. Scelerisque leo id eu nunc pretium viverra. Ornare id diam sagittis in ornare hendrerit dolor leo. Nec amet non mauris tincidunt mauris eget mauris.''',
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
                          width: 150,
                          height: 32,
                        ),
                        const SizedBox(height: 32),
                        const Divider(),
                        const SizedBox(height: 42),
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
                        const SizedBox(height: 42),
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
                        // const SizedBox(height: 51),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            'privacy_GDPR'.tr(),
                            style: GoogleFonts.dmSans(
                              color: AppColors.primaryColor,
                              decoration: TextDecoration.underline,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextButton(
                          onPressed: () {},
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
