import 'package:flutter/material.dart';

import '../../app/app_route_delegate/app_route_host_delegate.dart';
import '../../app/app_route_delegate/app_route_order_delegate.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Router(
        routerDelegate: hostRouter,
        backButtonDispatcher: RootBackButtonDispatcher(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(label: "我的", icon: Icon(Icons.supervised_user_circle_outlined)),
          BottomNavigationBarItem(label: "主页", icon: Icon(Icons.home)),
          BottomNavigationBarItem(label: "设置", icon: Icon(Icons.settings)),
        ],
        currentIndex: hostRouter.activeIndex!,
        onTap: _onRouterChange,
      ),
    );
  }

  void _onRouterChange(index) {
    if (index == 1) {
      hostRouter.setPathKeepLive(kDestinationsPaths[index]);
    } else {
      hostRouter.path = kDestinationsPaths[index];
    }
    setState(() {});
  }
}
