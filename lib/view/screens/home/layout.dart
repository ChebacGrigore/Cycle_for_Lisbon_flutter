import 'package:cfl/shared/shared.dart';
import 'package:cfl/view/styles/cfl_icons.dart';
import 'package:cfl/view/styles/colors.dart';
import 'package:flutter/material.dart';

class Layout extends StatefulWidget {
  const Layout({super.key});

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: kTempScreens.length,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Stack(
          children: [
            kTempScreens[_selectedIndex],
            Align(
              alignment: Alignment.bottomCenter,
              child: SafeArea(
                child: Container(
                  height: 80,
                  color: Colors.transparent,
                  padding: const EdgeInsets.only(
                      left: 12, right: 12, bottom: 12, top: 5),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Container(
                      padding: const EdgeInsets.all(5),
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
                        onTap: (x) {
                          setState(() {
                            _selectedIndex = x;
                          });
                        },
                        labelColor: AppColors.primaryColor,
                        unselectedLabelColor: Colors.white.withOpacity(0.40),
                        splashBorderRadius: BorderRadius.circular(50.0),
                        indicator: const BoxDecoration(
                          color: AppColors.secondaryColor,
                          shape: BoxShape.circle,
                        ),
                        tabs: const [
                          Tab(
                            icon: Icon(
                              CFLIcons.home,
                              size: 20,
                            ),
                          ),
                          Tab(
                            icon: Icon(
                              CFLIcons.target,
                              size: 20,
                            ),
                          ),
                          Tab(
                            icon: Icon(
                              CFLIcons.roadhz,
                              size: 20,
                            ),
                          ),
                          Tab(
                            icon: Icon(
                              CFLIcons.map,
                              size: 20,
                            ),
                          ),
                          Tab(
                            icon: Icon(
                              CFLIcons.crown1,
                              size: 20,
                            ),
                          ),
                          Tab(
                            icon: Icon(
                              CFLIcons.newspaper1,
                              size: 20,
                            ),
                          ),
                          Tab(
                            icon: Icon(
                              Icons.phone_in_talk_outlined,
                              size: 20,
                            ),
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
      ),
    );
  }
}
