
void main() {

  // String text = "65995\n\n";
  // String text1 = "*65995";
  // String text2 = "*65*995";
  // print(removeBothEndsChar(text,patternText:"*"));
  // print(removeBothEndsChar(text1,patternText:"*"));
  // print(removeBothEndsChar(text2,patternText: "*"));
  re();
}

///去掉两端的指定字符
String removeBothEndsChar(String text, {String? patternText = "\n"}) {
  String _patternText = "$patternText";
 String pattern  = r'^(\\n?)(.\n?)(\\n?)$';

  // RegExp pattern =RegExp(r'^(\*?)(.*?)(\*?)$');
  // RegExp pattern =RegExp(r'^(\\n?)(.\n?)(\\n?)$');
  String newline = '\n';
  // RegExp pattern = RegExp(r'^($newline?)(.$newline?)($newline?)$');
  return text.replaceAllMapped(pattern, (Match match) {
    if (match.group(1) != null && match.group(3) != null) {
      return '${match.group(2)}'; // 去掉两端的字符
    }
    if (match.group(1) != null) {
      return '${match.group(2)}${match.group(3)}'; // 去掉左端的字符
    }
    if (match.group(3) != null) {
      return '${match.group(1)}${match.group(2)}'; // 去掉右端的字符
    }
    return text; // 不做任何处理
  });
}


void re(){
  String str = '\nHello\nWorld\n';
  print(str.runes);
  String trimmed = str.trimLeft().trimRight();
  print(trimmed.runes); // 输出: Hello\nWorld
  String rawStr = String.fromCharCodes(str.runes);
  print(rawStr);
}