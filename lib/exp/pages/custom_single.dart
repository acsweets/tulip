import 'package:flutter/material.dart';
import 'custom/single.dart';
class CustomSingle extends StatefulWidget {
  const CustomSingle({Key? key}) : super(key: key);

  @override
  State<CustomSingle> createState() => _CustomSingleState();
}

class _CustomSingleState extends State<CustomSingle> {
  @override
  Widget build(BuildContext context) {
    return CustomSingleChildLayout(
        delegate: ThreeQuartersLayout(),
        child: Container(
          width:50,
          height: 50,
          color: const Color(0xff7AAAEA),
        ),
      );
  }
}
