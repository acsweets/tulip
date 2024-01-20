import 'package:flutter/material.dart';

class SimpleInput extends StatelessWidget {
  const SimpleInput({super.key});

  @override
  Widget build(BuildContext context) {
    late final TextEditingController _seed = TextEditingController();
    return Container(
      child: TextField(
        controller: _seed,
        maxLines: 1,
        style: TextStyle(
            fontSize: 16,
            color: Colors.lightBlue,
            backgroundColor: Colors.white),
        decoration: const InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: "请输入",
          hintStyle: TextStyle(color: Colors.black26, fontSize: 16),
          contentPadding: EdgeInsets.only(left: 14.0, top: -16),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius:
            BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius:
            BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
          ),
        ),
        onChanged: (str) {
        },
        onTap: (){},
      )
    );
  }
}
