///RouterDelegate 的职责是基于数据构建 NavigatorState并维护pages 列表。
///路由器的代理类是真正干活的人
///

import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';

import '../pages/counter/counter_page.dart';
import '../pages/empty/empty_page.dart';
import '../pages/home_page/home_page.dart';
import '../pages/settings/settings_page.dart';
import '../pages/user/user_page.dart';
import 'navigation/transition/fade_transition_page.dart';


const List<String> kDestinationsPaths = [
  '/homepage',
  '/counter',
  '/user',
  '/settings',
];

AppRouterDelegate router = AppRouterDelegate();

class AppRouterDelegate extends RouterDelegate<Object> with ChangeNotifier {
  String _path = '/homepage';

  String get path => _path;

  AppRouterDelegate() {
    // keepAlivePath.add('/color');
  }
  int? get activeIndex {
    if (path.startsWith('/homepage')) return 0;
    if (path.startsWith('/counter')) return 1;
    if (path.startsWith('/user')) return 2;
    if (path.startsWith('/settings')) return 3;
    return null;
  }
  @override
  Widget build(BuildContext context) {
    return Navigator(
      onPopPage: _onPopPage,
      pages: const [FadeTransitionPage(child:SettingPage()),FadeTransitionPage(child:CounterPage())],
    );
  }

  @override
  Future<bool> popRoute() async {
    print('=======popRoute=========');
    return true;
  }

  bool _onPopPage(Route route, result) {
    // if (_completerMap.containsKey(path)) {
    //   _completerMap[path]?.complete(result);
    //   _completerMap.remove(path);
    // }
    //
    // path = backPath(path);
    return route.didPop(result);
  }

  @override
  Future<void> setNewRoutePath(configuration) async {}
}
