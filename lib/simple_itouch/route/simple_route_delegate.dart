import 'package:flutter/cupertino.dart';


SimpleRouteDelegate simpleRoute = SimpleRouteDelegate();

const List<String> kDestinationsPaths = ['/pageOne', '/pageTwo', '/pageThree', ];

class SimpleRouteDelegate extends RouterDelegate<Object> with ChangeNotifier{

  //默认的路径，对默认的
  String _path = '/pageOne';

  String get path => _path;




  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

  @override
  Future<bool> popRoute() {
    // TODO: implement popRoute
    throw UnimplementedError();
  }

  @override
  Future<void> setNewRoutePath(Object configuration) {
    // TODO: implement setNewRoutePath
    throw UnimplementedError();
  }

  int? get activeIndex {
    // if (path.startsWith('/color')) return 0;
    // if (path.startsWith('/counter')) return 1;
    // if (path.startsWith('/user')) return 2;
    // if (path.startsWith('/settings')) return 3;
    return null;
  }





}