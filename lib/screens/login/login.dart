import 'package:flutter/material.dart';
import 'package:sac/screens/login/component/Body.dart';
import 'package:sac/components/already_have_an_account_check.dart';
import 'package:sac/components/rounded_input_field.dart';
import 'package:sac/components/rounded_password_field.dart';
import 'package:sac/screens/signup/signup.dart';

/*class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}


class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    Size size= MediaQuery.of(context).size;
    return Container(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "LOGIN",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height*0.03),
            RoundedInputField(
              hintText: "Your Email",
              onChanged: (value){},
            ),
            RoundedPasswordField(
              onChanged: (value) {},
            ),
            SizedBox(height: size.height*0.03),
            AlreadyHaveAnAccountCheck(
              press: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context){
                      return SignUp();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}*/

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}
