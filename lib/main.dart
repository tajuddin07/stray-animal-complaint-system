import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sac/model/userModel.dart';
import 'package:sac/screens/homescreen/homescreen.dart';
import 'package:sac/services/authservice.dart';

void main()async {

  runApp(MyApp());

}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<Users>.value(
        value: AuthenticationService().user,
        child: MaterialApp(
            home: Home()
        )

    );
  }
}