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

AppRouterOrderDelegate orderRouter = AppRouterOrderDelegate();

class AppRouterOrderDelegate extends RouterDelegate<Object> with ChangeNotifier {
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

  AppRouterOrderDelegate() {
    // keepAlivePath.add('/color');
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
      pages.removeWhere((element) => topPages.map((e) => e.key).contains(element.key));
    }

    pages.addAll(topPages);
    return pages;
  }

  List<Page> _buildPageByPath(String path) {
    Widget? child;
    // if (path == kDestinationsPaths[0]) {
    //   child = const ColorPage();
    // }
    // if (path == kDestinationsPaths[0]) {
    //   child = const UserPage();
    // }
    if (path == "/counter") {
      child = const CounterPage();
    }
    // if (path == kDestinationsPaths[2]) {
    //   child = const SettingPage();
    // }
    return [
      FadeTransitionPage(
        key: ValueKey(path),
        child: child ?? const EmptyPage(),
      )
    ];
  }

  List<Page> buildColorPages(String path) {
    List<Page> result = [];
    Uri uri = Uri.parse(path);
    for (String segment in uri.pathSegments) {
      // if (segment == 'color') {
      //   result.add(const FadeTransitionPage(
      //     key: ValueKey('/color'),
      //     child: ColorPage(),
      //   ));
      // }
      // if (segment == 'detail') {
      //   final Map<String, String> queryParams = uri.queryParameters;
      //   String? selectedColor = queryParams['color'];
      //   if (selectedColor != null) {
      //     Color color = Color(int.parse(selectedColor, radix: 16));
      //     result.add(FadeTransitionPage(
      //       key: const ValueKey('/color/detail'),
      //       child: ColorDetailPage(color: color),
      //     ));
      //   } else {
      //     Color? selectedColor = _pathExtraMap[path];
      //     if (selectedColor != null) {
      //       result.add(FadeTransitionPage(
      //         key: const ValueKey('/color/detail'),
      //         child: ColorDetailPage(color: selectedColor),
      //       ));
      //       _pathExtraMap.remove(path);
      //     }
      //   }
      // }
      // if (segment == 'add') {
      //   result.add(const FadeTransitionPage(
      //     key: ValueKey('/color/add'),
      //     child: ColorAddPage(),
      //   ));
      // }
    }
    return result;
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
