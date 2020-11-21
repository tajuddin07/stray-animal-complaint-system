import 'package:flutter/material.dart';
import 'package:sac/components/rounded_button.dart';
import 'package:sac/screens/signup/signup.dart';
import 'package:sac/screens/login/login.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override

  Widget build(BuildContext context) {
    Size size= MediaQuery.of(context).size;

    return Container(
      color: Colors.blue[100],
      child: SingleChildScrollView(
        child: Column(
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
            SizedBox(height: size.height*0.5),
            RoundedButton(
              text: "LOGIN",
              press: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context){
                      return LoginScreen();
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

