import 'package:flutter/material.dart';

import '../pages/addition_page/addition_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
      home: AdditionPage(),
    );
  }
}
