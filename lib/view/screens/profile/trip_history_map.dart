import 'dart:async';

import 'package:cfl/models/trip.model.dart';
import 'package:cfl/shared/buildcontext_ext.dart';
import 'package:cfl/view/screens/profile/leaderboard.dart';
import 'package:cfl/view/screens/profile/trip_history.dart';
import 'package:cfl/view/styles/assets.dart';
import 'package:cfl/view/styles/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../shared/global/global_var.dart';

class TripMapScreen extends StatefulWidget {
  final TripModel trip;
  const TripMapScreen({Key? key, required this.trip}) : super(key: key);

  @override
  State<TripMapScreen> createState() => _TripMapScreenState();
}

class _TripMapScreenState extends State<TripMapScreen> {
  late GoogleMapController mapController;
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  void check(CameraUpdate u, GoogleMapController c) async {
    c.animateCamera(u);
    mapController.animateCamera(u);
    LatLngBounds l1=await c.getVisibleRegion();
    LatLngBounds l2=await c.getVisibleRegion();
    print(l1.toString());
    print(l2.toString());
    if(l1.southwest.latitude==-90 ||l2.southwest.latitude==-90)
      check(u, c);
  }

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    // LatLng latLng_1 = LatLng(widget.trip.startLat!, widget.trip.startLon!);
    // LatLng latLng_2 = LatLng(widget.trip.endLat!, widget.trip.endLon!);
    // LatLngBounds bounds = LatLngBounds(southwest: latLng_1, northeast: latLng_2);
    List<Marker> markers = [
      Marker(
        markerId: const MarkerId('start'),
        position: LatLng(widget.trip.startLat!, widget.trip.startLon!),
        infoWindow: const InfoWindow(
          title: 'Start point',
          snippet: 'My starting point',
        ),
      ),
      Marker(
        markerId: const MarkerId('stop'),
        position: LatLng(widget.trip.endLat!, widget.trip.endLon!),
        infoWindow: const InfoWindow(
          title: 'Stop point',
          snippet: 'My stoping point',
        ),
      ),
    ];
    return Scaffold(
      body: Stack(
        children: [

          SizedBox(
            width: double.infinity,
            child: GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: CameraPosition(
                target:
                    LatLng((widget.trip.startLat! + widget.trip.endLat!) /2, (widget.trip.startLon! + widget.trip.endLon!) /2),
                zoom: 11.4746,
              ),
              onMapCreated: (controller) {
                mapController = controller;
                _controller.complete(controller);

                LatLng latLng_1 = LatLng(widget.trip.startLat!, widget.trip.startLon!);
                LatLng latLng_2 = LatLng(widget.trip.endLat!, widget.trip.endLon!);
                LatLngBounds bounds = LatLngBounds(southwest: latLng_1, northeast: latLng_2);



                CameraUpdate u2 = CameraUpdate.newLatLngBounds(bounds, widget.trip.distance);
                mapController.animateCamera(u2).then((void v){
                  check(u2,mapController);
                });

                controller.moveCamera(CameraUpdate.newLatLngBounds(bounds, 30.0),);

              },
              markers: Set<Marker>.of(markers),
            ),
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
                height: 135,
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
                    const SizedBox(height: 10),
                     Row(
                      children: [
                        TripHistoryInfo(
                          icon: Icons.location_on_outlined,
                          text: widget.trip.startAddr ?? 'N/A',
                        ),
                        const SizedBox(width: 10),
                        const Icon(
                          Icons.arrow_forward,
                          size: 18,
                          color: AppColors.accentColor,
                        ),
                        const SizedBox(width: 10),
                        TripHistoryInfo(
                          icon: Icons.flag_outlined,
                          text: widget.trip.endAddr ?? 'N/A',
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        LeaderboardActivityCount(
                          showTitle: false,
                          count: widget.trip.distance.toStringAsFixed(2),
                          title: '',
                          unit: 'km'.tr(),
                          icon: AppAssets.roadIco,
                        ),
                        const SizedBox(width: 20),
                        LeaderboardActivityCount(
                          showTitle: false,
                          count: widget.trip.duration.toStringAsFixed(2),
                          title: '',
                          unit: 'h'.tr(),
                          icon: AppAssets.roadIco,
                        ),
                        const SizedBox(width: 20),
                        LeaderboardActivityCount(
                          showTitle: false,
                          count: widget.trip.durationInMotion.toStringAsFixed(2),
                          title: '',
                          unit: '',
                          icon: AppAssets.roadIco,
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
