import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:ui';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:tulip/exp/pages/custom_single.dart';
import 'package:tulip/exp/pages/layout.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        builder: BotToastInit(),
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: Scaffold(
          // body: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
          //   print(constraints);
          //   return  LayoutPage( constraints: constraints);
          // },
          // ),

          body:Center(
            child:Container(
              width:200,
              height: 200,
              color: const Color(0xff24B718),
              child: CustomSingle(),
            ),
          )
        ));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Column(
                  children: [
                    Row(
                      children: [],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showMyDialog(context),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Future<void> _showMyDialog(BuildContext context) async {
    return showDialog(
      context: context,
      barrierDismissible: false, // 用户必须点击按钮才能关闭对话框
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Dialog '),
          content: const Text("内容"),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                // BotToast.showText(text: "11111");
                Navigator.pop(context);
                // Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

// PictureRecorder->Canvas->Picture 这套组合拳。
  void createCanvas() async {
    PictureRecorder recorder = PictureRecorder();
    Canvas canvas = Canvas(recorder);
    Size boxSize = const Size(100, 100);
    canvas.drawRect(Offset.zero & boxSize, Paint()..color = Colors.blue);
    Picture picture = recorder.endRecording();
    ui.Image image = await picture.toImage(boxSize.width.toInt(), boxSize.height.toInt());
    // 获取字节，存入文件
    ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);
    if (byteData != null) {
      File file = File(r"E:\Temp\desk\box.png");
      file.writeAsBytes(byteData.buffer.asUint8List());
    }
  }
}
