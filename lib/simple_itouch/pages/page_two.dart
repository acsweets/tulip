import 'package:flutter/material.dart';
import 'package:tulip/simple_itouch/route/simple_route_delegate.dart';

class PageTwo extends StatefulWidget {
  const PageTwo({Key? key}) : super(key: key);

  @override
  State<PageTwo> createState() => _PageTwoState();
}

class _PageTwoState extends State<PageTwo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PageTwo"),
      ),
      body: Container(
        height: double.infinity,
        color: Colors.red,
        child: GestureDetector(
            onTap: () {
              rightRoute.setPathForData("/pageTwoDetails", "data");
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
