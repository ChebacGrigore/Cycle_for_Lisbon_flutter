import 'dart:async';
import 'package:cfl/bloc/app/bloc/app_bloc.dart';
import 'package:cfl/bloc/auth/bloc/auth_bloc.dart';
import 'package:cfl/bloc/trip/bloc/trip_bloc.dart';
import 'package:cfl/bloc/trip/bloc/trip_state.dart';
import 'package:cfl/models/initiative.model.dart';
import 'package:cfl/routes/app_route_paths.dart';
import 'package:cfl/shared/buildcontext_ext.dart';
import 'package:cfl/shared/global/global_var.dart';
import 'package:cfl/view/screens/auth/splash.dart';
import 'package:cfl/view/styles/styles.dart';
import 'package:cfl/view/widgets/widgets.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cfl/view/screens/home/single_initiative.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../routes/app_route.dart';
// bool? isChangeInitiative;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  @override
  void initState() {
    super.initState();
    print(appRoutes.location);
    context.read<AppBloc>().add(AppListOfInitiatives(token: accessToken));
    context
        .read<AuthBloc>()
        .add(AuthGetProfile(id: currentUser.id, token: accessToken));
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
                  return const Center(child: CircularProgressIndicator());
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
            // context.push(const ProfileScreen(
            //   key: Key('profile'),
            // ));
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
                count: currentUser.credits.round() ?? 0,
                icon: CFLIcons.coin1,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: PillContainer(
                title: 'total_km'.tr(),
                count: currentUser.totalDist.round() ?? 0,
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
                                  context.push(SingleInitiative(
                                    initiative: state.initiatives[index],
                                  ));
                                } else if (state.initiatives[index].credits ==
                                    state.initiatives[index].goal) {
                                  context.read<AppBloc>().add(
                                        AppCompletedInitiative(
                                          initiative: state.initiatives[index],
                                        ),
                                      );
                                } else {
                                  context.push(SingleInitiative(
                                    initiative: state.initiatives[index],
                                  ));
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
                        context.push(SingleInitiative(
                          initiative: state.initiatives[index],
                        ));
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
    return BlocConsumer<TripBloc, TripState>(
      listener: (context, state) {
        if (state.status.isLoading) {
          setState(() {
            isLoading = true;
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
                      'Your total distance is ${state.trip!.distance} in ${state.trip!.duration}',
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
                    count: currentUser.credits!.round() ?? 0,
                    icon: CFLIcons.coin1,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: PillContainer(
                    title: 'total_km'.tr(),
                    count: currentUser.totalDist!.round() ?? 0,
                    icon: CFLIcons.roadhz,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 42),
            SelectedInitiativeCard(
              name: selectedInitiative.title,
              progress: selectedInitiative.credits == 0.0
                  ? 0
                  : (selectedInitiative.credits / selectedInitiative.goal),
              goal: selectedInitiative.goal,
              collected: selectedInitiative.credits,
            ),
            const SizedBox(height: 32),
            Text(
              '${'contributions'.tr()}: ',
              style: GoogleFonts.dmSans(
                color: AppColors.primaryColor,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 14),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ContributionCard(
                  icon: CFLIcons.roadhz,
                  count: currentUser.totalDist.round(),
                  title: 'km',
                ),
                const ContributionCard(
                  icon: CFLIcons.clock,
                  count: 5,
                  title: 'h',
                ),
                ContributionCard(
                  icon: CFLIcons.coin1,
                  count: currentUser.credits.round(),
                  title: 'coins'.tr(),
                ),
              ],
            ),
            const SizedBox(height: 32),
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
                child: GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: const CameraPosition(
                    target: LatLng(38.7223, -9.1393),
                    zoom: 14.4746,
                  ),
                  myLocationEnabled: true,
                  compassEnabled: true,
                  onMapCreated: (GoogleMapController controller) {
                    if (!_controller.isCompleted) {
                      _controller.complete(controller);
                    }
                  },
                  // onCameraMoveStarted: () async{
                  //   final controller = await _controller!.future;
                  //   final visibleRegion = await controller.getVisibleRegion();
                  //   _maxLat =  visibleRegion.northeast.latitude;
                  //   _maxLon = visibleRegion.northeast.longitude;
                  //   _minLat = visibleRegion.southwest.latitude;
                  //   _minLon = visibleRegion.southwest.longitude;
                  //   context.read<TripBloc>().add(AppListOfPOI(token: accessToken, maxLat: _maxLat, maxLon: _maxLon , minLat: _minLat, minLon: _minLon));
                  //   },
                ),
              ),
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ContributionCard(
                  icon: CFLIcons.roadhz,
                  count: 12,
                  title: 'km'.tr(),
                ),
                ContributionCard(
                  icon: CFLIcons.clock,
                  count: 5,
                  title: 'h'.tr(),
                ),
                ContributionCard(
                  icon: CFLIcons.coin1,
                  count: 20,
                  title: 'coins'.tr(),
                ),
              ],
            ),
            const SizedBox(height: 42),
            BlocBuilder<TripBloc, TripState>(
              builder: (context, state) {
                if (state.status.isStart ||
                    state.status.isError ||
                    state.status.isLocationStream) {
                  return SizedBox(
                    width: double.infinity,
                    height: 49,
                    child: ElevatedButton(
                      style: AppComponentThemes.elevatedButtonTheme(
                        color: AppColors.tomatoRed,
                      ),
                      onPressed: () {
                        context
                            .read<TripBloc>()
                            .add(StopTrip(token: accessToken));
                      },
                      child: isLoading == true
                          ? const CircularProgressIndicator(
                              color: Colors.red,
                            )
                          : Text(
                              '${'start'.tr()}/${'stop'.tr()}',
                              style: GoogleFonts.dmSans(
                                color: AppColors.white,
                              ),
                            ),
                    ),
                  );
                } else if (state.status.isStop || state.status.isSuccess) {
                  return SizedBox(
                    width: double.infinity,
                    height: 49,
                    child: ElevatedButton(
                      style: AppComponentThemes.elevatedButtonTheme(
                        color: AppColors.cabbageGreen,
                      ),
                      onPressed: () {
                        context.read<TripBloc>().add(const StartTrip());
                      },
                      child: isLoading == true
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
                } else if (state.status.isSuccess) {
                  return SizedBox(
                    width: double.infinity,
                    height: 49,
                    child: ElevatedButton(
                      style: AppComponentThemes.elevatedButtonTheme(
                        color: AppColors.cabbageGreen,
                      ),
                      onPressed: () {
                        context.read<TripBloc>().add(const StartTrip());
                      },
                      child: isLoading == true
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
                }
                return SizedBox(
                  width: double.infinity,
                  height: 49,
                  child: ElevatedButton(
                    style: AppComponentThemes.elevatedButtonTheme(
                      color: AppColors.cabbageGreen,
                    ),
                    onPressed: () {
                      context.read<TripBloc>().add(const StartTrip());
                    },
                    child: state.status.isLoading
                        ? const CircularProgressIndicator()
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
                    // setState(() {
                    //   selectedIndex = 1;
                    // });

                    // tabController.animateTo(1);
                    // isChangeInitiative = true;
                    context.read<AppBloc>().add(const AppChangeInitiative());
                    // initiativeState = InitiativeValue.initial;
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

  Future<bool> onBackPressed(BuildContext context) async {
    // print('Hello...exiting');
    bool? exit = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmation'),
          content: const Text('Are you sure you want to exit?'),
          actions: [
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop(false); // Stay in the app
              },
            ),
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                context.pushReplacement(const SplashScreen()); // Close the app
                // BackButtonInterceptor.remove(_exitDialogInterceptor);
              },
            ),
          ],
        );
      },
    );
    return exit ?? false;
  }

  Widget _buildCompletedInitiative({required Initiative completedInitiative}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProfileButton(
          onTap: () {
            appRoutes.push(AppRoutePath.profile);
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
        SelectedInitiativeCard(
          progress: 1,
          goal: completedInitiative.goal,
          collected: completedInitiative.credits,
          name: completedInitiative.title,
        ),
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
                                  context.push(SingleInitiative(
                                    initiative: state.initiatives[index],
                                  ));
                                } else if (state.initiatives[index].credits ==
                                    state.initiatives[index].goal) {
                                  context.read<AppBloc>().add(
                                        AppCompletedInitiative(
                                          initiative: state.initiatives[index],
                                        ),
                                      );
                                } else {
                                  context.push(SingleInitiative(
                                    initiative: state.initiatives[index],
                                  ));
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
                        context.push(SingleInitiative(
                          initiative: state.initiatives[index],
                        ));
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
                            state.user!.username ?? 'N/A',
                            style: GoogleFonts.dmSans(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: AppColors.accentColor,
                            ),
                          );
                        }
                        return Text(
                          currentUser.username ?? 'N/A',
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
                            state.user!.username ?? 'N/A',
                            style: GoogleFonts.dmSans(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: AppColors.accentColor,
                            ),
                          );
                        }
                        return Text(
                          currentUser.username ?? 'N/A',
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
                print(currentProfilePic);
                if (state.status.isProfilePicture) {
                  return CircleAvatar(
                    radius: 23,
                    backgroundImage: NetworkImage(
                      state.profilePic!,
                    ),
                  );
                }
                return currentProfilePic == ''
                    ? const CircleAvatar(
                        radius: 23,
                        // backgroundImage: AssetImage(
                        //   AppAssets.avatar,
                        // ),
                        backgroundColor: AppColors.background,
                      )
                    : CircleAvatar(
                        radius: 23,
                        backgroundImage: NetworkImage(
                          currentProfilePic,
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
      Key? key})
      : super(key: key);
  final double progress, collected;
  final int goal;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 180,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: const DecorationImage(
          image: AssetImage(AppAssets.bg01Png),
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
