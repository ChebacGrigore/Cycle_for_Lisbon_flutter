import 'package:cfl/view/styles/assets.dart';
import 'package:cfl/view/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
        ],
      ),
    );
  }
}
