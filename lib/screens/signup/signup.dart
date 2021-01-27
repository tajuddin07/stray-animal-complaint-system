import 'package:flutter/material.dart';
import 'package:sac/components/rounded_input_field.dart';
import 'package:sac/constant.dart';
import 'package:sac/components/rounded_password_field.dart';
import 'package:sac/screens/login/login.dart';
import 'package:sac/services/authservice.dart';
import 'package:sac/components/busybutton.dart';
import 'package:flutter/services.dart';
import 'package:sac/screens/Wrapper.dart';

class SignUpView extends StatefulWidget {
  final Function toggleView;
  SignUpView({this.toggleView});
  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {

  TextStyle style = TextStyle(fontFamily: 'Oswald', fontSize: 20.0);
  final AuthenticationService _auth = AuthenticationService();
  final formKey = GlobalKey<FormState>();
  TextEditingController nameCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  TextEditingController PhoneNoCtrl = TextEditingController();
  TextEditingController addressCtrl = TextEditingController();
  bool dataFilled = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      resizeToAvoidBottomPadding: false,
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Container(
          /*decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/bg2.jpg"),
              fit: BoxFit.cover,
            ),
          ),*/
          child: Container(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  /*SizedBox(
                    height: 150.0,
                    width: 150.0,
                    child: Image.asset(
                      "assets/logo.png",
                    ),
                  ),*/
                  SizedBox(height: 10.0),
                  Form(
                    key: formKey,
                    child: Column(
                      children: <Widget>[
                        Text(
                          "SIGNUP",
                          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
                        ),
                        SizedBox(height: size.height*0.02),
                        InputRound(
                          controller: emailCtrl,
                          deco: InputDecoration(
                              hintText: 'Email',
                              border: InputBorder.none,
                              icon: Icon(Icons.email,color: kPrimaryColor,)
                          ),
                        ),
                        SizedBox(height: size.height*0.02),
                        InputRound(
                          controller: nameCtrl,
                          deco: InputDecoration(
                              hintText: 'Name',
                              border: InputBorder.none,
                              icon: Icon(Icons.people,color: kPrimaryColor,)
                          ),
                        ),
                        SizedBox(height: size.height*0.02),
                        InputPasswordRound(
                          controller: passwordCtrl,

                        ),
                        SizedBox(height: size.height*0.02),
                        InputRound(
                          controller: PhoneNoCtrl,
                          deco: InputDecoration(
                              hintText: 'Phone Number',
                              border: InputBorder.none,
                              icon: Icon(Icons.phone_android,color: kPrimaryColor,)
                          ),
                        ),
                        SizedBox(height: size.height*0.02),
                        InputRound(
                          controller: addressCtrl,
                          deco: InputDecoration(
                              hintText: 'Address',
                              border: InputBorder.none,
                              icon: Icon(Icons.home,color: kPrimaryColor,)
                          ),
                        ),
                      ],
                    )

                  ),


                  SizedBox(height: 9.0),
                 BusyButton(
                     title: 'Submit',
                     onPressed: () async {
                        if (formKey.currentState.validate()) {
                                //register .. send data  to authservices
                        dynamic result = await _auth.regUser(emailCtrl.text, passwordCtrl.text, nameCtrl.text,addressCtrl.text ,PhoneNoCtrl.text );
                       if(result!=null){
                        showDialog(
                          context: context,
                          barrierDismissible: false, // user must tap button!
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("You've successfully registered"),
                              content: SingleChildScrollView(
                                child: ListBody(
                                  children: <Widget>[
                                    Text('Please login!'),
                                  ],
                                ),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  child: Text('OK'),
                                  onPressed: () async {Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext context) => Wrapper(),
                                    ),
                                        (route) => false,
                                  );},
                                ),
                              ],
                            );
                          },
                        );
                         }
                       else{
                        showDialog(
                          context: context,
                          barrierDismissible: false, // user must tap button!
                          builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('The email is invalid'),
                            content: SingleChildScrollView(
                            child: ListBody(
                          children: <Widget>[
                          Text('Use other email account'),
                          ],
                        ),
                        ),
                      actions: <Widget>[
                        TextButton(
                          child: Text('OK'),
                            onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                        ],
                      );
                      },
                    );
                    }
                  }
                  },
                 ),

                  SizedBox(height: 10.0),
                  Text("Already have an account?"),
                  FlatButton(
                    child: Text("Login here!", style: style),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


