import 'package:flutter/material.dart';

class PageThreeDetails extends StatefulWidget {
  const PageThreeDetails({Key? key}) : super(key: key);

  @override
  State<PageThreeDetails> createState() => _PageOneDetailsState();
}

class _PageOneDetailsState extends State<PageThreeDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PageThreeDetails"),
      ),
      body: Container(
        height: double.infinity,
        color: Colors.deepPurpleAccent,
      ),
    );
  }
}
