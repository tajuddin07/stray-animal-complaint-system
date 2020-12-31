import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sac/components/already_have_an_account_check.dart';
import 'package:sac/services/authservice.dart';
import 'package:provider/provider.dart';


class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  final _formKey = GlobalKey<FormState>();


  TextEditingController nameCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  TextEditingController PhoneNoCtrl = TextEditingController();



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
                      Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(10),
                          child: Text(
                            'Enter Your Account Information',
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.w500,
                                fontSize: 20),
                          )),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: TextField(
                          controller: nameCtrl,
                          decoration: InputDecoration(
                            border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(25.0),),
                            labelText: 'Name',
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: TextField(
                          controller: emailCtrl,
                          decoration: InputDecoration(
                            border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(25.0),),
                            labelText: 'E-Mail',
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: TextField(
                          controller: PhoneNoCtrl,
                          decoration: InputDecoration(
                            border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(25.0),),
                            labelText: 'Phone Number',
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: TextField(
                          controller: passwordCtrl,
                          decoration: InputDecoration(
                            border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(25.0),),
                            labelText: 'Password',
                          ),
                        ),
                      ),

                      Container(
                          height: 50,
                          padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                          child: RaisedButton(
                            textColor: Colors.white,
                            color: Colors.cyan,
                            child: Text('Sign Up'),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                            onPressed: () {
                              context.read<AuthenticationService>().signUp(
                                email: emailCtrl.text,
                                password: passwordCtrl.text,
                              );
                              User updateUser = FirebaseAuth.instance.currentUser;
                              updateUser.updateProfile(displayName: nameCtrl.text);
                              userSetup(nameCtrl.text);
                            },
                          )),

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

void userSetup(String text) {
}
