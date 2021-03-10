//Muhammad Shaharyar
import 'package:flutter/material.dart';
// import 'package:fyp/output.dart';

import 'home_page.dart';
import 'output.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'URDU LENS',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
      routes: {
        HomePage.route: (ctx) => HomePage(),
        Output.route: (ctx) => Output(),
      },
    );
  }
}
