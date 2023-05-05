import 'package:cfl/view/screens/feed/all_feed.dart';
import 'package:cfl/view/screens/home/home_screen.dart';
import 'package:cfl/view/screens/home/all_intiatives_screen.dart';
import 'package:cfl/view/screens/home/map.dart';
import 'package:cfl/view/screens/profile/badges.dart';
import 'package:cfl/view/screens/profile/help_center.dart';
import 'package:cfl/view/screens/profile/leaderboard.dart';

const kTempScreens = [
  HomeScreen(),
  InitiativeScreen(),
  BadgesScreen(showAppBar: false),
  MapScreen(),
  LeaderboardScreen(showAppBar: false),
  AllFeedScreen(),
  HelpCenter(showAppBar: false),
];
