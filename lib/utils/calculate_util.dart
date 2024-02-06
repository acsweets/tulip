import 'dart:io';

import 'package:flutter/material.dart';

double? initScale({required Size imageSize, required Size size, double? initialScale}) {
  var n1 = imageSize.height / imageSize.width;
  var n2 = size.height / size.width;
  if (n1 > n2) {
    final FittedSizes fittedSizes = applyBoxFit(BoxFit.contain, imageSize, size);
    //final Size sourceSize = fittedSizes.source;
    Size destinationSize = fittedSizes.destination;
    return size.width / destinationSize.width;
  } else if (n1 / n2 < 1 / 4) {
    final FittedSizes fittedSizes = applyBoxFit(BoxFit.contain, imageSize, size);
    //final Size sourceSize = fittedSizes.source;
    Size destinationSize = fittedSizes.destination;
    return size.height / destinationSize.height;
  }

  return initialScale;
}

dynamic doubleToInt(num? price) {
  if (Platform.isIOS) {
    return price != null ? price.toInt() : 0;
  }
  return price ?? 0;
}

bool isListEqual(List a, List b) {
  if (a == b) return true;
  if (a.length != b.length) return false;
  int i = 0;
  return a.every((e) => b[i++] == e);
}

/// 两个数组求交集
List intersection(List a, List b) {
  Set setA = a.toSet();
  Set setB = b.toSet();
  return setA.intersection(setB).toList();
}
