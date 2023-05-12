import 'package:cfl/shared/buildcontext_ext.dart';
import 'package:cfl/view/screens/profile/leaderboard.dart';
import 'package:cfl/view/screens/profile/trip_history.dart';
import 'package:cfl/view/styles/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong2/latlong.dart';

class TripMapScreen extends StatefulWidget {
  const TripMapScreen({Key? key}) : super(key: key);

  @override
  State<TripMapScreen> createState() => _TripMapScreenState();
}

class _TripMapScreenState extends State<TripMapScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              center: LatLng(51.509364, -0.128928),
              zoom: 15.2,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.app.cfl',
                tileBuilder: darkModeTileBuilder,
                backgroundColor: Colors.black54,
              ),
            ],
          ),
          Align(
            alignment: Alignment.topCenter,
            child: SafeArea(
              child: Row(
                children: [
                  IconButton(
                    color: AppColors.white,
                    onPressed: () => context.pop(),
                    icon: const Icon(
                      Icons.arrow_back,
                      size: 32,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    'initiative_name'.tr(),
                    style: GoogleFonts.dmSans(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: AppColors.white,
                    ),
                  ),
                  const Spacer(),
                  const Spacer(),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SafeArea(
              child: Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.all(16),
                width: double.infinity,
                height: 150,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${'trip_details'.tr()}:',
                      style: GoogleFonts.dmSans(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    const SizedBox(height: 16),
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
                          icon: Icons.flag_outlined,
                          text: '3890 Poplar Dr.',
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        LeaderboardActivityCount(
                          showTitle: false,
                          count: 5,
                          title: '',
                          unit: 'km'.tr(),
                          icon: Icons.roundabout_left,
                        ),
                        const SizedBox(width: 20),
                        LeaderboardActivityCount(
                          showTitle: false,
                          count: 2,
                          title: '',
                          unit: 'h'.tr(),
                          icon: Icons.timer,
                        ),
                        const SizedBox(width: 20),
                        const LeaderboardActivityCount(
                          showTitle: false,
                          count: 200,
                          title: '',
                          unit: '',
                          icon: Icons.attach_money_outlined,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
