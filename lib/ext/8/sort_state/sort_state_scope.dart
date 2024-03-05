import 'package:flutter/cupertino.dart';

enum SortStatus {
  none, // 未操作
  sorting, // 排序中
  sorted, // 排序完成
}

class SortState with ChangeNotifier {
  SortState() {}

  SortStatus status = SortStatus.none;

  void  selectName(){

  }


}

class SortStateScope extends InheritedNotifier<SortState> {
  const SortStateScope({super.key, required super.notifier, required super.child});

  static SortState of(BuildContext context) => context.dependOnInheritedWidgetOfExactType<SortStateScope>()!.notifier!;
}
