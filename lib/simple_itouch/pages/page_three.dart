import 'package:flutter/material.dart';

class PageThree extends StatefulWidget {
  const PageThree({Key? key}) : super(key: key);

  @override
  State<PageThree> createState() => _PageThreeState();
}

class _PageThreeState extends State<PageThree> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PageThree"),
      ),
      body: Container(
        height: double.infinity,
        color: Colors.amberAccent,
        child: GestureDetector(
            onTap: () {},
            child: const SizedBox(
              height: 10,
              width: double.infinity,
              child: Text("去详情"),
            )),
      ),
    );
  }
}
