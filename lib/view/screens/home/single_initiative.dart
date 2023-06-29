import 'package:cfl/models/initiative.model.dart';
import 'package:cfl/routes/app_route.dart';
import 'package:cfl/routes/app_route_paths.dart';
import 'package:cfl/shared/global/global_var.dart';
import 'package:cfl/view/screens/home/home_screen.dart';
import 'package:cfl/view/styles/styles.dart';
import 'package:cfl/view/widgets/widgets.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../bloc/app/bloc/app_bloc.dart';
import '../../../shared/configs/url_config.dart';

class SingleInitiative extends StatefulWidget {
  final Initiative initiative;
  const SingleInitiative({super.key, required this.initiative});

  @override
  State<SingleInitiative> createState() => _SingleInitiativeState();
}

class _SingleInitiativeState extends State<SingleInitiative> {
  List<Widget> sdgs = [];
  List<Widget> sponsors = [];
  bool isFullDesc = false;
  bool isLoading = false;
  bool isFullInstNameDesc = false;
  ScrollController scrollController = ScrollController();
  Color appbarColor = AppColors.white;
  @override
  void initState() {
    super.initState();
    print(widget.initiative.sponsors);
    sdgs = widget.initiative.sdgs!
        .map((e) => Container(
            margin: const EdgeInsets.only(left: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
            ),
            width: 48,
            height: 48,
            child: ActivityBadge('$domain${e.imageUri}')))
        .toList();
    sponsors = widget.initiative.sponsors!
        .map((e) => Container(
            margin: const EdgeInsets.only(right: 30),
            child: Image.network(
              e.presignedLogoUrl,
              width: 80,
              height: 80,
            )))
        .toList();
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
      body: BlocConsumer<AppBloc, AppState>(
        listener: (context, state) {
          if (state.status.isError) {
            setState(() {
              isLoading = false;
            });
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
          } else if (state.status.isLoading) {
            setState(() {
              isLoading = true;
            });
          } else if (state.status.isSupportInitiative) {
            setState(() {
              isLoading = false;
            });
            appRoutes.pushReplacement(AppRoutePath.home);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Row(
                  children: [
                    Icon(
                      Icons.done,
                      color: Colors.green,
                    ),
                    Expanded(
                      child: Text(
                        "Initiative Supported",
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
          return Container(
            height: MediaQuery.of(context).size.height,
            decoration:
                const BoxDecoration(gradient: AppColors.whiteBg2Gradient),
            child: CustomScrollView(
              controller: scrollController,
              slivers: [
                SliverAppBar(
                  foregroundColor: appbarColor,
                  backgroundColor: AppColors.white,
                  floating: true,
                  pinned: true,
                  centerTitle: true,
                  snap: true,
                  expandedHeight: 350,
                  title: Text(
                    widget.initiative.title,
                    style: GoogleFonts.dmSans(),
                  ),
                  flexibleSpace: FlexibleSpaceBar(
                    background: ClipRRect(
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15)),
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                              widget.initiative.presignedImageUrl ??
                                  'https://cutewallpaper.org/24/image-placeholder-png/croppedplaceholderpng-%E2%80%93-osa-grappling.png',
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Container(
                          color: AppColors.black.withOpacity(0.3),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                InitiativeProgress(
                                  progress: widget.initiative.credits == 0
                                      ? 0
                                      : (widget.initiative.credits /
                                          widget.initiative.goal),
                                  goal: widget.initiative.goal,
                                  collected: widget.initiative.credits,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 32),
                        child: SingleChildScrollView(
                          physics: const NeverScrollableScrollPhysics(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${'sustainable_development_goals'.tr()}:',
                                style: GoogleFonts.dmSans(
                                  color: AppColors.primaryColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(height: 14),
                              Row(
                                children: sdgs,
                              ),
                              const SizedBox(height: 42),
                              Text(
                                '${'about_initiative'.tr()}:',
                                style: GoogleFonts.dmSans(
                                  color: AppColors.primaryColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(height: 14),
                              Text(
                                widget.initiative.description,
                                overflow: TextOverflow.ellipsis,
                                maxLines: isFullDesc == true ? 1000 : 5,
                                style: GoogleFonts.dmSans(
                                  color:
                                      AppColors.primaryColor.withOpacity(0.4),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                ),
                              ),
                              // const SizedBox(height: 16),
                              TextButton.icon(
                                onPressed: () {
                                  isFullDesc = !isFullDesc;
                                  setState(() {});
                                },
                                icon: Text(isFullDesc == true
                                    ? 'Read Less'
                                    : 'Read More'),
                                label: Icon(
                                  isFullDesc == true
                                      ? Icons.arrow_upward
                                      : Icons.arrow_downward,
                                  size: 15,
                                ),
                              ),
                              const SizedBox(height: 42),
                              Text(
                                widget.initiative.institution.name,
                                style: GoogleFonts.dmSans(
                                  color: AppColors.primaryColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(height: 14),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: AppColors.tertiaryColor,
                                ),
                                width: double.infinity,
                                height: 140,
                                child: Center(
                                  child: Image.network(widget.initiative
                                          .institution.presignedLogoUrl ??
                                      'https://cutewallpaper.org/24/image-placeholder-png/croppedplaceholderpng-%E2%80%93-osa-grappling.png'),
                                ),
                              ),
                              const SizedBox(height: 16),
                              Opacity(
                                opacity: 0.5,
                                child: Text(
                                  widget.initiative.institution.description,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines:
                                      isFullInstNameDesc == true ? 1000 : 5,
                                  style: GoogleFonts.dmSans(
                                    color: AppColors.primaryColor,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              // const SizedBox(height: 16),
                              TextButton.icon(
                                onPressed: () {
                                  isFullInstNameDesc = !isFullInstNameDesc;
                                  setState(() {});
                                },
                                icon: Text(
                                  isFullInstNameDesc == true
                                      ? 'Read Less'
                                      : 'Read More',
                                ),
                                label: Icon(
                                  isFullInstNameDesc == true
                                      ? Icons.arrow_upward
                                      : Icons.arrow_downward,
                                  size: 15,
                                ),
                              ),
                              const SizedBox(height: 42),
                              const Divider(
                                thickness: 0.2,
                                color: AppColors.primaryColor,
                              ),
                              const SizedBox(height: 42),
                              Text(
                                '${'sponsors'.tr()}:',
                                style: GoogleFonts.dmSans(
                                  color: AppColors.primaryColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: sponsors,
                              ),
                              const SizedBox(height: 42),
                              SizedBox(
                                width: double.infinity,
                                height: 49,
                                child: ElevatedButton(
                                  style:
                                      AppComponentThemes.elevatedButtonTheme(),
                                  onPressed: isLoading == true
                                      ? () {}
                                      : () {
                                          context.read<AppBloc>().add(
                                              AppSupportInitiative(
                                                  token: accessToken,
                                                  userProfile: currentUser,
                                                  userId: currentUser.id,
                                                  initiativeId:
                                                      widget.initiative.id));
                                        },
                                  child: isLoading == true
                                      ? const CircularProgressIndicator()
                                      : Text(
                                          'support_initiative'.tr(),
                                          style: GoogleFonts.dmSans(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                          ),
                                        ),
                                ),
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
        },
      ),
    );
  }
}
