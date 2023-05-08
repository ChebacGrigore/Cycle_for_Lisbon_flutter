import 'package:cfl/view/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class SingleNewsFeed extends ConsumerStatefulWidget {
  const SingleNewsFeed({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SingleNewsFeedState();
}

class _SingleNewsFeedState extends ConsumerState<SingleNewsFeed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: true,
            iconTheme: const IconThemeData(color: AppColors.white),
            centerTitle: true,
            stretch: true,
            floating: true,
            pinned: true,
            expandedHeight: 250,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    alignment: Alignment.bottomCenter,
                    image: AssetImage(
                      AppAssets.onboarding6,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  color: AppColors.black.withOpacity(0.20),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'News Title',
                        style: GoogleFonts.dmSans(
                            fontWeight: FontWeight.w500,
                            fontSize: 22,
                            color: AppColors.primaryColor),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Lorem ipsum dolor sit amet consectetur. Aliquam vulputate massa id lacus gravida enim pretium sit. Sollicitudin fermentum duis ullamcorper gravida enim phasellus consectetur. Sapien sed varius fermentum dictumst varius pellentesque. Dui aliquam feugiat enim lectus.  Maecenas magna orci ut sit ultricies. Imperdiet neque libero at euismod. Tincidunt ut ac nibh amet posuere non nisl. Enim at dui in et ullamcorper. Risus tempus rhoncus tristique aliquam interdum. Elit mattis consectetur ullamcorper consectetur feugiat tempor aliquam sed tortor. Pellentesque vel cras nunc quis volutpat dictumst mauris. Scelerisque leo id eu nunc pretium viverra. Ornare id diam sagittis in ornare hendrerit dolor leo. Nec amet non mauris tincidunt mauris eget mauris.',
                        style: GoogleFonts.dmSans(
                            fontSize: 14,
                            height: 2,
                            color: AppColors.primaryColor),
                      ),
                      const SizedBox(height: 32),
                      Text(
                        'March 13, 2023',
                        style: GoogleFonts.dmSans(
                          color: AppColors.primaryColor.withOpacity(0.60),
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 42),
                      const Divider(),
                      const SizedBox(height: 22),
                      Row(
                        children: [
                          Text(
                            'Share: ',
                            style: GoogleFonts.dmSans(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(width: 22),
                          IconButton(
                            color: AppColors.accentColor,
                            onPressed: () {},
                            icon: const Icon(CFLIcons.facebook),
                          ),
                          IconButton(
                            color: AppColors.accentColor,
                            onPressed: () {},
                            icon: const Icon(CFLIcons.twitter),
                          ),
                          IconButton(
                            color: AppColors.accentColor,
                            onPressed: () {},
                            icon: const Icon(CFLIcons.linkedin),
                          ),
                        ],
                      ),
                      const SizedBox(height: 22),
                      const Divider(),
                      const SizedBox(height: 42),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton.icon(
                            onPressed: () {},
                            label: Text(
                              'Back to All',
                              style: GoogleFonts.dmSans(
                                  color: AppColors.primaryColor),
                            ),
                            icon: const Icon(Icons.arrow_back,
                                color: AppColors.primaryColor),
                          ),
                          TextButton.icon(
                            onPressed: () {},
                            icon: Text(
                              'Next Article',
                              style: GoogleFonts.dmSans(
                                  color: AppColors.primaryColor),
                            ),
                            label: const Icon(Icons.arrow_forward,
                                color: AppColors.primaryColor),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
