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
  late final TextEditingController _seed = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(" 加法计算 "),
      ),
      body: Column(
        children: [
          Container(
              child: TextField(
            controller: _seed,
            maxLines: 1,
            style: const TextStyle(fontSize: 16, color: Colors.lightBlue, backgroundColor: Colors.white),
            decoration: const InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hintText: "请输入",
              hintStyle: TextStyle(color: Colors.black26, fontSize: 16),
              contentPadding: EdgeInsets.only(left: 14.0, top: -16),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
              ),
            ),
            onChanged: (str) {},
            onTap: () {},
          )),
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
