import 'package:domi_assignment/feature/app_apearance/presentation/AppAppearance.dart';
import 'package:domi_assignment/feature/map_screen/presentation/pages/HomePage.dart';
import 'package:domi_assignment/routes/app_route_constants.dart';
import 'package:domi_assignment/feature/splash_screen/presentation/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final AppRouter _instance = AppRouter._internal(); 

  factory AppRouter() {
    return _instance;
  }

  AppRouter._internal();

  GoRouter router = GoRouter(
    routes: [
      GoRoute(
        name: MyAppRouteConstant.splashScreenRoute,
        path: '/',
        pageBuilder: (context, state) {
          return MaterialPage(child: SplashScreen());
        },
      ),
      GoRoute(
        name: MyAppRouteConstant.homeScreenRoute,
        path: '/home',
        pageBuilder: (context, state) {
          return MaterialPage(child: HomeScreen());
        },
      ),
      GoRoute(
        name: MyAppRouteConstant.appearanceScreenRoute,
        path: '/appearance',
        pageBuilder: (context, state) {
          return MaterialPage(child: AppearanceSettingsPage());
        },
      ),
    ],
    errorPageBuilder: (context, state) {
      return const MaterialPage(
        child: Center(
          child: Text('Error In Router'),
        ),
      );
    },
  );
}
