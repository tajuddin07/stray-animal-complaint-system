import 'package:flutter/material.dart';
import 'package:sac/components/rounded_input_field.dart';
import 'package:sac/constant.dart';
import 'package:sac/components/rounded_password_field.dart';
import 'package:sac/screens/signup/signup.dart';
import 'package:sac/services/authservice.dart';
import 'package:sac/components/busybutton.dart';
import 'package:sac/screens/Wrapper.dart';


class LoginView extends StatefulWidget {
  final Function toggleView;
  LoginView({this.toggleView});
  @override
  _LoginViewState createState() => _LoginViewState();
}



class _LoginViewState extends State<LoginView> {
  final AuthenticationService _auth = AuthenticationService();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  final formKey = GlobalKey<FormState>();
  TextStyle style = TextStyle(fontFamily: 'Oswald', fontSize: 20.0);



  @override
  Widget build(BuildContext context) {
  Size size = MediaQuery.of(context).size;

  final registButton = Material(
    elevation: 2.0,
    borderRadius: BorderRadius.circular(30.0),
    color: Colors.purple,
    child: MaterialButton(
      minWidth: MediaQuery.of(context).size.width * 0.6,
      padding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SignUpView()),
        ); //signup screen
      },
      child: Text("Register",
          textAlign: TextAlign.center,
          style: style.copyWith(
              color: Colors.white, fontWeight: FontWeight.bold)),
    ),
  );

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/bg2.jpg"),
            fit: BoxFit.fill,
          ),
        ),
        child: Container(
          color: Colors.lightBlue,
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 25.0),
                Form(
                  key: formKey,
                  child: Column(
                    children: <Widget>[
                      Text(
                        "LOGIN",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: size.height*0.03),
                      InputRound(
                        controller: emailCtrl,
                        deco: InputDecoration(
                            hintText: 'Email',
                            border: InputBorder.none,
                            icon: Icon(Icons.email,color: kPrimaryColor,)
                        ),
                      ),
                      SizedBox(height: size.height*0.03),
                      InputPasswordRound(
                        controller: passwordCtrl,

                      ),
                      SizedBox(height: size.height*0.03),

                    ],
                  ),
                ),
                SizedBox(
                  height: 25.0,
                ),
                Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(30.0),
                  color: Color(0xff01A0C7),
                  child: MaterialButton(
                    minWidth: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    onPressed: () async {
                      if (formKey.currentState.validate()) {
                        dynamic result = await _auth.signInUser(emailCtrl.text, passwordCtrl.text);
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => Wrapper(),
                          ),
                              (route) => false,
                        );
                         print(result.uid);
                        if (result == null) {
                          showDialog(
                            context: context,
                            barrierDismissible: false, // user must tap button!
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Invalid email/password'),
                                content: SingleChildScrollView(
                                  child: ListBody(
                                    children: <Widget>[
                                      Text('Email or password is not match'),
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
                    child: Text("Login",
                        textAlign: TextAlign.center,
                        style: style.copyWith(
                            color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                registButton,
                SizedBox(
                  height: 15.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

























/*

class LoginView extends StatelessWidget {
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size= MediaQuery.of(context).size;
    return ViewModelBuilder<LoginViewModel>.reactive(
      viewModelBuilder: () => LoginViewModel(),

      builder: (context, model, child) => Scaffold(
        body: Padding(

          padding: const EdgeInsets.symmetric(horizontal: 50.0),
          child: Column(

            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "SIGNUP",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: size.height*0.03),
              InputRound(
                controller: emailCtrl,
                deco: InputDecoration(
                    hintText: 'Email',
                    border: InputBorder.none,
                    icon: Icon(Icons.email,color: kPrimaryColor,)
                ),
              ),
              SizedBox(height: size.height*0.03),
              InputPasswordRound(
                controller: passwordCtrl,

              ),
              SizedBox(height: size.height*0.03),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  BusyButton(
                    title: 'Sign Up',
                    busy: model.busy,
                    onPressed: () {
                      model.login(email: emailCtrl.text,
                          password: passwordCtrl.text);

                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
*/


