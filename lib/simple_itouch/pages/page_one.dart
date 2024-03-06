import 'package:flutter/material.dart';
import 'package:tulip/simple_itouch/route/simple_route_delegate.dart';

class PageOne extends StatefulWidget {
  const PageOne({Key? key}) : super(key: key);

  @override
  State<PageOne> createState() => _PageOneState();
}

class _PageOneState extends State<PageOne> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PageOne"),
      ),
      body: Container(
        height: double.infinity,
        color: Colors.orange,
        child: GestureDetector(
            onTap: () {
              rightRoute.setPathForData("/pageOneDetails", "data");
            },
            child: const SizedBox(
              height: 10,
              width: double.infinity,
              child: Text("去详情"),
            )),
      ),
    );
  }
}
