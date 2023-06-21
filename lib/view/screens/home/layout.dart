import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:cfl/shared/shared.dart';
import 'package:cfl/view/styles/assets.dart';

import 'package:cfl/view/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:flutter_svg/svg.dart';

class Layout extends StatefulWidget {
  const Layout({super.key});

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> with SingleTickerProviderStateMixin {
  bool _exitDialogInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    onBackPressed(context);
    return true;
  }

  @override
  void initState() {
    controller = TabController(length: kTempScreens.length, vsync: this);

    super.initState();
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    BackButtonInterceptor.add(myInterceptor);
    // BackButtonInterceptor.add((stopDefaultButtonEvent, routeInfo) => )

    BackButtonInterceptor.add(_exitDialogInterceptor);
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);
    BackButtonInterceptor.remove(_exitDialogInterceptor);
    // _onBackPressed();
    super.dispose();
  }

  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    if (_selectedIndex != 0) {
      setState(() {
        _selectedIndex = 0;
        controller.animateTo(0);
        FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
        homeIco = AppAssets.homeIco2;
        targetIco = AppAssets.targetIco;
        crownIco = AppAssets.crownIco;
        mapIco = AppAssets.mapIco;
        newsIco = AppAssets.newsIco;
        phoneIco = AppAssets.phoneIco;
        roadIco = AppAssets.roadIco;
      });
    } else {
      context.pop();
    }

    return true;
  }

  int _selectedIndex = 0;
  late TabController controller;

  String homeIco = AppAssets.homeIco2;
  String crownIco = AppAssets.crownIco;
  String mapIco = AppAssets.mapIco;
  String newsIco = AppAssets.newsIco;
  String phoneIco = AppAssets.phoneIco;
  String roadIco = AppAssets.roadIco;
  String targetIco = AppAssets.targetIco;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          kTempScreens[_selectedIndex],
          Align(
            alignment: Alignment.bottomCenter,
            child: SafeArea(
              child: Container(
                height: 80,
                width: double.infinity,
                color: Colors.transparent,
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.shadowColor.withOpacity(0.16),
                          spreadRadius: 0,
                          blurRadius: 4,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: TabBar(
                      controller: controller,
                      padding: EdgeInsets.zero,
                      indicatorPadding: EdgeInsets.zero,
                      onTap: (x) {
                        setState(() {
                          _selectedIndex = x;

                          switch (x) {
                            case 0:
                              FlutterStatusbarcolor.setStatusBarWhiteForeground(
                                  false);
                              homeIco = AppAssets.homeIco2;
                              targetIco = AppAssets.targetIco;
                              crownIco = AppAssets.crownIco;
                              mapIco = AppAssets.mapIco;
                              newsIco = AppAssets.newsIco;
                              phoneIco = AppAssets.phoneIco;
                              roadIco = AppAssets.roadIco;
                              break;
                            case 1:
                              FlutterStatusbarcolor.setStatusBarWhiteForeground(
                                  false);
                              homeIco = AppAssets.homeIco;
                              targetIco = AppAssets.targetIco2;
                              crownIco = AppAssets.crownIco;
                              mapIco = AppAssets.mapIco;
                              newsIco = AppAssets.newsIco;
                              phoneIco = AppAssets.phoneIco;
                              roadIco = AppAssets.roadIco;

                              break;
                            case 2:
                              FlutterStatusbarcolor.setStatusBarWhiteForeground(
                                  true);
                              homeIco = AppAssets.homeIco;
                              targetIco = AppAssets.targetIco;
                              roadIco = AppAssets.roadIco2;
                              crownIco = AppAssets.crownIco;
                              mapIco = AppAssets.mapIco;
                              newsIco = AppAssets.newsIco;
                              phoneIco = AppAssets.phoneIco;

                              break;
                            case 3:
                              FlutterStatusbarcolor.setStatusBarWhiteForeground(
                                  true);
                              homeIco = AppAssets.homeIco;
                              targetIco = AppAssets.targetIco;
                              roadIco = AppAssets.roadIco;
                              mapIco = AppAssets.mapIco2;
                              crownIco = AppAssets.crownIco;
                              newsIco = AppAssets.newsIco;
                              phoneIco = AppAssets.phoneIco;

                              break;
                            case 4:
                              FlutterStatusbarcolor.setStatusBarWhiteForeground(
                                  true);
                              homeIco = AppAssets.homeIco;
                              targetIco = AppAssets.targetIco;
                              roadIco = AppAssets.roadIco;
                              mapIco = AppAssets.mapIco;
                              crownIco = AppAssets.crownIco2;
                              newsIco = AppAssets.newsIco;
                              phoneIco = AppAssets.phoneIco;

                              break;
                            case 5:
                              FlutterStatusbarcolor.setStatusBarWhiteForeground(
                                  false);
                              homeIco = AppAssets.homeIco;
                              targetIco = AppAssets.targetIco;
                              roadIco = AppAssets.roadIco;
                              mapIco = AppAssets.mapIco;
                              crownIco = AppAssets.crownIco;
                              newsIco = AppAssets.newsIco2;
                              phoneIco = AppAssets.phoneIco;

                              break;
                            case 6:
                              FlutterStatusbarcolor.setStatusBarWhiteForeground(
                                  true);
                              homeIco = AppAssets.homeIco;
                              targetIco = AppAssets.targetIco;
                              roadIco = AppAssets.roadIco;
                              mapIco = AppAssets.mapIco;
                              crownIco = AppAssets.crownIco;
                              newsIco = AppAssets.newsIco;
                              phoneIco = AppAssets.phoneIco2;

                              break;
                            default:
                              FlutterStatusbarcolor.setStatusBarWhiteForeground(
                                  false);
                              homeIco = AppAssets.homeIco2;
                              targetIco = AppAssets.targetIco;
                              crownIco = AppAssets.crownIco;
                              mapIco = AppAssets.mapIco;
                              newsIco = AppAssets.newsIco;
                              phoneIco = AppAssets.phoneIco;
                              roadIco = AppAssets.roadIco;
                          }
                        });
                      },
                      labelColor: AppColors.primaryColor,
                      unselectedLabelColor: Colors.white.withOpacity(0.40),
                      splashBorderRadius: BorderRadius.circular(50),
                      indicator: const BoxDecoration(
                        color: AppColors.secondaryColor,
                        shape: BoxShape.circle,
                      ),
                      tabs: [
                        Tab(
                          iconMargin: EdgeInsets.zero,
                          icon: SvgPicture.asset(
                            homeIco,
                          ),
                        ),
                        Tab(
                          iconMargin: EdgeInsets.zero,
                          icon: SvgPicture.asset(
                            targetIco,
                          ),
                        ),
                        Tab(
                          iconMargin: EdgeInsets.zero,
                          icon: SvgPicture.asset(roadIco),
                        ),
                        Tab(
                          iconMargin: EdgeInsets.zero,
                          icon: SvgPicture.asset(mapIco),
                        ),
                        Tab(
                          iconMargin: EdgeInsets.zero,
                          icon: SvgPicture.asset(
                            crownIco,
                          ),
                        ),
                        Tab(
                          iconMargin: EdgeInsets.zero,
                          icon: SvgPicture.asset(newsIco),
                        ),
                        Tab(
                          iconMargin: EdgeInsets.zero,
                          icon: SvgPicture.asset(phoneIco),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
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
                Navigator.of(context).pop(true); // Close the app
                BackButtonInterceptor.remove(_exitDialogInterceptor);
              },
            ),
          ],
        );
      },
    );
    return exit ?? false;
  }
}
