import 'package:flutter/material.dart';

class PageOneDetails extends StatefulWidget {
  const PageOneDetails({Key? key}) : super(key: key);

  @override
  State<PageOneDetails> createState() => _PageOneDetailsState();
}

class _PageOneDetailsState extends State<PageOneDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PageOneDetails"),
      ),
      body: Container(
        height: double.infinity,
        color: Colors.blueGrey,
      ),
    );
  }
}
