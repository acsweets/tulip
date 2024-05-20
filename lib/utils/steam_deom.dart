Stream<String> stream = Stream<String>.fromIterable(["不开心", "因为", "打王者", "连跪"]);

main() async {
  print("开始");
  await for (String s in stream) {
    print(s);
  }
  print("ending");
}
