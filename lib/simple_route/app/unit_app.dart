import 'package:flutter/material.dart';

class UnitApp extends StatelessWidget{

  const UnitApp ({super.key});

  @override
  Widget build (BuildContext context){
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: false,
      ),
      debugShowCheckedModeBanner: false,

      home:  Scaffold(
        body:Column(



        ),
      ),
    );




  }


}