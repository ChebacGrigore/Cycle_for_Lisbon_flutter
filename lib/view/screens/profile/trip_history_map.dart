import 'dart:async';
// import 'dart:math';

import 'package:cfl/bloc/trip/bloc/trip_bloc.dart';
import 'package:cfl/models/trip.model.dart';
import 'package:cfl/shared/global/global_var.dart';
import 'package:cfl/view/screens/profile/leaderboard.dart';
import 'package:cfl/view/screens/profile/trip_history.dart';
import 'package:cfl/view/styles/assets.dart';
import 'package:cfl/view/styles/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../bloc/trip/bloc/trip_state.dart';
import '../../../routes/app_route.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

class TripMapScreen extends StatefulWidget {
  final TripHistory trip;
  const TripMapScreen({Key? key, required this.trip}) : super(key: key);

  @override
  State<TripMapScreen> createState() => _TripMapScreenState();
}

class _TripMapScreenState extends State<TripMapScreen> {
  late GoogleMapController mapController;
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  // Set<Polyline> polylines = {};

  void check(CameraUpdate u, GoogleMapController c) async {
    c.animateCamera(u);
    mapController.animateCamera(u);
    LatLngBounds l1 = await c.getVisibleRegion();
    LatLngBounds l2 = await c.getVisibleRegion();
    if (l1.southwest.latitude == -90 || l2.southwest.latitude == -90) {
      check(u, c);
    }
  }

  @override
  void initState() {
    super.initState();
    context
        .read<TripBloc>()
        .add(GetPoints(token: accessToken, id: widget.trip.trip.id));
  }

  @override
  Widget build(BuildContext context) {
    // LatLng latLng_1 = LatLng(widget.trip.startLat!, widget.trip.startLon!);
    // LatLng latLng_2 = LatLng(widget.trip.endLat!, widget.trip.endLon!);
    // LatLngBounds bounds = LatLngBounds(southwest: latLng_1, northeast: latLng_2);

    return Scaffold(
      body: BlocBuilder<TripBloc, TripState>(
        builder: (context, state) {
          if (state.status.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return FutureBuilder<BitmapDescriptor>(
              future: BitmapDescriptor.fromAssetImage(
                const ImageConfiguration(),
                AppAssets.location,
              ),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(child: Text('Error loading icon'));
                }
                final BitmapDescriptor startIcon = snapshot.data!;
                return FutureBuilder<BitmapDescriptor>(
                    future: BitmapDescriptor.fromAssetImage(
                      const ImageConfiguration(),
                      AppAssets.endLocation,
                    ),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return const Center(child: Text('Error loading icon'));
                      }
                      final BitmapDescriptor endIcon = snapshot.data!;
                      return Stack(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: GoogleMap(
                              mapType: MapType.normal,
                              initialCameraPosition: CameraPosition(
                                target: LatLng(
                                    (widget.trip.trip.startLat! +
                                            widget.trip.trip.endLat!) /
                                        2,
                                    (widget.trip.trip.startLon! +
                                            widget.trip.trip.endLon!) /
                                        2),
                                zoom: 11.4746,
                              ),
                              onMapCreated: (controller) async {
                                mapController = controller;
                                //await getDirections(start: LatLng(widget.trip.startLat!, widget.trip.startLon!),stop: LatLng(widget.trip.endLat!, widget.trip.endLon!));
                                _controller.complete(controller);

                                LatLng latLng_1 = LatLng(
                                    widget.trip.trip.startLat!,
                                    widget.trip.trip.startLon!);
                                LatLng latLng_2 = LatLng(
                                    widget.trip.trip.endLat!,
                                    widget.trip.trip.endLon!);
                                LatLngBounds bounds = LatLngBounds(
                                    southwest: latLng_1, northeast: latLng_2);

                                CameraUpdate u2 = CameraUpdate.newLatLngBounds(
                                    bounds, widget.trip.trip.distance);
                                mapController.animateCamera(u2).then((void v) {
                                  check(u2, mapController);
                                });

                                controller.moveCamera(
                                  CameraUpdate.newLatLngBounds(bounds, 30.0),
                                );
                              },
                              markers: <Marker>{
                                Marker(
                                  markerId: const MarkerId('start'),
                                  position: LatLng(widget.trip.trip.startLat!,
                                      widget.trip.trip.startLon!),
                                  infoWindow: const InfoWindow(
                                    title: 'Start point',
                                    snippet: 'My starting point',
                                  ),
                                  icon: startIcon,
                                ),
                                Marker(
                                  markerId: const MarkerId('stop'),
                                  position: LatLng(widget.trip.trip.endLat!,
                                      widget.trip.trip.endLon!),
                                  infoWindow: const InfoWindow(
                                    title: 'Stop point',
                                    snippet: 'My stoping point',
                                  ),
                                  icon: endIcon,
                                ),
                              },
                              polylines: <Polyline>{
                                Polyline(
                                  polylineId: const PolylineId('line'),
                                  color: Colors.yellow,
                                  width: 5,
                                  points: state.points!,
                                ),
                              },
                            ),
                          ),
                          Align(
                            alignment: Alignment.topCenter,
                            child: SafeArea(
                              child: Row(
                                children: [
                                  IconButton(
                                    color: AppColors.white,
                                    onPressed: () => appRoutes.pop(),
                                    icon: const Icon(
                                      Icons.arrow_back,
                                      size: 32,
                                    ),
                                  ),
                                  const Spacer(),
                                  Text(
                                    widget.trip.initiativeName!.tr(),
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
                                          text: widget.trip.trip.startAddr ??
                                              'N/A',
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
                                          text:
                                              widget.trip.trip.endAddr ?? 'N/A',
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        LeaderboardActivityCount(
                                          showTitle: false,
                                          count:
                                              widget.trip.trip.distance.round(),
                                          title: '',
                                          unit: 'km'.tr(),
                                          icon: AppAssets.roadIco,
                                        ),
                                        const SizedBox(width: 20),
                                        LeaderboardActivityCount(
                                          showTitle: false,
                                          count:
                                              '${(widget.trip.trip.durationInMotion ~/ 3600).toString().padLeft(2, '0')}:${(widget.trip.trip.durationInMotion ~/ 60).toString().padLeft(2, '0')}',
                                          title: '',
                                          unit: 'h'.tr(),
                                          icon: AppAssets.clockIco,
                                        ),
                                        const SizedBox(width: 20),
                                        LeaderboardActivityCount(
                                          showTitle: false,
                                          count:
                                              widget.trip.trip.credits.round(),
                                          title: '',
                                          unit: '',
                                          icon: AppAssets.coinIco,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    });
              });
        },
      ),
    );
  }
}
