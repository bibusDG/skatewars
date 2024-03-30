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
    navigatorKey: rootNavigationKey,
    routes: <RouteBase>[
  GoRoute(
  name: 'start_page', // Optional, add name to your routes. Allows you navigate by name instead of path
    path: '/',
    builder: (context, state) => const StartPage(),
  ),
  GoRoute(
    name: 'add_skate_spot_page', // Optional, add name to your routes. Allows you navigate by name instead of path
    path: '/add_skate_spot_page',
    builder: (context, state) => const AddSkateSpotPage(),
  ),
  GoRoute(
    name: 'show_skate_spots_page', // Optional, add name to your routes. Allows you navigate by name instead of path
    path: '/show_skate_spots_page',
    builder: (context, state) => const ShowSkateSpotsPage(),
  ),
  GoRoute(
    name: 'spot_details_page', // Optional, add name to your routes. Allows you navigate by name instead of path
    path: '/spot_details_page/:spotID',
    builder: (context, state) {
      final spotID = state.pathParameters['spotID'];
      return SpotDetailsPage(spotID: spotID!);
    },
  ),
  GoRoute(
    name: 'login_page', // Optional, add name to your routes. Allows you navigate by name instead of path
    path: '/login_page/:userLoggedIn',
    builder: (context, state) {
      final userIsLoggedIn = USER_LOGGED_IN;
      return UserLoginPage(userLoggedIn: userIsLoggedIn);
    },
  ),
]);
}