import 'package:flutter/material.dart';
import '../../utils/size_util.dart';

class LayoutPage extends StatefulWidget {
  final BoxConstraints constraints;

  const LayoutPage({Key? key, required this.constraints}) : super(key: key);

  @override
  State<LayoutPage> createState() => _LayoutPageState();
}

class _LayoutPageState extends State<LayoutPage> {
  @override
  Widget build(BuildContext context) {
    double _width = widget.constraints.maxWidth;
    double _height = widget.constraints.maxHeight;

    return Container(
        //由子填充
        color: const Color(0xffB8FFCC),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: SizeUtils.h(93, _height),
              color: const Color(0xff50EBCF),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: SizeUtils.w(304, _width),
                  height:SizeUtils.h(670, _height),
                  color: const Color(0xffFFDCEE),
                ),
                SizedBox(width:SizeUtils.w(30, _width) ,),
                SizedBox(
                  height: SizeUtils.h(800, _height),
                  width: SizeUtils.w(600, _width),
                  child: ListView.builder(
                    itemBuilder: (context, _) {
                      return Container(
                        margin: EdgeInsets.only(top: SizeUtils.h(20, _height)),
                        color: const Color(0xffffe7b6),
                        width: double.infinity,
                        height: SizeUtils.h(60, _height),
                      );
                    },
                    itemCount: 30,
                  ),
                ),
                SizedBox(width:SizeUtils.w(60, _width) ,),
                Column(
                  children: [
                    Container(
                      height: SizeUtils.h(139, _height),
                      width: SizeUtils.w(349, _width),
                      color: const Color(0xffFFB8C5),
                    ),
                    SizedBox(height:SizeUtils.h(50, _height) ,),
                    Container(
                      height: SizeUtils.h(213, _height),
                      width: SizeUtils.w(349, _width),
                      color: const Color(0xffD2D4FD),
                    ),
                    SizedBox(height:SizeUtils.h(50, _height) ,),
                    Container(
                      height: SizeUtils.h(117, _height),
                      width: SizeUtils.w(349, _width),
                      color: const Color(0xffFAE396),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ));
  }
}
