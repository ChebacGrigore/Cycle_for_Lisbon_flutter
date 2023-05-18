import 'package:cfl/shared/app_bar_clip.dart';

import 'package:cfl/view/styles/styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HelpCenter extends StatefulWidget {
  const HelpCenter({this.showAppBar = true, super.key});
  final bool showAppBar;
  @override
  State<HelpCenter> createState() => _HelpCenterState();
}

class _HelpCenterState extends State<HelpCenter> {
  ScrollController scrollController = ScrollController();
  Color appbarColor = AppColors.white;

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      setState(
        () {
          if (scrollController.offset > 100) {
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
              'help_center'.tr(),
              style: GoogleFonts.dmSans(
                color: appbarColor,
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(children: const <Widget>[
                MyArc(
                  diameter: double.infinity,
                  color: AppColors.primaryColor,
                )
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
                      icon: CFLIcons.globe_1,
                      title: 'Website',
                      onTap: () {},
                    ),
                    const SizedBox(height: 21),
                    HelpCenterListTile(
                      isPrimary: false,
                      icon: CFLIcons.facebook,
                      title: 'Facebook',
                      onTap: () {},
                    ),
                    const SizedBox(height: 21),
                    HelpCenterListTile(
                      isPrimary: false,
                      icon: CFLIcons.twitter,
                      title: 'Twitter',
                      onTap: () {},
                    ),
                    const SizedBox(height: 21),
                    HelpCenterListTile(
                      isPrimary: false,
                      icon: CFLIcons.instagram,
                      title: 'Instagram',
                      onTap: () {},
                    ),
                    const SizedBox(height: 32),
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
    return SizedBox(
      height: 64,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 19),
          // height: 64,
          decoration: BoxDecoration(
            color: isPrimary ? AppColors.secondaryColor : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            border: isPrimary
                ? null
                : Border.all(
                    color: AppColors.primaryColor.withOpacity(0.16),
                  ),
          ),
          child: Center(
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(
                icon,
                color:
                    isPrimary ? AppColors.primaryColor : AppColors.accentColor,
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
      ),
    );
  }
}
