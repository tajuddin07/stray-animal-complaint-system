
import 'package:flutter/material.dart';
import 'package:sac/components/rounded_button.dart';
import 'package:sac/components/rounded_input_field.dart';
import 'package:sac/components/rounded_password_field.dart';
import 'package:sac/components/already_have_an_account_check.dart';
import 'package:sac/screens/login/login.dart';
import 'package:sac/screens/signup/component/background.dart';


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
                "SIGNUP",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: size.height*0.03),
              RoundedInputField(
                hintText: "Your Email",
                onChanged: (value){},
              ),
              RoundedPasswordField(
                onChanged: (value){},
              ),
              RoundedInputField(
                hintText: "First Name",
                onChanged: (value){},
              ),
              RoundedInputField(
                hintText: "Last Name",
                onChanged: (value){},
              ),
              RoundedInputField(
                hintText: "Phone Number",
                onChanged: (value){},
              ),
              RoundedButton(
                text: "SIGNUP",
                press: () {},
              ),
              SizedBox(height: size.height*0.03),
              AlreadyHaveAnAccountCheck(
                login: false,
                press: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) {
                            return Login();
                          },
                      ),
                  );
                },
              ),
            ],
          ),
        )
    );
  }
}
