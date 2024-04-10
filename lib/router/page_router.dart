import 'package:skatewars/core/constants/constants.dart';
import 'package:skatewars/features/show_skate_spots_page/presentation/pages/show_skate_spots_page.dart';
import 'package:skatewars/features/spot_details_page/presentation/pages/spot_details_page.dart';
import 'package:skatewars/features/user_relations/presentation/pages/user_login_page.dart';

import '../features/add_skate_spot_page/presentation/pages/add_skate_spot_page.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import '../features/start_page/presentation/pages/start_page.dart';

final rootNavigationKey = GlobalKey<NavigatorState>();

class MyPageRouter{
  GoRouter get myRouter => _myRouter;
  static final _myRouter = GoRouter(
    // initialLocation: '/show_skate_spots_page/:uid',
    navigatorKey: rootNavigationKey,
    routes: <RouteBase>[
  GoRoute(
  name: 'start_page', // Optional, add name to your routes. Allows you navigate by name instead of path
    path: '/',
    builder: (context, state) => const StartPage(),
  ),
  GoRoute(
    name: 'add_skate_spot_page', // Optional, add name to your routes. Allows you navigate by name instead of path
    path: '/add_skate_spot_page/:uid',
    builder: (context, state) {
      final userID = state.pathParameters['uid'];
      return AddSkateSpotPage(uid: userID!);
    },
  ),
  GoRoute(
    name: 'show_skate_spots_page', // Optional, add name to your routes. Allows you navigate by name instead of path
    path: '/show_skate_spots_page/:uid',
    builder: (context, state) {
      final userID = state.pathParameters['uid'];
      return ShowSkateSpotsPage(uid: userID!);
    },
  ),
  GoRoute(
    name: 'spot_details_page', // Optional, add name to your routes. Allows you navigate by name instead of path
    path: '/spot_details_page/:spotID/:uid',
    builder: (context, state) {
      final spotID = state.pathParameters['spotID'];
      final userID = state.pathParameters['uid'];
      return SpotDetailsPage(spotID: spotID!, uid: userID!,);
    },
  ),
  GoRoute(
    name: 'login_page', // Optional, add name to your routes. Allows you navigate by name instead of path
    path: '/login_page/:userLoggedIn/:uid',
    builder: (context, state) {
      final userIsLoggedIn = state.pathParameters['userLoggedIn'];
      final userID = state.pathParameters['uid'];
      return UserLoginPage(userLoggedIn: userIsLoggedIn!, uid: userID!,);
    },
  ),
]);
}