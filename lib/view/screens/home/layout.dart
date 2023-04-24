import 'package:cfl/shared/shared.dart';
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
        body: kTempScreens[_selectedIndex],
        bottomNavigationBar: SafeArea(
          child: Container(
            height: 100,
            color: Colors.transparent,
            padding:
                const EdgeInsets.only(left: 12, right: 12, bottom: 12, top: 5),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50.0),
              child: Container(
                padding: const EdgeInsets.all(12),
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
                    color: AppColors.accentColor,
                    shape: BoxShape.circle,
                  ),
                  tabs: const [
                    Tab(
                      icon: Icon(
                        Icons.home,
                        size: 20,
                      ),
                    ),
                    Tab(
                      icon: Icon(
                        Icons.track_changes_outlined,
                        size: 20,
                      ),
                    ),
                    Tab(
                      icon: Icon(
                        Icons.add_road,
                        size: 20,
                      ),
                    ),
                    Tab(
                      icon: Icon(
                        Icons.catching_pokemon_rounded,
                        size: 20,
                      ),
                    ),
                    Tab(
                      icon: Icon(
                        Icons.map,
                        size: 20,
                      ),
                    ),
                    Tab(
                      icon: Icon(
                        Icons.wb_incandescent_outlined,
                        size: 20,
                      ),
                    ),
                    Tab(
                      icon: Icon(
                        Icons.file_copy,
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
    );
  }
}
