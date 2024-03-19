import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tulip/simple_itouch/index.dart';
import '../../simple_route/app/navigation/transition/fade_transition_page.dart';

//初始路由是固定的  右边路由退完了回到固定路由
//点击左边右边路由改变，点击右边左右都改变

SimpleRouteDelegate leftRoute = SimpleRouteDelegate(Keys.left);
SimpleRouteDelegate rightRoute = SimpleRouteDelegate(Keys.right);

class SimpleRouteDelegate extends RouterDelegate<Object> with ChangeNotifier {
  final String routing;

  //默认的路径，对默认的
  String _path = "";
  String _basePath = "";
  SimpleRouteDelegate(this.routing) {
    if (routing == Keys.left) {
      _basePath = '/homePage';
      _path =_basePath;
    } else {
      _basePath = '/detailsList';
      _path =_basePath;
    }
  }

  String get path => _path;

  void setPathForData(String value, dynamic data) {
    path = "$_basePath$value";
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
//会在操作系统的返回事件时被触发。比如移动端的返回手势、web 的导航回退。
  @override
  Future<bool> popRoute() async {
    print('=======popRoute=========');
    return true;
  }

  @override
  Future<void> setNewRoutePath(configuration) async {}


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
  String trimPathTail(String path) {
    //找到最后一个/的索引，然后截取
    final separatorIndex = path.lastIndexOf('/');
    if (separatorIndex != -1 && separatorIndex != path.length - 1) {
      return path.substring(0, separatorIndex);
    }
    return path;
  }

  List<Page> pathBuildPages(String path) {
    List<Page> result = [];
    Uri uri = Uri.parse(path);
    String parentPath = '';
    for (int i = 0; i < uri.pathSegments.length; i++) {
      String segment = uri.pathSegments[i];
      parentPath += '/$segment';
      result.add(FadeTransitionPage(
        key: ValueKey(parentPath),
        child: routes[segment] ?? const EmptyPage(),
      ));
    }
    return result;
  }
}


main() {
  String path = "/pageOne/pageOneDetails";
}
