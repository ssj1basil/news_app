import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'views/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.white,
        primaryColorBrightness: Brightness.light,
        brightness: Brightness.light,
        primaryColorDark: Colors.black,
        canvasColor: Colors.white,

      ),
      darkTheme: ThemeData(
        primaryColor: Colors.black,
        primaryColorBrightness: Brightness.dark,
        primaryColorLight: Colors.white,
        brightness: Brightness.dark,
        primaryColorDark: Colors.black,
        indicatorColor: Colors.white,
        canvasColor: Colors.black,

      ),
      home: Home(),
    );
  }
}
