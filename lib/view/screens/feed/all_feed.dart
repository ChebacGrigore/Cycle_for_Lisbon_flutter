import 'package:cfl/bloc/app/bloc/app_bloc.dart';
import 'package:cfl/shared/global/global_var.dart';
import 'package:cfl/shared/shared.dart';
import 'package:cfl/view/screens/feed/single_event.dart';
import 'package:cfl/view/screens/feed/single_news_feed.dart';
import 'package:cfl/view/styles/assets.dart';
import 'package:cfl/view/styles/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class AllFeedScreen extends ConsumerStatefulWidget {
  const AllFeedScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AllFeedScreenState();
}

class _AllFeedScreenState extends ConsumerState<AllFeedScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AppBloc>().add(AppNews(token: accessToken));
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          backgroundColor: AppColors.background,
          elevation: 0,
          automaticallyImplyLeading: false,
          centerTitle: false,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(115),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 54.0,
                    left: 20,
                    bottom: 20,
                  ),
                  child: Text(
                    'news_event'.tr(),
                    style: GoogleFonts.dmSans(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    bottom: 5,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: AppColors.tertiaryColor,
                  ),
                  child: Column(
                    children: [
                      TabBar(
                        onTap: (val) {
                          if (val == 0) {
                            context
                                .read<AppBloc>()
                                .add(AppNews(token: accessToken));
                          } else if (val == 1) {
                            context
                                .read<AppBloc>()
                                .add(AppEvents(token: accessToken));
                          }
                        },
                        unselectedLabelColor: AppColors.primaryColor,
                        indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: AppColors.secondaryColor),
                        tabs: [
                          Tab(
                            text: 'news'.tr(),
                          ),
                          Tab(
                            text: 'events'.tr(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        body: BlocConsumer<AppBloc, AppState>(
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
            return Container(
              decoration: const BoxDecoration(
                color: AppColors.background,
                gradient: AppColors.whiteBg2Gradient,
              ),
              child: const TabBarView(
                children: [
                  NewsFeeds(),
                  EventsFeed(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class NewsFeeds extends ConsumerStatefulWidget {
  const NewsFeeds({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _NewsFeedsState();
}

class _NewsFeedsState extends ConsumerState<NewsFeeds> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
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
                    'No News added yet!',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                ),
              ],
            ),
          );
        } else if (state.status.isNews) {
          return state.news!.isNotEmpty
              ? SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: ListView.builder(
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                      bottom: 120,
                    ),
                    itemCount: state.news.length,
                    itemBuilder: (context, index) {
                      final news = state.news[index];
                      final dateFormat = DateFormat('MMMM d, yyyy');
                      return GestureDetector(
                        onTap: () async {
                          await launchUrl(Uri.parse(news.articleUrl));
                        },
                        child: Container(
                          // height: 380,
                          width: double.infinity,
                          margin: const EdgeInsets.only(bottom: 16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: AppColors.background,
                            border: Border.all(
                              color: AppColors.tertiaryColor,
                              width: 1.5,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  topRight: Radius.circular(12),
                                ),
                                child: Image.network(
                                  news.imageUrl,
                                  height: 160,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, object, stackTrace) =>
                                      SizedBox(
                                    height: 185,
                                    width: double.infinity,
                                    child: Image.asset(AppAssets.placeholder),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      // '${'mar'.tr()} 13, 2023',
                                      dateFormat.format(news.date),
                                      style: GoogleFonts.dmSans(
                                        fontSize: 12,
                                        color: AppColors.primaryColor
                                            .withOpacity(0.60),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      news.title,
                                      style: GoogleFonts.dmSans(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.primaryColor,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      news.subtitle,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 4,
                                      style: GoogleFonts.dmSans(
                                        fontSize: 14,
                                        color: AppColors.primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                )
              : Center(
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
                          'No News added yet!',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17),
                        ),
                      ),
                    ],
                  ),
                );
        }
        return SizedBox(
          height: MediaQuery.of(context).size.height,
          child: ListView.builder(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              bottom: 120,
            ),
            itemCount: state.news.length,
            itemBuilder: (context, index) {
              final news = state.news[index];
              final dateFormat = DateFormat('MMMM d, yyyy');
              return GestureDetector(
                onTap: () {
                  context.push(const SingleNewsFeed());
                },
                child: Container(
                  // height: 380,
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: AppColors.background,
                    border: Border.all(
                      color: AppColors.tertiaryColor,
                      width: 1.5,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                        ),
                        child: Image.network(
                          news.imageUrl,
                          height: 160,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              dateFormat.format(news.date),
                              style: GoogleFonts.dmSans(
                                fontSize: 12,
                                color: AppColors.primaryColor.withOpacity(0.60),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              news.title,
                              style: GoogleFonts.dmSans(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primaryColor,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              news.subtitle,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 4,
                              style: GoogleFonts.dmSans(
                                fontSize: 14,
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class EventsFeed extends ConsumerStatefulWidget {
  const EventsFeed({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EventsFeedState();
}

class _EventsFeedState extends ConsumerState<EventsFeed> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
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
                    'No Events added yet!',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                ),
              ],
            ),
          );
        } else if (state.status.isEvents) {
          state.events.isNotEmpty
              ? ListView.builder(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    bottom: 120,
                  ),
                  itemCount: state.events.length,
                  itemBuilder: (context, index) {
                    final event = state.events[index];
                    return GestureDetector(
                      onTap: () async {
                        await launchUrl(Uri.parse(event.articleUrl));
                        // context.push(const SingleEventFeed());
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: AppColors.background,
                          border: Border.all(
                            color: AppColors.tertiaryColor,
                            width: 1.5,
                          ),
                        ),
                        height: 333,
                        width: double.infinity,
                        margin: const EdgeInsets.only(bottom: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12),
                              ),
                              child: Image.network(
                                event.imageUrl,
                                height: 160,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    event.period,
                                    style: GoogleFonts.dmSans(
                                      fontSize: 12,
                                      color: AppColors.primaryColor
                                          .withOpacity(0.60),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    event.title,
                                    style: GoogleFonts.dmSans(
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal,
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    event.subtitle,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 4,
                                    style: GoogleFonts.dmSans(
                                      fontSize: 14,
                                      color: AppColors.primaryColor
                                          .withOpacity(0.80),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Row(
                                    children: [
                                      Row(
                                        children: [
                                          const Icon(Icons.access_time,
                                              color: AppColors.accentColor),
                                          const SizedBox(width: 6),
                                          Text(
                                            '12:00 pm',
                                            style: GoogleFonts.dmSans(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(width: 17),
                                      Flexible(
                                        child: Row(
                                          children: [
                                            const Icon(
                                                Icons.location_on_outlined,
                                                color: AppColors.accentColor),
                                            const SizedBox(width: 6),
                                            Flexible(
                                              child: Text(
                                                'Elgin St. Celina, Delaware',
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                style: GoogleFonts.dmSans(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                )
              : Center(
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
                          'No Events added yet!',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17),
                        ),
                      ),
                    ],
                  ),
                );
        }
        return ListView.builder(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            bottom: 120,
          ),
          itemCount: state.events.length,
          itemBuilder: (context, index) {
            final event = state.events[index];
            return GestureDetector(
              onTap: () async {
                await launchUrl(Uri.parse(event.articleUrl));
                // context.push(const SingleEventFeed());
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppColors.background,
                  border: Border.all(
                    color: AppColors.tertiaryColor,
                    width: 1.5,
                  ),
                ),
                height: 333,
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                      child: Image.network(
                        event.imageUrl,
                        height: 160,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            event.period,
                            style: GoogleFonts.dmSans(
                              fontSize: 12,
                              color: AppColors.primaryColor.withOpacity(0.60),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            event.title,
                            style: GoogleFonts.dmSans(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              color: AppColors.primaryColor,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            event.subtitle,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 4,
                            style: GoogleFonts.dmSans(
                              fontSize: 14,
                              color: AppColors.primaryColor.withOpacity(0.80),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.access_time,
                                      color: AppColors.accentColor),
                                  const SizedBox(width: 6),
                                  Text(
                                    '12:00 pm',
                                    style: GoogleFonts.dmSans(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 17),
                              Flexible(
                                child: Row(
                                  children: [
                                    const Icon(Icons.location_on_outlined,
                                        color: AppColors.accentColor),
                                    const SizedBox(width: 6),
                                    Flexible(
                                      child: Text(
                                        'Elgin St. Celina, Delaware',
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: GoogleFonts.dmSans(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
