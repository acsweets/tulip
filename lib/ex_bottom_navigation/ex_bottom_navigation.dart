import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tulip/ex_bottom_navigation/image.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bottom_Navigation_dome',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  List<Widget> pages = [
    PageOne(),
    PageTwo(),
    PageThree(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 12.0,
        // 被选中时的字体大小
        unselectedFontSize: 14.0,
        // 未被选中时的字体大小
        showSelectedLabels: true,
        // 被选中时是否显示Label
        showUnselectedLabels: true,
        // 未被选中时是否显示Label
        enableFeedback: true,
        //点击会产生咔嗒声，长按会产生短暂的振动
        selectedItemColor: Colors.orange,
        // 设置被选中时的图标颜色     size: 24.0,

        unselectedItemColor: Colors.grey,
        // 设置未被选中时的图标颜色
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: '工作室',
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event_note, size: 24.0),
            label: '数据',
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, size: 24.0),
            label: '我的',
            backgroundColor: Colors.white,
          ),
        ],

        // 设置当前（即被选中时）页面
        currentIndex: _selectedIndex,

        // 当点击其中一个[items]被触发
        onTap: (int index) {
          _selectedIndex = index;
          setState(() {
            /*
       * item 被点中时更改当前索引。
       * 其中，currentIndex 字段设置的值时响应式的
       * 新版dart不用this.
       */
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}

class PageOne extends StatefulWidget {
  const PageOne({Key? key}) : super(key: key);

  @override
  State<PageOne> createState() => _PageOneState();
}

class _PageOneState extends State<PageOne> {
  // double _x = 0.0;
  // double _y = 0.0;

  final _controller = TextEditingController();
  String _text = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("页面1"),
      ),
      body: /* Container(
        width: double.infinity,
        height: double.infinity,
        child:  Stack(
          children: [
            Positioned(
              left: _x,
              top: _y,
              child: GestureDetector(
                onPanUpdate: (details) {
                  setState(() {
                    _x += details.delta.dx;
                    _y += details.delta.dy;
                    print(details.delta.dx);
                    print(details.delta.dx);

                  });
                },
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
          ],
        ),
*/

          Column(
        children: [
          // Text("这是一个文本超出会显示点点点点点点点点点点点点点点点点点点点点点",
          //     style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.cyan),
          //     overflow: TextOverflow.ellipsis),
          //
          // /// 通常用于加载二进制的图片 ,image1是二进制字符串
          // Image.memory(const Base64Decoder().convert(image1)),
          //
          // BackButton(),
          // TextButton(
          //   onPressed: () {},
          //   child: Text("Back"),
          // ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: '文本',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _text = value;
                });
              },
            ),
          ),
          SizedBox(height: 16),
          Text('你的输入: $_text'),
        ],
      ),
    );
  }
}

class PageTwo extends StatelessWidget {
  const PageTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("页面2"),
      ),
      body: Container(width: double.infinity, height: double.infinity, color: Colors.red),
    );
  }
}

class PageThree extends StatelessWidget {
  const PageThree({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("页面3"),
      ),
      body: Container(width: double.infinity, height: double.infinity, color: Colors.orangeAccent),
    );
  }
}
