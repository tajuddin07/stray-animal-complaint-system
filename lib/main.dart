import 'package:flutter/material.dart';
import 'package:sac/constant.dart';
import 'package:sac/screens/homescreen//homescreen.dart';



void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Stray Animal Complaint System',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        fontFamily: 'Oswald',
        scaffoldBackgroundColor: Colors.white60,
      ),
      home: HomeScreen(),
    );
  }
}

