import 'package:flutter/cupertino.dart';



class AppRouteDelegate extends RouterDelegate<Object> with ChangeNotifier {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      pages: [

      ],
      onPopPage: (route, result) {
        return true;
      },
    );
  }





  @override
  Future<bool> popRoute() async {
    print('=======popRoute=========');
    return true;
  }

  @override
  Future<void> setNewRoutePath(configuration) {
    // TODO: implement setNewRoutePath
    throw UnimplementedError();
  }
}
