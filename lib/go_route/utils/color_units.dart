import 'dart:math';
import 'dart:ui';

// 生成一个随机的RGB颜色值
class ColorUtils {
  static Color randomColor() {
    return Color.fromARGB(
      255,
      Random().nextInt(256), // 随机生成R值
      Random().nextInt(256), // 随机生成G值
      Random().nextInt(256), // 随机生成B值
    );
  }
}
