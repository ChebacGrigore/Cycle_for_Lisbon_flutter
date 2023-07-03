import 'package:cfl/bloc/auth/bloc/auth_bloc.dart';
import 'package:cfl/controller/auth/auth.dart';
import 'package:cfl/routes/app_route.dart';
import 'package:cfl/routes/app_route_paths.dart';
import 'package:cfl/shared/buildcontext_ext.dart';
import 'package:cfl/shared/global/global_var.dart';
import 'package:cfl/view/screens/auth/signup.dart';
import 'package:cfl/view/screens/auth/splash.dart';
import 'package:cfl/view/screens/profile/badges.dart';
import 'package:cfl/view/screens/profile/profile_settings.dart';
import 'package:cfl/view/styles/styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
    super.initState();
    context
        .read<AuthBloc>()
        .add(AuthGetProfile(id: currentUser.id, token: accessToken));
  }

  @override
  void dispose() {
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    super.dispose();
  }

  bool isNotify = false;
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
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => appRoutes.pop(),
            ),
            expandedHeight: 330,
            backgroundColor: AppColors.primaryColor,
            iconTheme: const IconThemeData(color: AppColors.white),
            title: Text(
              'my_profile'.tr(),
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
                      BlocConsumer<AuthBloc, AuthState>(
                        listener: (context, state) {
                          if (state.status.isError) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Row(
                                  children: [
                                    const Icon(
                                      Icons.cancel,
                                      color: Colors.red,
                                    ),
                                    Expanded(
                                      child: Text(
                                        state.exception.toString(),
                                        maxLines: 2,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }
                        },
                        builder: (context, state) {
                          return BlocBuilder<AuthBloc, AuthState>(
                            builder: (context, state) {
                              if (state.status.isLoading) {
                                return Column(
                                  children: [
                                    const CircleAvatar(
                                      radius: 45,
                                      backgroundColor: AppColors.white,
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'loading...',
                                      style: GoogleFonts.dmSans(
                                        color: AppColors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'loading...',
                                      style: GoogleFonts.dmSans(
                                        color: AppColors.white,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                );
                              } else if (state.status.isError) {
                                return Column(
                                  children: [
                                    CircleAvatar(
                                      radius: 45,
                                      backgroundColor: AppColors.white,
                                      child: Image.asset(
                                        AppAssets.placeholder,
                                        width: 62,
                                        height: 62,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      '',
                                      style: GoogleFonts.dmSans(
                                        color: AppColors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      '',
                                      style: GoogleFonts.dmSans(
                                        color: AppColors.white,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                );
                              } else if (state.status.isUserProfile) {
                                return Column(
                                  children: [
                                    CircleAvatar(
                                      radius: 45,
                                      backgroundColor: AppColors.white,
                                      backgroundImage: NetworkImage(
                                        state.profilePic!,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      state.user!.name,
                                      style: GoogleFonts.dmSans(
                                        color: AppColors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      state.user!.email,
                                      style: GoogleFonts.dmSans(
                                        color: AppColors.white,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                );
                              } else if (state.status.isProfilePicture) {
                                return Column(
                                  children: [
                                    CircleAvatar(
                                      radius: 45,
                                      backgroundColor: AppColors.white,
                                      backgroundImage: NetworkImage(
                                        state.profilePic!,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      state.user!.name,
                                      style: GoogleFonts.dmSans(
                                        color: AppColors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      state.user!.email,
                                      style: GoogleFonts.dmSans(
                                        color: AppColors.white,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                );
                              }
                              return Column(
                                children: [
                                  CircleAvatar(
                                    radius: 40,
                                    backgroundColor: AppColors.white,
                                    child: SizedBox(
                                      child: Image.asset(AppAssets.placeholder),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    '',
                                    style: GoogleFonts.dmSans(
                                      color: AppColors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '',
                                    style: GoogleFonts.dmSans(
                                      color: AppColors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                      const SizedBox(height: 37),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 90,
                            child: ProfileActivityCount(
                              unit: '',
                              count: currentUser.tripCount,
                              title: 'total_rides'.tr(),
                              icon: Icons.access_time_outlined,
                            ),
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
                          SizedBox(
                            width: 90,
                            child: ProfileActivityCount(
                              unit: '',
                              count: currentUser.totalDist.round(),
                              title: 'total_km'.tr(),
                              icon: CFLIcons.roadhz,
                            ),
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
                          SizedBox(
                            width: 90,
                            child: ProfileActivityCount(
                              unit: '',
                              count: currentUser.credits.round(),
                              title: 'total_donations'.tr(),
                              icon: CFLIcons.coin1,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  padding: const EdgeInsets.only(
                    top: 53,
                    right: 20,
                    left: 20,
                    bottom: 63,
                  ),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                    color: AppColors.white,
                  ),
                  child: SingleChildScrollView(
                    physics: const NeverScrollableScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppListTile(
                          title: 'profile_settings'.tr(),
                          icon: AppAssets.settings,
                          onTap: () {
                            context.push(const ProfileSettings());
                          },
                          trailing: const Icon(Icons.chevron_right_outlined),
                        ),
                        const Divider(),
                        AppListTile(
                          title: 'badges'.tr(),
                          icon: AppAssets.badges,
                          onTap: () {
                            context.push(const BadgesScreen());
                          },
                          trailing: const Icon(Icons.chevron_right_outlined),
                        ),
                        const Divider(),
                        AppListTile(
                          title: 'leaderboard'.tr(),
                          icon: AppAssets.crown3,
                          onTap: () {
                            appRoutes.go(AppRoutePath.leaderBoard);
                          },
                          trailing: const Icon(Icons.chevron_right_outlined),
                        ),
                        const Divider(),
                        AppListTile(
                          title: 'trip_history'.tr(),
                          icon: AppAssets.roadHz,
                          onTap: () {
                            appRoutes.push(AppRoutePath.tripHistory);
                          },
                          trailing: const Icon(Icons.chevron_right_outlined),
                        ),
                        const Divider(),
                        AppListTile(
                          title: 'help_center'.tr(),
                          icon: AppAssets.help,
                          onTap: () {
                            appRoutes.push(AppRoutePath.helpCenter);
                          },
                          trailing: const Icon(Icons.chevron_right_outlined),
                        ),
                        const Divider(),
                        AppListTile(
                          title: 'about'.tr(),
                          icon: AppAssets.info,
                          onTap: () {
                            appRoutes.push(AppRoutePath.about);
                          },
                          trailing: const Icon(Icons.chevron_right_outlined),
                        ),
                        // const Divider(),
                        // AppListTile(
                        //   title: 'notifications'.tr(),
                        //   icon: AppAssets.bell,
                        //   onTap: () {},
                        //   trailing: Switch(
                        //     onChanged: (val) {
                        //       setState(() {
                        //         isNotify = val;
                        //       });
                        //     },
                        //     value: isNotify,
                        //     trackColor:
                        //         MaterialStateProperty.resolveWith<Color>(
                        //             (Set<MaterialState> states) {
                        //       if (states.contains(MaterialState.disabled)) {
                        //         return AppColors.greyish.withOpacity(.48);
                        //       }
                        //       return AppColors.greyish;
                        //     }),
                        //     thumbColor:
                        //         MaterialStateProperty.resolveWith<Color>(
                        //             (Set<MaterialState> states) {
                        //       if (states.contains(MaterialState.disabled)) {
                        //         return AppColors.accentColor.withOpacity(.48);
                        //       }
                        //       return AppColors.accentColor;
                        //     }),
                        //   ),
                        // ),
                        const Divider(),
                        AppListTile(
                          title: 'log_out'.tr(),
                          icon: AppAssets.exit,
                          onTap: () {
                            context.showAppDialog(AppDialog(
                              icon: Icons.logout_outlined,
                              acceptTitle: 'yes_logout'.tr(),
                              declineTitle: 'no_delete'.tr(),
                              title: 'sure_logout'.tr(),
                              description: 'logout_desc'.tr(),
                              onAccept: () async {
                                await auth.clearLocalStorage();
                                context.push(const SplashScreen());
                              },
                              onDecline: () {
                                context.pop();
                              },
                            ));
                          },
                        ),
                        const Divider(),
                        AppListTile(
                          title: 'delete_account'.tr(),
                          icon: AppAssets.delete,
                          color: AppColors.tomatoRed,
                          onTap: () {
                            context.showAppDialog(
                              AppDialog(
                                icon: Icons.delete_outline_rounded,
                                acceptTitle: 'yes_delete'.tr(),
                                declineTitle: 'no_delete'.tr(),
                                title: 'sure_delete_account'.tr(),
                                description: 'delete_acount_desc'.tr(),
                                onAccept: () {
                                  context.popUntil(const SignUp());
                                },
                                onDecline: () {
                                  context.pop();
                                },
                              ),
                            );
                          },
                        ),
                        const Divider(),
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
  final String icon;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        onTap: onTap,
        title: Row(
          children: [
            SvgPicture.asset(
              icon,
              width: 20,
              height: 20,
              // ignore: deprecated_member_use
              color: color ?? AppColors.accentColor,
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: GoogleFonts.dmSans(
                fontSize: 14,
                color: color ?? AppColors.primaryColor,
              ),
            ),
          ],
        ),
        trailing: trailing,
      ),
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
  final dynamic count;
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
          size: 17,
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
            fontSize: 10,
          ),
        ),
      ],
    );
  }
}

class AppDialog extends StatelessWidget {
  const AppDialog(
      {this.icon,
      required this.acceptTitle,
      required this.declineTitle,
      required this.title,
      this.description,
      this.onAccept,
      this.onDecline,
      super.key});
  final IconData? icon;
  final VoidCallback? onAccept;
  final VoidCallback? onDecline;
  final String acceptTitle;
  final String declineTitle;
  final String title;
  final String? description;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: MediaQuery.of(context).size.height * 0.1,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.white,
      ),
      child: Material(
        color: AppColors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 45,
              backgroundColor: AppColors.tertiaryColor,
              child: Icon(
                icon ?? Icons.info_outline,
                color: AppColors.primaryColor,
                size: 30,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              title,
              textAlign: TextAlign.center,
              style: GoogleFonts.dmSans(
                fontWeight: FontWeight.w500,
                fontSize: 22,
                color: AppColors.primaryColor,
              ),
            ),
            const SizedBox(height: 14),
            Text(
              description ?? '',
              textAlign: TextAlign.center,
              style: GoogleFonts.dmSans(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: AppColors.primaryColor.withOpacity(0.80),
              ),
            ),
            const SizedBox(height: 45),
            SizedBox(
              width: double.infinity,
              height: 49,
              child: OutlinedButton(
                style: AppComponentThemes.outlinedButtonTheme(
                  color: AppColors.black,
                  borderColor: AppColors.secondaryColor,
                ),
                onPressed: onAccept,
                child: Text(
                  acceptTitle,
                  style: GoogleFonts.dmSans(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 49,
              child: ElevatedButton(
                style: AppComponentThemes.elevatedButtonTheme(
                  color: AppColors.secondaryColor,
                  borderColor: Colors.transparent,
                ),
                onPressed: onDecline,
                child: Text(
                  declineTitle,
                  style: GoogleFonts.dmSans(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
