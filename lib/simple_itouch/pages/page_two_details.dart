import 'package:flutter/material.dart';

class PageTwoDetails extends StatefulWidget {
  const PageTwoDetails({Key? key}) : super(key: key);

  @override
  State<PageTwoDetails> createState() => _PageOneDetailsState();
}

class _PageOneDetailsState extends State<PageTwoDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PageTwoDetails"),
      ),
      body: Container(
        height: double.infinity,
        color: Colors.orangeAccent,
      ),
    );
  }
}
