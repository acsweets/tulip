///RouterDelegate 的职责是基于数据构建 NavigatorState并维护pages 列表。
///路由器的代理类是真正干活的人
///

import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';

import '../../pages/counter/counter_page.dart';
import '../../pages/empty/empty_page.dart';
import '../../pages/home_page/home_page.dart';
import '../../pages/settings/settings_page.dart';
import '../../pages/user/user_page.dart';
import '../navigation/transition/fade_transition_page.dart';

//使用一个路由代理类管理两边的路由《  》（右边为默认路由，但由左边控制 ）
//通过操控 path 操控pages的页面栈  可以实现路由树解析 传入的节点
//  左边操作右边的数据就行了  ,数据 = 路由内容
const List<String> kDestinationsPaths = [
  '/user',
  '/counter',
  '/settings',
];

AppRouterHostDelegate hostRouter = AppRouterHostDelegate();

class AppRouterHostDelegate extends RouterDelegate<Object> with ChangeNotifier {
  String _path = '/counter';

  String get path => _path;

  // 保持活性
  final List<String> keepAlivePath = [];

  void setPathKeepLive(String value) {
    if (keepAlivePath.contains(value)) {
      keepAlivePath.remove(value);
    }
    keepAlivePath.add(value);
    path = value;
  }

  set path(String value) {
    if (_path == value) return;
    _path = value;
    notifyListeners();
  }

  AppRouterHostDelegate() {
    // keepAlivePath.add('/color');
  }

  int? get activeIndex {
    if (path.startsWith('/user')) return 0;
    if (path.startsWith('/counter')) return 1;
    if (path.startsWith('/settings')) return 2;
    return null;
  }



  @override
  Widget build(BuildContext context) {
    return Navigator(
      onPopPage: _onPopPage,
      pages: _buildPages(path),
    );
  }



  List<Page> _buildPages(path) {
    List<Page> pages = [];
    List<Page> topPages = _buildPageByPath(path);

    if (keepAlivePath.isNotEmpty) {
      for (String alivePath in keepAlivePath) {
        if (alivePath != path) {
          pages.addAll(_buildPageByPath(alivePath));
        }
      }
      /// 去除和 topPages 中重复的界面
      pages.removeWhere(
              (element) => topPages.map((e) => e.key).contains(element.key));
    }
    pages.addAll(topPages);
    return pages;
  }

  List<Page> _buildPageByPath(String path) {
    Widget? child;
    // if (path == kDestinationsPaths[0]) {
    //   child = const ColorPage();
    // }
    if (path == kDestinationsPaths[0]) {
      child = const UserPage();
    }
    if (path == kDestinationsPaths[1]) {
      child = const CounterPage();
    }
    if (path == kDestinationsPaths[2]) {
      child = const SettingPage();
    }
    return [
      FadeTransitionPage(
        key: ValueKey(path),
        child: child ?? const EmptyPage(),
      )
    ];
  }

  @override
  Future<bool> popRoute() async {
    print('=======popRoute=========');
    return true;
  }

  bool _onPopPage(Route route, result) {
    return route.didPop(result);
  }

  @override
  Future<void> setNewRoutePath(configuration) async {}
}
