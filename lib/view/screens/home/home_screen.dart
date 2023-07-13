import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cfl/bloc/app/bloc/app_bloc.dart';
import 'package:cfl/bloc/auth/bloc/auth_bloc.dart';
import 'package:cfl/bloc/trip/bloc/trip_bloc.dart';
import 'package:cfl/bloc/trip/bloc/trip_state.dart';
import 'package:cfl/controller/app/initiative.dart';
import 'package:cfl/controller/app/trip_service.dart';
import 'package:cfl/models/initiative.model.dart';
import 'package:cfl/routes/app_route_paths.dart';
import 'package:cfl/shared/global/global_var.dart';
import 'package:cfl/view/styles/styles.dart';
import 'package:cfl/view/widgets/widgets.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../controller/auth/auth.dart';
import '../../../routes/app_route.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late GoogleMapController mapController;
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  void check(CameraUpdate u, GoogleMapController c) async {
    c.animateCamera(u);
    mapController.animateCamera(u);
    LatLngBounds l1 = await c.getVisibleRegion();
    LatLngBounds l2 = await c.getVisibleRegion();
    if (l1.southwest.latitude == -90 || l2.southwest.latitude == -90) {
      check(u, c);
    }
  }

  bool hasLastRide = false;
  bool startTripLocationStream = false;
  late Future<Initiative> singleInitiative;

  @override
  void initState() {
    super.initState();
    if (currentUser.initiative != null) {
      singleInitiative = InitiativeService().getSingleInitiative(
          accessToken: accessToken, id: currentUser.initiativeId!);
      context
          .read<AppBloc>()
          .add(AppSelectedInitiativeStats(token: accessToken));
      auth.getFromLocalStorage(value: 'tripId').then((value) {
        if (value != null) {
          context
              .read<TripBloc>()
              .add(GetLastRide(token: accessToken, id: value));
          setState(() {
            hasLastRide = true;
          });
        }
      });
      context
          .read<AuthBloc>()
          .add(AuthGetProfile(id: currentUser.id, token: accessToken));
    } else {
      context
          .read<AuthBloc>()
          .add(AuthGetProfile(id: currentUser.id, token: accessToken));
      context.read<AppBloc>().add(AppListOfInitiatives(token: accessToken));
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  InitiativeValue initiativeState = InitiativeValue.initial;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(gradient: AppColors.whiteBg4Gradient),
        child: SingleChildScrollView(
          child: SafeArea(
            child: BlocConsumer<AppBloc, AppState>(
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
                if (state.status.isLoading) {
                  return Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.40,
                      ),
                      const Center(child: CircularProgressIndicator()),
                    ],
                  );
                }
                return Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 40,
                    bottom: 100,
                  ),
                  child: homeBuilder(state),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget homeBuilder(AppState state) {
    if (currentUser.initiativeId == null) {
      return _buildInitialInitiative();
    } else if (currentUser.initiativeId != null) {
      return (currentUser.initiative!.credits == currentUser.initiative!.goal ||
              currentUser.initiative!.credits > currentUser.initiative!.goal)
          ? _buildCompletedInitiative(
              completedInitiative: currentUser.initiative!)
          : _buildSelectedInitiative(
              selectedInitiative: currentUser.initiative!);
    } else if (state.status.isSupportInitiative) {
      return currentUser.initiative!.credits == currentUser.initiative!.goal
          ? _buildCompletedInitiative(
              completedInitiative: currentUser.initiative!)
          : _buildSelectedInitiative(
              selectedInitiative: currentUser.initiative!);
    }
    return const SizedBox();
  }

  Widget _buildInitialInitiative() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProfileButton(
          onTap: () {
            appRoutes.push(AppRoutePath.profile);
            // context.push(const ProfileScreen());
          },
          greeting: 'hello'.tr(),
        ),
        const SizedBox(height: 28),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: PillContainer(
                title: 'total_earned'.tr(),
                count: currentUser.credits.round(),
                icon: CFLIcons.coin1,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: PillContainer(
                title: 'total_km'.tr(),
                count: currentUser.totalDist.round(),
                icon: CFLIcons.roadhz,
              ),
            ),
          ],
        ),
        const SizedBox(height: 42),
        Text(
          'let_start_cycling'.tr(),
          style: GoogleFonts.dmSans(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          'choose_initiative'.tr(),
          style: GoogleFonts.dmSans(
            fontSize: 14,
            color: AppColors.primaryColor.withOpacity(0.80),
          ),
        ),
        const SizedBox(height: 24),
        BlocBuilder<AppBloc, AppState>(
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
                    const SizedBox(height: 60),
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
              );
            } else if (state.status.isAllInitiativesLoaded) {
              return state.initiatives.isEmpty
                  ? Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 60),
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
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.initiatives.length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                if (state.initiatives[index].credits == 0.0) {
                                  // context.push(SingleInitiative(
                                  //   initiative: state.initiatives[index],
                                  // ));
                                  appRoutes.push(AppRoutePath.singleInitiative,
                                      extra: state.initiatives[index]);
                                } else if (state.initiatives[index].credits ==
                                    state.initiatives[index].goal) {
                                  context.read<AppBloc>().add(
                                        AppCompletedInitiative(
                                          initiative: state.initiatives[index],
                                        ),
                                      );
                                } else {
                                  // context.push(SingleInitiative(
                                  //   initiative: state.initiatives[index],
                                  // ));
                                  appRoutes.push(AppRoutePath.singleInitiative,
                                      extra: state.initiatives[index]);
                                }
                              });
                            },
                            child: InitiativeCard(
                              initiative: state.initiatives[index],
                            ),
                          ),
                        );
                      },
                    );
            }
            return ListView.builder(
              shrinkWrap: true,
              itemCount: 4,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        appRoutes.push(AppRoutePath.singleInitiative,
                            extra: state.initiatives[index]);
                      });
                    },
                    child: InitiativeCard(
                      initiative: state.initiatives[index],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildSelectedInitiative({required Initiative selectedInitiative}) {
    bool isLoading = false;
    bool isUploading = false;
    return BlocConsumer<TripBloc, TripState>(
      listener: (context, state) {
        if (state.status.isLoading) {
          setState(() {
            isLoading = true;
          });
        } else if (state.status.isTripUploading) {
          setState(() {
            isUploading = true;
          });
        } else if (state.status.isError) {
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
        } else if (state.status.isSuccess) {
          setState(() {
            isLoading = false;
          });
          auth.getFromLocalStorage(value: 'tripId').then((value) {
            if (value != null) {
              context
                  .read<TripBloc>()
                  .add(GetLastRide(token: accessToken, id: value));
              setState(() {
                hasLastRide = true;
              });
            }
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  const Icon(
                    Icons.done,
                    color: Colors.green,
                  ),
                  Expanded(
                    child: Text(
                      'Your total distance is ${state.trip!.distance.round()} in ${(state.trip!.durationInMotion / 60).round()} min',
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
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfileButton(
              onTap: () {
                appRoutes.push(AppRoutePath.profile);
              },
              greeting: 'welcome_back'.tr(),
            ),
            const SizedBox(height: 28),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: PillContainer(
                    title: 'total_earned'.tr(),
                    count: currentUser.credits.round(),
                    icon: CFLIcons.coin1,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: PillContainer(
                    title: 'total_km'.tr(),
                    count: currentUser.totalDist.round(),
                    icon: CFLIcons.roadhz,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 42),
            FutureBuilder<Initiative>(
                future: singleInitiative,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError || !snapshot.hasData) {
                    return SelectedInitiativeCard(
                      name: selectedInitiative.id,
                      progress: selectedInitiative.credits == 0.0
                          ? 0
                          : (selectedInitiative.credits /
                              selectedInitiative.goal),
                      goal: selectedInitiative.goal,
                      collected: selectedInitiative.credits,
                      image:
                          'https://cutewallpaper.org/24/image-placeholder-png/croppedplaceholderpng-%E2%80%93-osa-grappling.png',
                    );
                  }
                  final initiative = snapshot.data!;
                  return SelectedInitiativeCard(
                    name: initiative.title,
                    progress: initiative.credits == 0.0
                        ? 0
                        : (initiative.credits / initiative.goal),
                    goal: initiative.goal,
                    collected: initiative.credits,
                    image: initiative.presignedImageUrl ??
                        'https://cutewallpaper.org/24/image-placeholder-png/croppedplaceholderpng-%E2%80%93-osa-grappling.png',
                  );
                }),
            const SizedBox(height: 32),
            Text(
              '${'contributions'.tr()}: ',
              style: GoogleFonts.dmSans(
                color: AppColors.primaryColor,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 14),
            BlocBuilder<AppBloc, AppState>(
              builder: (context, state) {
                if (state.status.isLoading) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const ContributionCard(
                        icon: CFLIcons.roadhz,
                        count: 0,
                        title: 'km',
                      ),
                      const ContributionCard(
                        icon: CFLIcons.clock,
                        count: 0,
                        title: 'h',
                      ),
                      ContributionCard(
                        icon: CFLIcons.coin1,
                        count: 0,
                        title: 'coins'.tr(),
                      ),
                    ],
                  );
                } else if (state.status.isError) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const ContributionCard(
                        icon: CFLIcons.roadhz,
                        count: 0,
                        title: 'km',
                      ),
                      const ContributionCard(
                        icon: CFLIcons.clock,
                        count: "00:00",
                        title: 'h',
                      ),
                      ContributionCard(
                        icon: CFLIcons.coin1,
                        count: 0,
                        title: 'coins'.tr(),
                      ),
                    ],
                  );
                } else if (state.status.isStatsInitiative) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ContributionCard(
                        icon: CFLIcons.roadhz,
                        count: state.stats!.totalDist.round(),
                        title: 'km',
                      ),
                      ContributionCard(
                        icon: CFLIcons.clock,
                        count:
                            '${(state.stats!.totalDurationInMotion.round() ~/ 3600).toString().padLeft(2, '0')}:${(state.stats!.totalDurationInMotion.round() ~/ 60).toString().padLeft(2, '0')}',
                        title: 'h'.tr(),
                      ),
                      ContributionCard(
                        icon: CFLIcons.coin1,
                        count: state.stats!.totalCredits.round(),
                        title: 'coins'.tr(),
                      ),
                    ],
                  );
                }
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ContributionCard(
                      icon: CFLIcons.roadhz,
                      count: state.stats!.totalDist.round(),
                      title: 'km',
                    ),
                    ContributionCard(
                      icon: CFLIcons.clock,
                      count:
                          '${(state.stats!.totalDurationInMotion.round() ~/ 3600).toString().padLeft(2, '0')}:${(state.stats!.totalDurationInMotion.round() ~/ 60).toString().padLeft(2, '0')}',
                      title: 'h'.tr(),
                    ),
                    ContributionCard(
                      icon: CFLIcons.coin1,
                      count: state.stats!.totalCredits.round(),
                      title: 'coins'.tr(),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 32),
            hasLastRide == false
                ? Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          AppAssets.empty,
                          height: 130,
                        ),
                        const Center(
                          child: Text(
                            'No Last ride yet!',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  )
                : BlocBuilder<TripBloc, TripState>(builder: (context, state) {
                    if (state.status.isLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state.status.isLastRide) {
                      final lastRide = state.lastRide!;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${'you_last_ride'.tr()}: ',
                            style: GoogleFonts.dmSans(
                              color: AppColors.primaryColor,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 14),
                          Container(
                            width: double.infinity,
                            height: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: AppColors.black.withOpacity(.05),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: FutureBuilder<BitmapDescriptor>(
                                  future: BitmapDescriptor.fromAssetImage(
                                    const ImageConfiguration(),
                                    AppAssets.location,
                                  ),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const Center(
                                          child: CircularProgressIndicator());
                                    } else if (snapshot.hasError) {
                                      return const Center(
                                          child: Text('Error loading icon'));
                                    }
                                    final BitmapDescriptor startIcon =
                                        snapshot.data!;
                                    return FutureBuilder<BitmapDescriptor>(
                                        future: BitmapDescriptor.fromAssetImage(
                                          const ImageConfiguration(),
                                          AppAssets.endLocation,
                                        ),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return const Center(
                                                child:
                                                    CircularProgressIndicator());
                                          } else if (snapshot.hasError) {
                                            return const Center(
                                                child:
                                                    Text('Error loading icon'));
                                          }
                                          final BitmapDescriptor endIcon =
                                              snapshot.data!;
                                          return SizedBox(
                                            width: double.infinity,
                                            child: GoogleMap(
                                              mapType: MapType.normal,
                                              initialCameraPosition:
                                                  CameraPosition(
                                                target: LatLng(
                                                    (lastRide.trip.startLat! +
                                                            lastRide
                                                                .trip.endLat!) /
                                                        2,
                                                    (lastRide.trip.startLon! +
                                                            lastRide
                                                                .trip.endLon!) /
                                                        2),
                                                zoom: 11.4746,
                                              ),
                                              onMapCreated: (controller) async {
                                                mapController = controller;
                                                //await getDirections(start: LatLng(widget.trip.startLat!, widget.trip.startLon!),stop: LatLng(widget.trip.endLat!, widget.trip.endLon!));
                                                _controller
                                                    .complete(controller);

                                                LatLng latLng_1 = LatLng(
                                                    lastRide.trip.startLat!,
                                                    lastRide.trip.startLon!);
                                                LatLng latLng_2 = LatLng(
                                                    lastRide.trip.endLat!,
                                                    lastRide.trip.endLon!);
                                                LatLngBounds bounds =
                                                    LatLngBounds(
                                                        southwest: latLng_1,
                                                        northeast: latLng_2);

                                                CameraUpdate u2 = CameraUpdate
                                                    .newLatLngBounds(bounds,
                                                        lastRide.trip.distance);
                                                mapController
                                                    .animateCamera(u2)
                                                    .then((void v) {
                                                  check(u2, mapController);
                                                });

                                                controller.moveCamera(
                                                  CameraUpdate.newLatLngBounds(
                                                      bounds, 30.0),
                                                );
                                              },
                                              markers: <Marker>{
                                                Marker(
                                                  markerId:
                                                      const MarkerId('start'),
                                                  position: LatLng(
                                                      lastRide.trip.startLat!,
                                                      lastRide.trip.startLon!),
                                                  infoWindow: const InfoWindow(
                                                    title: 'Start point',
                                                    snippet:
                                                        'My starting point',
                                                  ),
                                                  icon: startIcon,
                                                ),
                                                Marker(
                                                  markerId:
                                                      const MarkerId('stop'),
                                                  position: LatLng(
                                                      lastRide.trip.endLat!,
                                                      lastRide.trip.endLon!),
                                                  infoWindow: const InfoWindow(
                                                    title: 'Stop point',
                                                    snippet: 'My stoping point',
                                                  ),
                                                  icon: endIcon,
                                                ),
                                              },
                                              polylines: <Polyline>{
                                                Polyline(
                                                  polylineId:
                                                      const PolylineId('line'),
                                                  color: Colors.yellow,
                                                  width: 5,
                                                  points: lastRide.points,
                                                ),
                                              },
                                            ),
                                          );
                                        });
                                  }),
                            ),
                          ),
                          const SizedBox(height: 32),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ContributionCard(
                                icon: CFLIcons.roadhz,
                                count: lastRide.trip.distance.round(),
                                title: 'km'.tr(),
                              ),
                              ContributionCard(
                                icon: CFLIcons.clock,
                                count:
                                    '${(lastRide.trip.durationInMotion.round() ~/ 3600).toString().padLeft(2, '0')}:${(lastRide.trip.durationInMotion.round() ~/ 60).toString().padLeft(2, '0')}',
                                title: 'h'.tr(),
                              ),
                              ContributionCard(
                                icon: CFLIcons.coin1,
                                count: lastRide.trip.credits.round(),
                                title: 'coins'.tr(),
                              ),
                            ],
                          ),
                        ],
                      );
                    }
                    final lastRide = state.lastRide!;
                    return Column(
                      children: [
                        Text(
                          '${'you_last_ride'.tr()}: ',
                          style: GoogleFonts.dmSans(
                            color: AppColors.primaryColor,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 14),
                        Container(
                          width: double.infinity,
                          height: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: AppColors.black.withOpacity(.05),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: FutureBuilder<BitmapDescriptor>(
                                future: BitmapDescriptor.fromAssetImage(
                                  const ImageConfiguration(),
                                  AppAssets.location,
                                ),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  } else if (snapshot.hasError) {
                                    return const Center(
                                        child: Text('Error loading icon'));
                                  }
                                  final BitmapDescriptor startIcon =
                                      snapshot.data!;
                                  return FutureBuilder<BitmapDescriptor>(
                                      future: BitmapDescriptor.fromAssetImage(
                                        const ImageConfiguration(),
                                        AppAssets.endLocation,
                                      ),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return const Center(
                                              child:
                                                  CircularProgressIndicator());
                                        } else if (snapshot.hasError) {
                                          return const Center(
                                              child:
                                                  Text('Error loading icon'));
                                        }
                                        final BitmapDescriptor endIcon =
                                            snapshot.data!;
                                        return SizedBox(
                                          width: double.infinity,
                                          child: GoogleMap(
                                            mapType: MapType.normal,
                                            initialCameraPosition:
                                                CameraPosition(
                                              target: LatLng(
                                                  (lastRide.trip.startLat! +
                                                          lastRide
                                                              .trip.endLat!) /
                                                      2,
                                                  (lastRide.trip.startLon! +
                                                          lastRide
                                                              .trip.endLon!) /
                                                      2),
                                              zoom: 11.4746,
                                            ),
                                            onMapCreated: (controller) async {
                                              mapController = controller;
                                              //await getDirections(start: LatLng(widget.trip.startLat!, widget.trip.startLon!),stop: LatLng(widget.trip.endLat!, widget.trip.endLon!));
                                              _controller.complete(controller);

                                              LatLng latLng_1 = LatLng(
                                                  lastRide.trip.startLat!,
                                                  lastRide.trip.startLon!);
                                              LatLng latLng_2 = LatLng(
                                                  lastRide.trip.endLat!,
                                                  lastRide.trip.endLon!);
                                              LatLngBounds bounds =
                                                  LatLngBounds(
                                                      southwest: latLng_1,
                                                      northeast: latLng_2);

                                              CameraUpdate u2 =
                                                  CameraUpdate.newLatLngBounds(
                                                      bounds,
                                                      lastRide.trip.distance);
                                              mapController
                                                  .animateCamera(u2)
                                                  .then((void v) {
                                                check(u2, mapController);
                                              });

                                              controller.moveCamera(
                                                CameraUpdate.newLatLngBounds(
                                                    bounds, 30.0),
                                              );
                                            },
                                            markers: <Marker>{
                                              Marker(
                                                markerId:
                                                    const MarkerId('start'),
                                                position: LatLng(
                                                    lastRide.trip.startLat!,
                                                    lastRide.trip.startLon!),
                                                infoWindow: const InfoWindow(
                                                  title: 'Start point',
                                                  snippet: 'My starting point',
                                                ),
                                                icon: startIcon,
                                              ),
                                              Marker(
                                                markerId:
                                                    const MarkerId('stop'),
                                                position: LatLng(
                                                    lastRide.trip.endLat!,
                                                    lastRide.trip.endLon!),
                                                infoWindow: const InfoWindow(
                                                  title: 'Stop point',
                                                  snippet: 'My stoping point',
                                                ),
                                                icon: endIcon,
                                              ),
                                            },
                                            polylines: <Polyline>{
                                              Polyline(
                                                polylineId:
                                                    const PolylineId('line'),
                                                color: Colors.yellow,
                                                width: 5,
                                                points: state.points!,
                                              ),
                                            },
                                          ),
                                        );
                                      });
                                }),
                          ),
                        ),
                        const SizedBox(height: 32),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ContributionCard(
                              icon: CFLIcons.roadhz,
                              count: lastRide.trip.distance.round(),
                              title: 'km'.tr(),
                            ),
                            ContributionCard(
                              icon: CFLIcons.clock,
                              count:
                                  '${(lastRide.trip.durationInMotion / 3600).round()}:${(lastRide.trip.durationInMotion / 60).round()}',
                              title: 'h'.tr(),
                            ),
                            ContributionCard(
                              icon: CFLIcons.coin1,
                              count: lastRide.trip.credits.round(),
                              title: 'coins'.tr(),
                            ),
                          ],
                        ),
                      ],
                    );
                  }),
            const SizedBox(height: 42),
            BlocBuilder<TripBloc, TripState>(
              builder: (context, state) {
                if (state.status.isTripUploading) {
                  return SizedBox(
                    width: double.infinity,
                    height: 49,
                    child: ElevatedButton(
                      style: AppComponentThemes.elevatedButtonTheme(
                        color: AppColors.cabbageGreen,
                      ),
                      onPressed: () {},
                      child: const CircularProgressIndicator(
                        color: Colors.green,
                      ),
                    ),
                  );
                }
                return SizedBox(
                  width: double.infinity,
                  height: 49,
                  child: ElevatedButton(
                    style: AppComponentThemes.elevatedButtonTheme(
                      color: startTripLocationStream == false
                          ? AppColors.cabbageGreen
                          : AppColors.tomatoRed,
                    ),
                    onPressed: startTripLocationStream == false
                        ? () {
                            setState(() {
                              startTripLocationStream = true;
                            });
                            tripService.getLocationStream();
                          }
                        : isUploading == true
                            ? () {}
                            : () {
                                setState(() {
                                  startTripLocationStream = false;
                                });
                                tripService.positionSubscription!.cancel();
                                context
                                    .read<TripBloc>()
                                    .add(StopTrip(token: accessToken));
                              },
                    child: isUploading == true
                        ? const CircularProgressIndicator(
                            color: Colors.green,
                          )
                        : Text(
                            '${'start'.tr()}/${'stop'.tr()}',
                            style: GoogleFonts.dmSans(
                              color: AppColors.white,
                            ),
                          ),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            Center(
              child: TextButton(
                onPressed: () {
                  setState(() {
                    context.read<AppBloc>().add(const AppChangeInitiative());
                  });
                },
                child: Text(
                  'change_initiative'.tr(),
                  style: GoogleFonts.dmSans(
                    decoration: TextDecoration.underline,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildCompletedInitiative({required Initiative completedInitiative}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProfileButton(
          onTap: () {
            appRoutes.push(AppRoutePath.profile);
            // context.push(const ProfileScreen());
          },
          greeting: 'hello'.tr(),
        ),
        const SizedBox(height: 28),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: PillContainer(
                title: 'total_earned'.tr(),
                count: currentUser.credits < 1
                    ? currentUser.credits.toStringAsFixed(2)
                    : currentUser.credits == 0.0
                        ? 0
                        : currentUser.credits.round(),
                icon: CFLIcons.coin1,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: PillContainer(
                title: 'total_km'.tr(),
                count: currentUser.totalDist < 1
                    ? currentUser.totalDist.toStringAsFixed(2)
                    : currentUser.totalDist == 0.0
                        ? 0
                        : currentUser.totalDist.round(),
                icon: CFLIcons.roadhz,
              ),
            ),
          ],
        ),
        const SizedBox(height: 42),
        FutureBuilder<Initiative>(
            future: InitiativeService().getSingleInitiative(
                accessToken: accessToken, id: completedInitiative.id),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError || !snapshot.hasData) {
                return SelectedInitiativeCard(
                  name: completedInitiative.id,
                  progress: 1,
                  goal: completedInitiative.goal,
                  collected: completedInitiative.credits,
                  image:
                      'https://cutewallpaper.org/24/image-placeholder-png/croppedplaceholderpng-%E2%80%93-osa-grappling.png',
                );
              }
              final initiative = snapshot.data!;
              return SelectedInitiativeCard(
                name: initiative.title,
                progress: 1,
                goal: initiative.goal,
                collected: initiative.credits,
                image: initiative.presignedImageUrl ??
                    'https://cutewallpaper.org/24/image-placeholder-png/croppedplaceholderpng-%E2%80%93-osa-grappling.png',
              );
            }),
        const SizedBox(height: 32),
        RichText(
          text: TextSpan(
            text: '${'thank_for_support'.tr()} ',
            style: GoogleFonts.dmSans(
              fontSize: 14,
              color: AppColors.primaryColor,
            ),
            children: [
              TextSpan(
                text: 'want_select_new'.tr(),
                style: GoogleFonts.dmSans(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryColor,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 42),
        Text(
          'available_initiatives'.tr(),
          style: GoogleFonts.dmSans(
            fontSize: 18,
            color: AppColors.primaryColor,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 24),
        BlocBuilder<AppBloc, AppState>(
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
                    const SizedBox(height: 60),
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
              );
            } else if (state.status.isAllInitiativesLoaded) {
              return state.initiatives.isEmpty
                  ? Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 60),
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
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.initiatives.length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                if (state.initiatives[index].credits == 0.0) {
                                  // context.push(SingleInitiative(
                                  //   initiative: state.initiatives[index],
                                  // ));
                                  appRoutes.push(AppRoutePath.singleInitiative,
                                      extra: state.initiatives[index]);
                                } else if (state.initiatives[index].credits ==
                                    state.initiatives[index].goal) {
                                  context.read<AppBloc>().add(
                                        AppCompletedInitiative(
                                          initiative: state.initiatives[index],
                                        ),
                                      );
                                } else {
                                  // context.push(SingleInitiative(
                                  //   initiative: state.initiatives[index],
                                  // ));
                                  appRoutes.push(AppRoutePath.singleInitiative,
                                      extra: state.initiatives[index]);
                                }
                              });
                            },
                            child: InitiativeCard(
                              initiative: state.initiatives[index],
                            ),
                          ),
                        );
                      },
                    );
            }
            return ListView.builder(
              shrinkWrap: true,
              itemCount: 4,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        // context.push(SingleInitiative(
                        //   initiative: state.initiatives[index],
                        // ));
                        appRoutes.push(AppRoutePath.singleInitiative,
                            extra: state.initiatives[index]);
                      });
                    },
                    child: InitiativeCard(
                      initiative: state.initiatives[index],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }
}

class ProfileButton extends StatelessWidget {
  const ProfileButton({
    this.onTap,
    super.key,
    required this.greeting,
  });
  final VoidCallback? onTap;
  final String greeting;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          greeting.contains('Bem vindo') || greeting.contains('Welcome')
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$greeting, ',
                      style: GoogleFonts.dmSans(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        if (state.status.isProfileUpdated) {
                          return Text(
                            state.user!.username,
                            style: GoogleFonts.dmSans(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: AppColors.accentColor,
                            ),
                          );
                        }
                        return Text(
                          currentUser.username,
                          style: GoogleFonts.dmSans(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppColors.accentColor,
                          ),
                        );
                      },
                    ),
                  ],
                )
              : Row(
                  children: [
                    Text(
                      '$greeting, ',
                      style: GoogleFonts.dmSans(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        if (state.status.isProfileUpdated) {
                          return Text(
                            state.user!.username,
                            style: GoogleFonts.dmSans(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: AppColors.accentColor,
                            ),
                          );
                        }
                        return Text(
                          currentUser.username,
                          style: GoogleFonts.dmSans(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppColors.accentColor,
                          ),
                        );
                      },
                    ),
                  ],
                ),
          InkWell(
            onTap: onTap,
            child: BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                print(state.status);
                if (state.status.isProfilePicture) {
                  return CircleAvatar(
                    radius: 23,
                    backgroundImage: NetworkImage(
                      state.profilePic!,
                    ),
                  );
                } else if (state.status.isLoading) {
                  return const CircleAvatar(
                    radius: 23,
                    // backgroundImage: AssetImage(
                    //   AppAssets.placeholder,
                    // ),
                    backgroundColor: Colors.white,
                  );
                }
                return currentProfilePic == ''
                    ? const CircleAvatar(
                        radius: 23,
                        // backgroundImage: AssetImage(
                        //   AppAssets.placeholder,
                        // ),
                        backgroundColor: AppColors.background,
                      )
                    : CachedNetworkImage(
                        imageUrl: currentProfilePic,
                        imageBuilder: (context, image) {
                          return CircleAvatar(
                            radius: 23,
                            backgroundImage: image,
                          );
                        },
                        errorWidget: (context, url, error) =>
                            const CircleAvatar(
                          radius: 23,
                          backgroundImage: AssetImage(
                            AppAssets.placeholder,
                          ),
                          backgroundColor: AppColors.background,
                        ),
                        placeholder: (context, i) => const CircleAvatar(
                          radius: 23,
                          backgroundColor: AppColors.background,
                        ),
                      );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ContributionCard extends StatelessWidget {
  const ContributionCard({
    super.key,
    required this.icon,
    required this.count,
    required this.title,
  });
  final IconData icon;

  final String title;
  final dynamic count;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 40,
            vertical: 20,
          ),
          decoration: BoxDecoration(
            color: AppColors.tertiaryColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Icon(
              icon,
              color: AppColors.accentColor,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '$count $title',
          style: GoogleFonts.dmSans(),
        ),
      ],
    );
  }
}

class SelectedInitiativeCard extends StatelessWidget {
  const SelectedInitiativeCard(
      {required this.progress,
      required this.goal,
      required this.collected,
      required this.name,
      required this.image,
      Key? key})
      : super(key: key);
  final double progress, collected;
  final int goal;
  final String name, image;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: image,
      imageBuilder: (context, imageProvider) {
        return Container(
          width: double.infinity,
          height: 180,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: GoogleFonts.dmSans(
                  color: AppColors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const Spacer(),
              InitiativeProgress(
                progress: progress,
                goal: goal,
                collected: collected,
              ),
            ],
          ),
        );
      },
      errorWidget: (context, url, error) => SizedBox(
        height: 185,
        width: double.infinity,
        child: Image.asset(AppAssets.initiativePlaceholder),
      ),
      placeholder: (context, i) => Container(
        height: 185,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        width: double.infinity,
        child: const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

class InitiativeProgress extends StatelessWidget {
  const InitiativeProgress({
    super.key,
    required this.progress,
    required this.goal,
    required this.collected,
  });

  final double progress, collected;
  final int goal;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            progress != 1
                ? InitiativeCounter2(
                    title: 'collected'.tr(),
                    count: collected.round(),
                  )
                : Row(
                    children: [
                      const Icon(
                        Icons.check_circle,
                        color: AppColors.accentColor,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'completed'.tr(),
                        style: GoogleFonts.dmSans(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.white,
                        ),
                      )
                    ],
                  ),
            InitiativeCounter2(
              title: 'goal'.tr(),
              count: goal,
            ),
          ],
        ),
        const SizedBox(height: 9),
        SizedBox(
          height: 16,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: AppColors.tertiaryColor.withOpacity(0.20),
            ),
          ),
        ),
      ],
    );
  }
}

class InitiativeCounter2 extends StatelessWidget {
  const InitiativeCounter2({
    required this.count,
    required this.title,
    super.key,
  });
  final String title;
  final dynamic count;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: GoogleFonts.dmSans(
            color: AppColors.white.withOpacity(0.50),
            fontSize: 12,
          ),
        ),
        Row(
          children: [
            const Icon(
              CFLIcons.coin1,
              color: AppColors.accentColor,
            ),
            const SizedBox(width: 4),
            Text(
              count.toString(),
              style: GoogleFonts.dmSans(
                color: AppColors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        )
      ],
    );
  }
}

enum InitiativeValue {
  selected,
  completed,
  initial,
}
