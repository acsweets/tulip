import 'package:flutter/material.dart';

class ThreeQuartersLayout extends SingleChildLayoutDelegate {

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    return BoxConstraints(
      maxHeight: constraints.maxHeight,
      maxWidth: constraints.maxWidth,
    );
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    double x = (size.width - childSize.width) *3 /4 ;
    double y = (size.height - childSize.height) *3/ 4;
    return Offset(x, y);
  }

  @override
  bool shouldRelayout(ThreeQuartersLayout oldDelegate) => false;
}

