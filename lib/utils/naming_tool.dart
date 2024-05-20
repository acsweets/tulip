import 'dart:math';

const List<String> projectNames = [
  "Chinese rose", //月季
  "violet", //紫罗兰；
  "cotton tree", //木棉
  // "lilac", //c
  // "lily", //百合
  "wall flower", //紫罗兰
  "peach", //桃花
  // "wisteria", //紫藤
  " tree peony", //牡丹
  "peony", //芍药
  "camellia", //茶花
  " cape jasmine", //栀子花
  "cockscomb", //鸡冠花；
  "honeysuckle", //金银花；
  "chrysanthemum", //菊花；
  // "carnation", // 康乃馨；
  "orchid", //兰花；
  "jasmine", //茉莉花；
  "daffodil", //水仙花；
  // "peony", //牡丹；
  "begonia", //秋海棠；
  // "cactus", //仙人掌；
  // "poppy", //罂粟；
];

void main() {
  print(randomName(projectNames));
}

String randomName(List<String> names) {
  return names[ Random().nextInt(names.length)];
}
