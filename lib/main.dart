import 'package:flutter/material.dart';
import 'package:hots_ultimate/ui/main_page.dart';

void main() => runApp(HotsUltimate());

class HotsUltimate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
//      theme: ThemeData(
//        primarySwatch: Colors.purple,
//      ),
      home: MainPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

