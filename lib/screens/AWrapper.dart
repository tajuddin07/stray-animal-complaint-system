import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sac/model/userModel.dart';
import 'package:sac/screens/UserHome/authoritiesHome.dart';
import 'package:sac/screens/login/login.dart';
import 'package:sac/screens/signup/authoritiesSignup.dart';
import 'package:sac/services/authservice.dart';

class AWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final AuthenticationService _auth = AuthenticationService();
    final user = Provider.of<Users>(context);

    if(user == null){
      return LoginView();
    } else {
      // print(user.uid);
      return DashboardAuth();
    }

    }



  }

