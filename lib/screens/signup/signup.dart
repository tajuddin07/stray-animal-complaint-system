import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sac/components/rounded_button.dart';
import 'package:sac/components/already_have_an_account_check.dart';
import 'package:sac/components/rounded_input_field.dart';
import 'package:sac/components/rounded_password_field.dart';
import 'package:sac/screens/UserHome/UserHome.dart';
import 'package:sac/services/User.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController nameController = TextEditingController();
  String email ='';
  String password = '';
  String FName = '';
  String LName = '';
  String phoneNo = '';
  String fullName='';

  @override
  Widget build(BuildContext context) {

    Size size= MediaQuery.of(context).size;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      child: MaterialApp(
        theme: ThemeData(
            fontFamily: "Oswald"
        ),
        home: Scaffold(
          backgroundColor: Colors.blueAccent,
          body: Stack(
            children: <Widget>[
              Container(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Text(
                        "SIGNUP",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: size.height*0.03),
                      RoundedInputField(
                        hintText: "Your Email",
                        onChanged: (value){
                          email =value;
                        },
                      ),
                      RoundedPasswordField(
                        onChanged: (value){password =value;},
                      ),
                      RoundedInputField(
                        hintText: "First Name",
                        onChanged: (value){FName =value;},
                      ),
                      RoundedInputField(
                        hintText: "Last Name",
                        onChanged: (value){LName =value;},
                      ),
                      RoundedInputField(
                        hintText: "Phone Number",
                        onChanged: (value){phoneNo =value;},
                      ),
                      RoundedButton(
                        text: "SIGNUP",
                        press: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context){
                                return AddUser( FName, email, password, null,phoneNo);
                              })
                          );
                        },
                      ),
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
              )
            ],
          ),
        ),
      ),
    );

  }
}
