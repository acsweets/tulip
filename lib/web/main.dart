import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}


class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [Row(
          children: [
            // Expanded(
            //   child: Swiper(
            //     itemBuilder: (context, index) {
            //       return Image.asset(
            //         images[index],
            //         fit: BoxFit.fill,
            //       );
            //     },
            //     autoplay: true,
            //     itemCount: images.length,
            //     scrollDirection: Axis.vertical,
            //     pagination: const SwiperPagination(
            //       alignment: Alignment.centerRight,
            //       builder: SwiperPagination.rect,
            //     ),
            //   ),
            // )
          ],
        ),
          SizedBox(
            height: 500,
            child: Swiper(

                autoplay: true,
              itemBuilder: (context, index){
                return Image.network( "https://marketplace.canva.cn/NsFNI/MADwRLNsFNI/1/screen_2x/canva-blue-textured-background-MADwRLNsFNI.jpg",fit: BoxFit.fill,);
              },
              itemCount: 3,
              pagination: const SwiperPagination(),
              control: const SwiperControl(),
            ),
          ),

        ],

      ),
    );
  }
}
