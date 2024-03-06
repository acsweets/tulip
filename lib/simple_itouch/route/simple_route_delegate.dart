import 'dart:async';

import 'package:flutter/material.dart';

import '../../simple_route/app/navigation/transition/fade_transition_page.dart';
import '../pages/index.dart';
import '../utils/route.dart';

//初始路由是固定的  右边路由退完了回到固定路由
//点击左边右边路由改变，点击右边左右都改变

SimpleRouteDelegate leftRoute = SimpleRouteDelegate("left");
SimpleRouteDelegate rightRoute = SimpleRouteDelegate("right");

class SimpleRouteDelegate extends RouterDelegate<Object> with ChangeNotifier {
  final String routing;

  //默认的路径，对默认的
  String _path = "";

  SimpleRouteDelegate(this.routing) {
    if (routing == "left") {
      _path = '/homePage';
    } else {
      _path = '/detailsList';
    }
  }

  String get path => _path;

  void setPathForData(String value, dynamic data) {
    path = "/detailsList$value";
    notifyListeners();
  }

  //左边的路由控制右边的路由

  ///这个有啥用？
  final Map<String, Completer<dynamic>> _completerMap = {};
  Completer<dynamic>? completer;

  Future<dynamic> changePathForResult(String value) async {
    Completer<dynamic> completer = Completer();
    _completerMap[value] = completer;
    path = value;
    return completer.future;
  }

  set path(String value) {
    if (_path == value) return;
    _path = value;
    notifyListeners();
  }

  bool _onPopPage(Route route, result) {
    if (_completerMap.containsKey(path)) {
      _completerMap[path]?.complete(result);
      _completerMap.remove(path);
    }

    path = backPath(path);
    return route.didPop(result);
  }

  //移除最后一个uri
  String backPath(String path) {
    Uri uri = Uri.parse(path);
    if (uri.pathSegments.length == 1) return path;
    List<String> parts = List.of(uri.pathSegments)..removeLast();
    return '/${parts.join('/')}';
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onPopPage: _onPopPage,
      pages: pathBuildPages(path),
    );
  }

  @override
  Future<bool> popRoute() async {
    print('=======popRoute=========');
    return true;
  }

  @override
  Future<void> setNewRoutePath(configuration) async {}

  int? get activeIndex {
    if (path.startsWith('/pageOne')) return 0;
    if (path.startsWith('/pageTwo')) return 1;
    if (path.startsWith('/pageThree')) return 2;
    return null;
  }

  List<Page> buildOnePages(String path) {
    List<Page> result = [];
    Uri uri = Uri.parse(path);
    for (String segment in uri.pathSegments) {
      if (segment == 'pageOne') {
        result.add(const FadeTransitionPage(
          key: ValueKey('/pageOne'),
          child: PageOne(),
        ));
      }
      if (segment == 'pageOneDetails') {
        result.add(const FadeTransitionPage(
          //key相同便不会重建
          key: ValueKey('/pageOne/pageOneDetails'),
          child: PageOneDetails(),
        ));
      }
    }
    return result;
  }
}

List<Page> pathBuildPages(String path) {
  List<Page> result = [];
  Uri uri = Uri.parse(path);
  for (String segment in uri.pathSegments) {
    result.add(FadeTransitionPage(
      //key相同便不会重建
      //这么生成key会有问题 如果是使用同一个页面不同物品的详情，没有重建
      key: ValueKey(segment),
      child: routes[segment] ?? const EmptyPage(),
    ));
  }
  return result;
}

main() {
  String path = "/pageOne/pageOneDetails";
  pathBuildPages(path);
}
