import 'package:flutter/material.dart';
import 'package:tulip/simple_itouch/pages/home_page.dart';
import 'package:tulip/simple_itouch/route/simple_route_delegate.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        double width = constraints.maxWidth;

        // 根据屏幕大小执行操作
        if (width > 414) {
         leftRoute.trimPathTail(leftRoute.path);

        } else if (rightRoute.path != "/detailsList") {
         leftRoute.path += rightRoute.path;
        }

        return Row(
          children: [
            Expanded(
                child: Router(
              routerDelegate: leftRoute,
              backButtonDispatcher: RootBackButtonDispatcher(),
            )),
            constraints.maxWidth > 414
                //折起来的时候如果右path不问空，就把右的路径给左
                ? Expanded(
                    child: Router(
                      routerDelegate: rightRoute,
                      backButtonDispatcher: RootBackButtonDispatcher(),
                    ),
                  )
                : const SizedBox(),
          ],
        );
      },
    ));
  }
}
