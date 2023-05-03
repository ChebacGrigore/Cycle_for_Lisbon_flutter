import 'package:cfl/shared/buildcontext_ext.dart';
import 'package:cfl/view/screens/profile/profile_settings.dart';
import 'package:cfl/view/screens/profile/trip_history_map.dart';
import 'package:cfl/view/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class TripHistoryScreen extends StatefulWidget {
  const TripHistoryScreen({super.key});

  @override
  State<TripHistoryScreen> createState() => _TripHistoryScreenState();
}

class _TripHistoryScreenState extends State<TripHistoryScreen> {
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
              'Trip History',
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
                              unselectedLabelColor: AppColors.primaryColor,
                              indicator: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: AppColors.secondaryColor),
                              tabs: const [
                                Tab(
                                  text: 'For all time',
                                ),
                                Tab(
                                  text: 'This Week',
                                ),
                                Tab(
                                  text: 'This Month',
                                ),
                              ]),
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
    );
  }
}

class TripHistoryItem extends ConsumerWidget {
  const TripHistoryItem({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.separated(
      itemCount: 5,
      itemBuilder: (ctx, idx) {
        return ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Initiative Name',
                style: GoogleFonts.dmSans(
                  fontSize: 16,
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'October 30, 2023',
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
              Row(
                children: const [
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
                width: 90,
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
                        'See Map',
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
    return Row(
      children: [
        Icon(
          icon,
          color: AppColors.black,
          size: 19,
        ),
        const SizedBox(width: 4),
        Text(
          text,
          style: GoogleFonts.dmSans(
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
