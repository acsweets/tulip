import 'package:flutter/material.dart';

class DetailsList extends StatelessWidget {
  const DetailsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details List'),
      ),
      body: ListView.builder(
        itemCount: 100,
        itemBuilder: (context, index) {
          return Card(
            color: Colors.greenAccent,
            child: ListTile(
              title: Text('(Index: $index)'),
            ),
          );
        },
      ),
    );
  }
}
