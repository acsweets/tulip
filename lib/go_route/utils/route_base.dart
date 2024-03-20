import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../pages/index.dart';

final List<RouteBase> routesLeft =  [
  GoRoute(
    path: '/',
    builder: (BuildContext context, GoRouterState state) {
      return const HomePage();
    },
    routes: routesBase,
  ),
];

//如果要构建查询参数，那么可以使用 Uri 类来构建路由路径。
//context.go(
//   Uri(
//     path: '/fruit-detail',
//     queryParameters: {'id': '10'},
//    ).toString(),
// );


///参数的传递
///GoRoute 对象时来配置路由参数。路由参数典型的就是路径参数，
///比如 /path/:{路径参数}，这个时候 GoRoute的路径参数和很多 Web 框架的路由是一样的
///，通过一个英文冒号加参数名称就可以配置，之后我们可以在回调方法中通过 GoRouterState
///对象获取路径参数，这个参数就可以传递到路由跳转目的页面
// 


final List<RouteBase> routesRight =  [
  GoRoute(
    path: '/',
    //直接buildr
    builder: (BuildContext context, GoRouterState state) {
      return const GoodsPage();
    },
    //传入page（page可以给widget包裹动画）
    // pageBuilder: (){},
    routes: routesBase,
  ),
];
final List<RouteBase> routesBase =  [
  GoRoute(
      path: 'goodsPage',
      builder: (BuildContext context, GoRouterState state) {
        return const GoodsPage();
      }),
  GoRoute(
    path: 'details',
    builder: (BuildContext context, GoRouterState state) {
      return const DetailsPage();

    },
    routes: [
      GoRoute(
          path: 'goodsPage',
          builder: (BuildContext context, GoRouterState state) {
            return const GoodsPage();
          }),
    ],
  ),
];