import 'package:cfl/bloc/trip/bloc/trip_bloc.dart';
import 'package:cfl/bloc/trip/bloc/trip_state.dart';
import 'package:cfl/shared/app_bar_clip.dart';
import 'package:cfl/shared/buildcontext_ext.dart';
import 'package:cfl/shared/global/global_var.dart';
import 'package:cfl/view/screens/profile/trip_history_map.dart';
import 'package:cfl/view/styles/styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class TripHistoryScreen extends StatefulWidget {
  const TripHistoryScreen({super.key});

  @override
  State<TripHistoryScreen> createState() => _TripHistoryScreenState();
}

class _TripHistoryScreenState extends State<TripHistoryScreen> {
  @override
  void initState() {
    context.read<TripBloc>().add(AppListOfTrips(token: accessToken));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(gradient: AppColors.whiteBgGradient),
        child: CustomScrollView(
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
                'trip_history'.tr(),
                style: GoogleFonts.dmSans(
                  color: AppColors.white,
                ),
              ),
              flexibleSpace: const FlexibleSpaceBar(
                background: MyArc(
                  color: AppColors.primaryColor,
                ),
              ),
            ),
            SliverFillRemaining(
              child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: DefaultTabController(
                    length: 3,
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: AppColors.tertiaryColor,
                            ),
                            child: TabBar(
                              labelStyle: GoogleFonts.dmSans(
                                fontSize: 13,
                              ),
                              unselectedLabelColor: AppColors.primaryColor,
                              indicator: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: AppColors.secondaryColor,
                              ),
                              tabs: [
                                Tab(
                                  text: 'for_all_time'.tr(),
                                ),
                                Tab(
                                  text: 'this_week'.tr(),
                                ),
                                Tab(
                                  text: 'this_month'.tr(),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: PageView(
                              children: List.generate(
                                  3, (index) => const TripHistoryItem()),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

class TripHistoryItem extends ConsumerWidget {
  const TripHistoryItem({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BlocConsumer<TripBloc, TripState>(
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
        return BlocBuilder<TripBloc, TripState>(
          builder: (context, state) {
            print(state.status);
            if (state.status.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state.status.isError) {
              return Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      AppAssets.empty,
                      height: 150,
                    ),
                    const Center(
                      child: Text(
                        'No Trip history added yet!',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17),
                      ),
                    ),
                  ],
                ),
              );
            } else if (state.status.isAllTrips) {
              print(state.status.isAllTrips);
              state.trips!.isEmpty
                  ? Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            AppAssets.empty,
                            height: 150,
                          ),
                          const Center(
                            child: Text(
                              'No Initiative added yet!',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 17),
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.separated(
                      itemCount: state.trips!.length,
                      itemBuilder: (ctx, idx) {
                        return ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'initiative_name'.tr(),
                                style: GoogleFonts.dmSans(
                                  fontSize: 16,
                                  color: AppColors.primaryColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                '${state.trips![idx].createdAt.month} ${state.trips![idx].createdAt.day}, ${state.trips![idx].createdAt.year}',
                                style: GoogleFonts.dmSans(
                                  fontSize: 12,
                                  color:
                                      AppColors.primaryColor.withOpacity(0.60),
                                ),
                              ),
                            ],
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const SizedBox(height: 10),
                              const Row(
                                children: [
                                  TripHistoryInfo(
                                    icon: Icons.location_on_outlined,
                                    text: '3605 Parker Rd.',
                                  ),
                                  SizedBox(width: 10),
                                  Icon(
                                    Icons.arrow_forward,
                                    size: 19,
                                    color: AppColors.accentColor,
                                  ),
                                  SizedBox(width: 10),
                                  TripHistoryInfo(
                                    icon: Icons.flag,
                                    text: '3890 Poplar Dr.',
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 100,
                                child: TextButton(
                                  onPressed: () {
                                    context.push(const TripMapScreen());
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      const Icon(Icons.map, size: 15),
                                      const SizedBox(width: 6),
                                      Text(
                                        'see_map'.tr(),
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.dmSans(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.primaryColor,
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (ctx, idx) {
                        return const Divider();
                      },
                    );
            }
            return ListView.separated(
              itemCount: state.trips!.length,
              itemBuilder: (ctx, idx) {
                return ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'initiative_name'.tr(),
                        style: GoogleFonts.dmSans(
                          fontSize: 16,
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        '${state.trips![idx].createdAt.month} ${state.trips![idx].createdAt.day}, ${state.trips![idx].createdAt.year}',
                        style: GoogleFonts.dmSans(
                          fontSize: 12,
                          color: AppColors.primaryColor.withOpacity(0.60),
                        ),
                      ),
                    ],
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const SizedBox(height: 10),
                      const Row(
                        children: [
                          TripHistoryInfo(
                            icon: Icons.location_on_outlined,
                            text: '3605 Parker Rd.',
                          ),
                          SizedBox(width: 10),
                          Icon(
                            Icons.arrow_forward,
                            size: 19,
                            color: AppColors.accentColor,
                          ),
                          SizedBox(width: 10),
                          TripHistoryInfo(
                            icon: Icons.flag,
                            text: '3890 Poplar Dr.',
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 100,
                        child: TextButton(
                          onPressed: () {
                            context.push(const TripMapScreen());
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Icon(Icons.map, size: 15),
                              const SizedBox(width: 6),
                              Text(
                                'see_map'.tr(),
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.dmSans(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.primaryColor,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (ctx, idx) {
                return const Divider();
              },
            );
          },
        );
      },
    );
  }
}

class TripHistoryInfo extends StatelessWidget {
  const TripHistoryInfo({
    super.key,
    required this.icon,
    required this.text,
  });
  final IconData icon;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: AppColors.black,
            size: 18,
          ),
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.dmSans(
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
