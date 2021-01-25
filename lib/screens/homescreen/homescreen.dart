import 'package:flutter/material.dart';
import 'package:sac/components/rounded_button.dart';
import 'package:sac/screens/login/login.dart';
import 'package:sac/screens/signup/authoritiesSignup.dart';
import 'package:sac/screens/signup/signup.dart';
import 'package:sac/services/authservice.dart';
class Home extends StatelessWidget {
  final AuthenticationService _auth = AuthenticationService();
  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size= MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        child: Container(
          alignment: Alignment.center,
          color: Colors.lightBlue,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: size.height*0.05),
                  Text(
                    "SAC",
                    style: TextStyle(fontSize: 42,fontWeight: FontWeight.bold,color: Colors.black),
                  ),
                  SizedBox(height: size.height*0.05),
                  Text(
                    "Animal Complaint System",
                    style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.black),
                  ),
                  SizedBox(height: size.height*0.3),
                  RoundedButton(
                    text: "LOGIN",
                    press: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context){
                            return LoginView();
                          },
                        ),
                      );
                    },
                  ),
                  RoundedButton(
                    text: "SIGNUP",
                    color: Colors.white60,
                    textColor: Colors.black,
                    press: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return SignUpView();
                          },
                        ),
                      );
                    },
                  ),
                  RoundedButton(
                    text: "SIGNUP FOR AUTHORITIES",
                    color: Colors.white60,
                    textColor: Colors.black,
                    press: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return SignUpAuthView();
                          },
                        ),
                      );
                    },
                  )
                ],
            ),
          ),
        ),
      );
  }
}
