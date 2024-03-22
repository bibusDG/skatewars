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
]);
}