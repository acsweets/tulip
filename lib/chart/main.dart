import 'package:flutter/material.dart';

import 'home.dart';
import 'pages/bigdata.dart';
import 'pages/debug.dart';
import 'pages/echarts.dart';
import 'pages/interaction_stream_dynamic.dart';
import 'pages/interval.dart';
import 'pages/line_area_point.dart';
import 'pages/polygon_custom.dart';
import 'pages/animation.dart';

final routes = {
  '/': (context) => const HomePage(),
  '/examples/Interval': (context) => IntervalPage(),
  '/examples/Line,Area,Point': (context) => LineAreaPointPage(),
  '/examples/Polygon,Custom': (context) => PolygonCustomPage(),
  '/examples/Interaction Stream, Dynamic': (context) =>
  const InteractionStreamDynamicPage(),
  '/examples/Animation': (context) => const AnimationPage(),
  '/examples/Bigdata': (context) => BigdataPage(),
  '/examples/Echarts': (context) => EchartsPage(),
  '/examples/Debug': (context) => DebugPage(),
};

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: routes,
      initialRoute: '/',
    );
  }
}

void main() => runApp(const MyApp());

///在 Graphic 的实现上，接口和类名的设计主要参考了 AntV。核心概念如下：
//
// Geom：几何标记，组成图表的几何图形
// Coord：坐标系，图表的坐标系，目前有笛卡尔坐标系（Rect）和极坐标系（Polar）
// Scale：度量，将数据缩放到 [0, 1] 的区间，以便映射到视觉通道属性
// Attr：视觉通道属性，包括位置、颜色、形状、大小等，值由经过度量变换的数据决定，被应用到几何标记上
// 这些概念对于了解图形语法的人，特别是使用过 AntV 的人应该不陌生，如果没有接触过可以参考 AntV 的文档 。我们认为图形语法将会是未来数据可视化发展的大方向，不管现在是否使用相关的可视化库，图形语法都是值得学习了解的。
///在图形语法中，variable 是个很重要的概念，它的定义是：对象（object）的集合、值（value）的集合、以及从对象到值的映射；与之对立的是 varset (variable set) 的概念，它的定义是值的集合、对象的集合、以及从值到集合的对象，映射关系刚好反转。