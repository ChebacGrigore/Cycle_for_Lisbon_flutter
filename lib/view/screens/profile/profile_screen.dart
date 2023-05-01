import 'package:cfl/view/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            pinned: true,
            snap: true,
            expandedHeight: 350,
            iconTheme: const IconThemeData(color: AppColors.white),
            title: Text(
              'My Profile',
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
                      AppAssets.appBarBg,
                    ),
                    fit: BoxFit.contain,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const CircleAvatar(
                        radius: 45,
                        backgroundColor: AppColors.white,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Jane Cooper',
                        style: GoogleFonts.dmSans(
                          color: AppColors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'jane@email.com',
                        style: GoogleFonts.dmSans(
                          color: AppColors.white,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 37),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const ProfileActivityCount(
                            unit: 'h',
                            count: 3,
                            title: 'Total Rides',
                            icon: Icons.access_time,
                          ),
                          const SizedBox(width: 6),
                          SizedBox(
                            height: 30,
                            child: VerticalDivider(
                              color: AppColors.white.withOpacity(0.24),
                              thickness: 1,
                            ),
                          ),
                          const SizedBox(width: 6),
                          const ProfileActivityCount(
                            unit: '',
                            count: 3340,
                            title: 'Total km',
                            icon: Icons.access_time,
                          ),
                          const SizedBox(width: 6),
                          SizedBox(
                            height: 30,
                            child: VerticalDivider(
                              color: AppColors.white.withOpacity(0.24),
                              thickness: 1,
                            ),
                          ),
                          const SizedBox(width: 6),
                          const ProfileActivityCount(
                            unit: '',
                            count: 567,
                            title: 'Total Donations',
                            icon: Icons.monetization_on,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
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
                color: AppColors.white,
              ),
              child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppListTile(
                        title: 'Profile Settings',
                        icon: Icons.settings,
                        onTap: () {},
                        trailing: const Icon(Icons.chevron_right_outlined),
                      ),
                      const SizedBox(height: 14),
                      const Divider(),
                      const SizedBox(height: 14),
                      AppListTile(
                        title: 'Badges',
                        icon: Icons.badge,
                        onTap: () {},
                        trailing: const Icon(Icons.chevron_right_outlined),
                      ),
                      const SizedBox(height: 14),
                      const Divider(),
                      const SizedBox(height: 14),
                      AppListTile(
                        title: 'Leaderboard',
                        icon: Icons.leaderboard,
                        onTap: () {},
                        trailing: const Icon(Icons.chevron_right_outlined),
                      ),
                      const SizedBox(height: 14),
                      const Divider(),
                      const SizedBox(height: 14),
                      AppListTile(
                        title: 'Trip Histoy',
                        icon: Icons.history,
                        onTap: () {},
                        trailing: const Icon(Icons.chevron_right_outlined),
                      ),
                      const SizedBox(height: 14),
                      const Divider(),
                      const SizedBox(height: 14),
                      AppListTile(
                        title: 'Help Center',
                        icon: Icons.help_center_sharp,
                        onTap: () {},
                        trailing: const Icon(Icons.chevron_right_outlined),
                      ),
                      const SizedBox(height: 14),
                      const Divider(),
                      const SizedBox(height: 14),
                      AppListTile(
                        title: 'About',
                        icon: Icons.info_outline,
                        onTap: () {},
                        trailing: const Icon(Icons.chevron_right_outlined),
                      ),
                      const SizedBox(height: 14),
                      const Divider(),
                      const SizedBox(height: 14),
                      AppListTile(
                        title: 'Notifications',
                        icon: Icons.notifications_none_sharp,
                        onTap: () {},
                        trailing: Switch(
                          onChanged: (val) {},
                          value: true,
                          trackColor: MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                            if (states.contains(MaterialState.disabled)) {
                              return AppColors.greyish.withOpacity(.48);
                            }
                            return AppColors.greyish;
                          }),
                          thumbColor: MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                            if (states.contains(MaterialState.disabled)) {
                              return AppColors.accentColor.withOpacity(.48);
                            }
                            return AppColors.accentColor;
                          }),
                        ),
                      ),
                      const SizedBox(height: 14),
                      const Divider(),
                      const SizedBox(height: 14),
                      AppListTile(
                        title: 'Logout',
                        icon: Icons.exit_to_app,
                        onTap: () {},
                      ),
                      const SizedBox(height: 14),
                      const Divider(),
                      const SizedBox(height: 14),
                      AppListTile(
                        title: 'Delete Account',
                        icon: Icons.delete_outlined,
                        color: AppColors.tomatoRed,
                        onTap: () {},
                      ),
                    ]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AppListTile extends StatelessWidget {
  const AppListTile({
    super.key,
    required this.icon,
    required this.title,
    this.onTap,
    this.trailing,
    this.color,
  });
  final VoidCallback? onTap;
  final Widget? trailing;
  final String title;
  final IconData icon;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(
        icon,
        color: color ?? AppColors.accentColor,
      ),
      title: Text(
        title,
        style: GoogleFonts.dmSans(
          fontSize: 14,
          color: color ?? AppColors.primaryColor,
        ),
      ),
      trailing: trailing,
    );
  }
}

class ProfileActivityCount extends StatelessWidget {
  const ProfileActivityCount({
    super.key,
    required this.count,
    required this.unit,
    required this.icon,
    required this.title,
  });
  final IconData icon;
  final String unit;
  final int count;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: AppColors.accentColor,
        ),
        const SizedBox(height: 4),
        Text(
          '$count $unit',
          style: GoogleFonts.dmSans(
            fontWeight: FontWeight.w700,
            color: AppColors.white,
            fontSize: 20,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: GoogleFonts.dmSans(
            fontWeight: FontWeight.w400,
            color: AppColors.white.withOpacity(0.50),
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
