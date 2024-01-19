import 'package:flutter/material.dart';

import '../pages/home_page/home_page.dart';
import 'app_route_delegate.dart';

class UnitApp extends StatelessWidget {
  const UnitApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          useMaterial3: false,
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
              elevation: 0,
              iconTheme: IconThemeData(color: Colors.black),
              titleTextStyle: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ))),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
            router2.path = "${router.path}/counter";

            return Row(children: [
              const Expanded(child: HomePage()),
              constraints.maxWidth>414?
              Expanded(
                child: Router(
                  routerDelegate: router2,
                  backButtonDispatcher: RootBackButtonDispatcher(),
                ),
              ):SizedBox(),
            ],);
          },
          )),
    );
  }
}
