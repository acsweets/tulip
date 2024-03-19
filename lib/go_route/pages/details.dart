import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({Key? key}) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("详情页"),
      ),
      body: Container(
        color: Colors.orange,
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: ElevatedButton(
            onPressed: () => context.go('/'),
            child: const Text('Go back to the Home screen'),
          ),
        ),
      ),
    );
  }
}
