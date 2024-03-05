import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tulip/ext/8/route/route_delegate.dart';
import 'package:tulip/ext/8/sort_state/sort_state_scope.dart';
import 'package:tulip/ext/8/transitions/fade_page_transitions_builder.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const UnitApp());
}


class UnitApp extends StatelessWidget {
  const UnitApp({super.key});

  @override
  Widget build(BuildContext context) {

    return SortStateScope(
      notifier: SortState(),
      child: MaterialApp(
          theme: ThemeData(
              fontFamily: "宋体",
              scaffoldBackgroundColor: Colors.white,
              pageTransitionsTheme: const PageTransitionsTheme(
                  builders: {
                    TargetPlatform.android: ZoomPageTransitionsBuilder(),
                    TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
                    TargetPlatform.macOS: FadePageTransitionsBuilder(),
                    TargetPlatform.windows: FadePageTransitionsBuilder(),
                    TargetPlatform.linux: FadePageTransitionsBuilder(),
                  }
              ),
              appBarTheme: const AppBarTheme(
                  elevation: 0,
                  iconTheme: IconThemeData(color: Colors.black),
                  titleTextStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ))),
          debugShowCheckedModeBanner: false,
          home: HomePage()
      ),
    );
  }
}




class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Expanded(
        child: Router(
          routerDelegate: router,
          backButtonDispatcher: RootBackButtonDispatcher(),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(label: "颜色板", icon: Icon(Icons.color_lens_outlined)),
          BottomNavigationBarItem(label: "计数器", icon: Icon(Icons.add_chart)),
          BottomNavigationBarItem(label: "排序", icon: Icon(Icons.sort)),
          BottomNavigationBarItem(label: "我的", icon: Icon(Icons.person)),
          BottomNavigationBarItem(label: "设置", icon: Icon(Icons.settings)),
        ],
        // currentIndex: simpleRoute.activeIndex!,
        // onTap: _onRouterChange,
      ),
    );
  }
}
