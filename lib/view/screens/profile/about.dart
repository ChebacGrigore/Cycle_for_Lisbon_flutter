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
            expandedHeight: 300,
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
                      'Developed by: ',
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
                      'Project: ',
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
                      'Co-financed by: ',
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
                        'Privacy Policy and GDPR',
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
                        'Terms and Conditions',
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
          ),
        ],
      ),
    );
  }
}
