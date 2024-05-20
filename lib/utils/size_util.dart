import 'package:flutter/material.dart';

const Size meter = Size(1440, 1024);

class SizeUtils {
//  当前的宽值为 定义的宽值乘 屏幕的宽值 /除以设计的值
  static double w(double w, double screenW) {
    return (w * screenW) / meter.width;
  }
  static double h( h, double screenH) {
    return (h * screenH) / meter.height;
  }
}
