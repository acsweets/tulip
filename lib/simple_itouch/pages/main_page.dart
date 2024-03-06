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
        return Row(
          children: [
            Expanded(
                child: Router(
              routerDelegate: leftRoute,
              backButtonDispatcher: RootBackButtonDispatcher(),
            )),
            constraints.maxWidth > 414
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
