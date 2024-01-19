import 'package:flutter/material.dart';

import '../../../widget/button/animate_button.dart';
import '../../../widget/input/input_button.dart';

//此页面需要保持状态

class AdditionPage extends StatefulWidget {
  const AdditionPage({Key? key}) : super(key: key);

  @override
  State<AdditionPage> createState() => _AdditionPageState();
}

class _AdditionPageState extends State<AdditionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(" 加法计算 "),
      ),
      body: Column(
        children: [
          InputButton(

          ),


          AnimateButton(
            radius: 10,
            title: "计算",
            titleColor: Colors.white,
            onTap: () {},
          )
        ],
      ),
    );
  }
}
