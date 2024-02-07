import 'dart:async';

import 'package:flutter/material.dart';

import '../../simple_route/app/navigation/transition/fade_transition_page.dart';
import '../pages/page_one.dart';
import '../pages/page_one_details.dart';
import '../pages/page_three.dart';
import '../pages/page_two.dart';

SimpleRouteDelegate simpleRoute = SimpleRouteDelegate();

const List<String> kDestinationsPaths = ['/pageOne', '/pageTwo', '/pageThree'];

class SimpleRouteDelegate extends RouterDelegate<Object> with ChangeNotifier {
  //默认的路径，对默认的
  String _path = '/pageOne';

  String get path => _path;

  String _childrenPath = '/pageOne/pageOneDetails';

  String get childrenPath => _childrenPath;

  void setPathForData(String value, dynamic data) {
    path = value;
    notifyListeners();
  }

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
      pages: _buildPageByPath(path),
    );
  }

  List<Page> _buildPageByPath(String path) {
    Widget? child;
    if (path == kDestinationsPaths[0]) {
      child = const PageOne();
    }
    if (path == kDestinationsPaths[1]) {
      child = const PageTwo();
    }
    if (path == kDestinationsPaths[2]) {
      child = const PageThree();
    }

    if (path.startsWith('/pageOne')) {
      return buildOnePages(path);
    }
    return [
      FadeTransitionPage(
          // key: ValueKey(path),
          child: child ??
              Scaffold(
                body: Container(
                  child: Text("页面丢失啦~"),
                ),
              ))
    ];
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
          key: ValueKey('/pageOne/pageOneDetails'),
          child: PageOneDetails(),
        ));
      }
    }
    return result;
  }
}
