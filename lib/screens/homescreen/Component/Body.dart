import 'package:flutter/material.dart';
import 'package:sac/constant.dart';
import 'package:sac/screens/homescreen/Component/Background.dart';
import 'package:sac/components/rounded_button.dart';
import 'package:sac/screens/login/login.dart';
import 'package:sac/screens/signup/signup.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "SAC",
                style: TextStyle(fontSize: 36,fontWeight: FontWeight.bold),
              ),
              SizedBox(height: size.height*0.05),
              RoundedButton(
                text: "LOGIN",
                press: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context){
                            return Login();
                          },
                      ),
                  );
                },
              ),
              RoundedButton(
                text: "SIGNUP",
                color: kPrimaryColor,
                textColor: Colors.black,
                press: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) {
                            return SignUp();
                          },
                      ),
                  );
                },
              )
            ],
          ),
        ),
    );
  }
}
