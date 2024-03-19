import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../pages/index.dart';

final List<RouteBase> routesLeft =  [
  GoRoute(
    path: '/',
    builder: (BuildContext context, GoRouterState state) {
      return const HomePage();
    },
    routes: routesBase,
  ),
];


final List<RouteBase> routesRight =  [
  GoRoute(
    path: '/',
    builder: (BuildContext context, GoRouterState state) {
      return const GoodsPage();
    },
    routes: routesBase,
  ),
];
final List<RouteBase> routesBase =  [
  GoRoute(
      path: 'goodsPage',
      builder: (BuildContext context, GoRouterState state) {
        return const GoodsPage();
      }),
  GoRoute(
    path: 'details',
    builder: (BuildContext context, GoRouterState state) {
      return const DetailsPage();
    },
  ),
];