import 'package:cfl/shared/shared.dart';
import 'package:cfl/view/screens/feed/single_event.dart';
import 'package:cfl/view/screens/feed/single_news_feed.dart';
import 'package:cfl/view/styles/assets.dart';
import 'package:cfl/view/styles/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class AllFeedScreen extends ConsumerStatefulWidget {
  const AllFeedScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AllFeedScreenState();
}

class _AllFeedScreenState extends ConsumerState<AllFeedScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.background,
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
                          ]),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        body: Container(
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
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: ListView.builder(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          bottom: 120,
        ),
        itemCount: 5,
        itemBuilder: (context, index) {
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
                  width: 1,
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
                    child: Image.asset(
                      AppAssets.fishBg,
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
                          '${'mar'.tr()} 13, 2023',
                          style: GoogleFonts.dmSans(
                            fontSize: 12,
                            color: AppColors.primaryColor.withOpacity(0.60),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'News Title',
                          style: GoogleFonts.dmSans(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryColor,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. In lorem pellentesque.',
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
    return ListView.builder(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
        bottom: 120,
      ),
      itemCount: 5,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            context.push(const SingleEventFeed());
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: AppColors.background,
              border: Border.all(
                color: AppColors.tertiaryColor,
                width: 1,
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
                  child: Image.asset(
                    AppAssets.onboarding2,
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
                        '${'mar'.tr()} 13, 2023',
                        style: GoogleFonts.dmSans(
                          fontSize: 12,
                          color: AppColors.primaryColor.withOpacity(0.60),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Event Title',
                        style: GoogleFonts.dmSans(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. In lorem pellentesque.',
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
  }
}
