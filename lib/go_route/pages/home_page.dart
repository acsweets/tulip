import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../main.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("主页"),
        ),
        body: Container(
          color: Colors.green,
          height: double.infinity,
          width: double.infinity,
          child: Center(
            child: ElevatedButton(
              onPressed: () => routerL.go('/goodsPage'),
              child: const Text('Go to the Details screen'),
            ),
          ),
        ));
  }
}
