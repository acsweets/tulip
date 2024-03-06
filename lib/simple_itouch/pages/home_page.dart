import 'package:flutter/material.dart';

import 'index.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const PageOne(),
    const PageTwo(),
    const PageThree(),
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Scaffold(
            body: _pages[_currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              items: const [
                BottomNavigationBarItem(label: "我的", icon: Icon(Icons.supervised_user_circle_outlined)),
                BottomNavigationBarItem(label: "主页", icon: Icon(Icons.home)),
                BottomNavigationBarItem(label: "设置", icon: Icon(Icons.settings)),
              ],
              currentIndex: _currentIndex,
              onTap: (index) {
                _currentIndex = index;
                setState(() {});
              },
            ),
          ),
        ),
      ],
    );
  }
}
