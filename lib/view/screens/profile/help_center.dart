import 'package:cfl/view/screens/profile/profile_settings.dart';
import 'package:cfl/view/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HelpCenter extends StatefulWidget {
  const HelpCenter({super.key});

  @override
  State<HelpCenter> createState() => _HelpCenterState();
}

class _HelpCenterState extends State<HelpCenter> {
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
            expandedHeight: 150,
            iconTheme: const IconThemeData(
              color: AppColors.white,
            ),
            title: Text(
              'Help Center',
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
          SliverFillRemaining(
            child: Padding(
              padding: const EdgeInsets.all(23),
              child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HelpCenterListTile(
                      isPrimary: true,
                      icon: Icons.email,
                      title: 'cyclelisbon@email.com',
                      onTap: () {},
                    ),
                    const SizedBox(height: 21),
                    HelpCenterListTile(
                      isPrimary: false,
                      icon: Icons.web,
                      title: 'Website',
                      onTap: () {},
                    ),
                    const SizedBox(height: 21),
                    HelpCenterListTile(
                      isPrimary: false,
                      icon: Icons.facebook_outlined,
                      title: 'Facebook',
                      onTap: () {},
                    ),
                    const SizedBox(height: 21),
                    HelpCenterListTile(
                      isPrimary: false,
                      icon: Icons.wb_twilight_outlined,
                      title: 'Twitter',
                      onTap: () {},
                    ),
                    const SizedBox(height: 21),
                    HelpCenterListTile(
                      isPrimary: false,
                      icon: Icons.install_desktop,
                      title: 'Instagram',
                      onTap: () {},
                    ),
                    const SizedBox(height: 51),
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
          )
        ],
      ),
    );
  }
}

class HelpCenterListTile extends StatelessWidget {
  const HelpCenterListTile({
    super.key,
    this.isPrimary = false,
    required this.icon,
    required this.title,
    this.onTap,
  });
  final bool isPrimary;
  final IconData icon;
  final String title;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(18),
        // height: 64,
        decoration: BoxDecoration(
          color: isPrimary ? AppColors.secondaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: isPrimary
              ? null
              : Border.all(
                  color: AppColors.greyish,
                ),
        ),
        child: Center(
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Icon(
              icon,
              color: isPrimary ? AppColors.primaryColor : AppColors.accentColor,
            ),
            title: Text(
              title,
              style: GoogleFonts.dmSans(fontSize: 14),
            ),
            trailing: isPrimary
                ? const Icon(
                    Icons.chevron_right_outlined,
                    color: AppColors.primaryColor,
                  )
                : null,
          ),
        ),
      ),
    );
  }
}
