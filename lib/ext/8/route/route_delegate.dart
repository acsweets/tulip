import 'package:flutter/cupertino.dart';
import 'package:tulip/ext/8/route/route_config.dart';
import 'package:tulip/ext/8/route/route_history_manager.dart';

AppRouterDelegate router = AppRouterDelegate(initial: IRouteConfig(uri: Uri.parse('/color')));

class AppRouterDelegate extends RouterDelegate<Object> with ChangeNotifier {
  /// 核心数据，路由配置数据列表
  final List<IRouteConfig> _configs = [];

  //当前的是路由表的最后一个
  IRouteConfig get current => _configs.last;

  final RouteHistoryManager _historyManager = RouteHistoryManager();

  RouteHistoryManager get historyManager => _historyManager;
  AppRouterDelegate({required IRouteConfig initial,}){
    _configs.add(initial);
    _historyManager.recode(initial);
  }


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


}
