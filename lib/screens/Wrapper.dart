import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sac/model/userModel.dart';
import 'package:sac/screens/UserHome/UserHome.dart';
import 'package:sac/screens/UserHome/authoritiesHome.dart';
import 'package:sac/screens/homescreen/homescreen.dart';
import 'package:sac/screens/login/login.dart';
import 'package:sac/screens/signup/signup.dart';

class Wrapper extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<Users>(context);

    if(user == null){
      return LoginView();
    } else {
      // print(user.uid);
      return Dashboard();
    }

    }



  }

