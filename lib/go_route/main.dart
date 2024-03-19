import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tulip/go_route/utils/index.dart';

void main() {
  runApp(const MyApp());
}

final GoRouter routerL = GoRouter(
  routes: routesLeft,
);

final GoRouter routerR = GoRouter(
  routes: routesRight,
);

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Row(
        children: [
          Expanded(child: Router.withConfig(config: routerL)),
          Expanded(child: Router.withConfig(config: routerR)),
        ],
      ),
    );
  }
}
