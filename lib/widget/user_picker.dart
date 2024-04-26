import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// NumberP(
/// initialValue: 50,
/// minValue: 0,
/// maxValue: 100,
/// onChanged: (int value) {
///print('Selected value: $value');
/// },
///),
/// CustomCupertinoPicker()

class NumberP extends StatefulWidget {
  final int initialValue;
  final int minValue;
  final int maxValue;
  final ValueChanged<int> onChanged;

  NumberP({
    Key? key,
    this.initialValue = 0,
    this.minValue = 0,
    this.maxValue = 100,
    required this.onChanged,
  }) : super(key: key);

  @override
  _NumberPState createState() => _NumberPState();
}

class _NumberPState extends State<NumberP> {
  late int _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPicker(
      itemExtent: 50.0,
      onSelectedItemChanged: (int index) {
        setState(() {
          _selectedValue = widget.minValue + index;
        });
        widget.onChanged(_selectedValue);
      },
      children: List<Widget>.generate(
        widget.maxValue - widget.minValue + 1,
        (int index) {
          return Center(
            child: Text('${widget.minValue + index}'),
          );
        },
      ),
    );
  }
}

class CustomCupertinoPicker extends StatelessWidget {
  final names = ['Java', 'Kotlin', 'Dart', 'Swift', 'C++', 'Python', "JavaScript", "PHP", "Go", "Object-c"];

  CustomCupertinoPicker({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // key: GlobalKey(),
      height: 150,
      width: 300,
      child: CupertinoPicker(
          backgroundColor: CupertinoColors.systemGrey.withAlpha(33),
          diameterRatio: 1,
          offAxisFraction: 0.2,
          squeeze: 1.5,
          itemExtent: 40,
          onSelectedItemChanged: (position) {
            print('当前条目  ${names[position]}');
          },
          children: names.map((e) => Center(child: Text(e))).toList()),
    );
  }
}
