import 'package:flutter/material.dart';
import 'package:sac/components/rounded_input_field.dart';
import 'package:sac/constant.dart';
import 'package:sac/components/rounded_password_field.dart';
import 'package:sac/screens/UserHome/UserHome.dart';
import 'package:sac/screens/login/login.dart';
import 'package:sac/services/authservice.dart';
import 'package:sac/components/busybutton.dart';
import 'package:flutter/services.dart';
import 'package:sac/screens/Wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UpdateProfile extends StatefulWidget {
  final Function toggleView;
  UpdateProfile({this.toggleView});
  @override
  _UpdateProfileState createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {

  TextStyle style = TextStyle(fontFamily: 'Oswald', fontSize: 20.0);
  final AuthenticationService _auth = AuthenticationService();
  final formKey = GlobalKey<FormState>();
  TextEditingController nameCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  TextEditingController PhoneNoCtrl = TextEditingController();
  TextEditingController addressCtrl = TextEditingController();
  FirebaseUser user;
  Future<FirebaseUser> _user = FirebaseAuth.instance.currentUser();
  final FirebaseAuth auth = FirebaseAuth.instance;
  bool dataFilled = false;



  @override
  initState() {
    super.initState();
    initUser();
  }

  initUser() async {
    user = await auth.currentUser();
    setState(() {});
    var document =await  Firestore.instance.collection("users").document(user.uid).get();
    nameCtrl.text = document.data["Name"].toString();
    emailCtrl.text = document.data["Email"].toString();
    passwordCtrl.text = document.data["Password"].toString();
    PhoneNoCtrl.text = document.data["Phone Number"].toString();
    addressCtrl.text = document.data["Address"].toString();

    print(user.uid);
  }



  @override
  Widget build(BuildContext context)  {
    Size size = MediaQuery.of(context).size;


    return Scaffold(
      appBar: AppBar(title: Text("Update Profile"),),
      drawer: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.deepPurpleAccent,
        ),
        child: Drawer(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Text(''),
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/saclogo.jpeg"),
                      fit: BoxFit.cover
                  ),
                  color: Colors.blue,
                ),
              ),
              FloatingActionButton.extended(
                  backgroundColor: Colors.blue,
                  icon: Icon(Icons.home),
                  heroTag: "homebtn",
                  label: Text("Home"),
                  tooltip: 'Show Snackbar',
                  onPressed: () async {
                    {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              Dashboard(),
                        ),
                            (route) => false,
                      );
                    }
                  }
              ),
              SizedBox(height: 10.0),
              FloatingActionButton.extended(
                  backgroundColor: Colors.blue,
                  heroTag: "EditProfilebtn",
                  icon: Icon(Icons.person),
                  label: Text("Profile"),
                  tooltip: 'Show Snackbar',
                  onPressed: () async {
                    {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              UpdateProfile(),
                        ),
                            (route) => false,
                      );
                    }
                  }
              ),
              SizedBox(height: 10.0),
              FloatingActionButton.extended(
                  backgroundColor: Colors.blueAccent,
                  heroTag: "logoutbtn",
                  icon: Icon(Icons.logout),
                  label: Text("Logout"),
                  tooltip: 'Show Snackbar',
                  onPressed: () async {
                    {
                      //register .. send data  to authservices
                      dynamic result = await _auth.signOut();
                      if (result == null) {
                        showDialog(
                          context: context,
                          barrierDismissible: false, // user must tap button!
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Sucessfully Logout"),
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
                                  onPressed: () async {
                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            LoginView(),
                                      ),
                                          (route) => false,
                                    );
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }
                      else {
                        showDialog(
                          context: context,
                          barrierDismissible: false, // user must tap button!
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Fail to logout'),
                              content: SingleChildScrollView(
                                child: ListBody(
                                  children: <Widget>[
                                    Text('Something happen'),
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
                  }
              ),

            ],
          ),
        ),
      ),
      backgroundColor: Colors.lightBlue,
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Container(
          /*decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/bg2.jpg"),
              fit: BoxFit.cover,
            ),
          ),*/
          child: SingleChildScrollView(
            child: Container(
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
                            "Update Profile",
                            style: TextStyle(fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                          SizedBox(height: size.height * 0.02),

                          InputRound(
                            controller: emailCtrl,
                            deco: InputDecoration(
                                hintText: 'Email',
                                border: InputBorder.none,
                                icon: Icon(Icons.email, color: kPrimaryColor,),
                            ),
                          ),
                          SizedBox(height: size.height * 0.02),
                          InputRound(
                            controller: nameCtrl,
                            deco: InputDecoration(
                                hintText: 'Name',
                                border: InputBorder.none,
                                icon: Icon(Icons.people, color: kPrimaryColor,)
                            ),
                          ),
                          SizedBox(height: size.height * 0.02),
                          InputPasswordRound(
                            controller: passwordCtrl,

                          ),
                          SizedBox(height: size.height * 0.02),
                          InputRound(
                            controller: PhoneNoCtrl,
                            deco: InputDecoration(
                                hintText: 'Phone Number',
                                border: InputBorder.none,
                                icon: Icon(
                                  Icons.phone_android, color: kPrimaryColor,)
                            ),
                          ),
                          SizedBox(height: size.height * 0.02),
                          InputRound(
                            controller: addressCtrl,
                            deco: InputDecoration(
                                hintText: 'Address',
                                border: InputBorder.none,
                                icon: Icon(Icons.home, color: kPrimaryColor,)
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
                        dynamic result = await _auth.updateProfile(emailCtrl.text,
                            passwordCtrl.text, nameCtrl.text, addressCtrl.text,
                            PhoneNoCtrl.text);
                        if (result == null) {
                          showDialog(
                            context: context,
                            barrierDismissible: false, // user must tap button!
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("You've successfully update your profile"),
                                content: SingleChildScrollView(
                                  child: ListBody(
                                    children: <Widget>[
                                      Text("You'll be redirect to Dashboard"),
                                    ],
                                  ),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text('OK'),
                                    onPressed: () async {
                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              Dashboard(),
                                        ),
                                            (route) => false,
                                      );
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        }
                        else {
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
                  BusyButton(
                    title: 'Back',
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              Dashboard(),
                        ),
                            (route) => false,
                      );
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
