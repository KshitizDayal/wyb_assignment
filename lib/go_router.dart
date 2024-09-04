import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wyb_assignment/screens/home_screen.dart';
import 'package:wyb_ds/wyb_ds.dart';

import 'screens/splash_screen.dart';

final GoRouter router = GoRouter(
  routes: <GoRoute>[
    GoRoute(
      path: GoRouterConstants.splashScreen,
      builder: (BuildContext context, GoRouterState state) {
        return const SplashScreen();
      },
    ),
    GoRoute(
      path: GoRouterConstants.homeScreen,
      builder: (BuildContext context, GoRouterState state) {
        return const HomeScreen();
      },
    ),
  ],
);
