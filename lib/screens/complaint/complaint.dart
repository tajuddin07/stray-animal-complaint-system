import 'dart:core';
import 'package:flutter/material.dart';
import 'package:sac/components/rounded_input_field.dart';
import 'package:provider/provider.dart';
import 'package:sac/model/userModel.dart';
import 'package:sac/components/busybutton.dart';
import 'package:sac/services/authservice.dart';
import 'package:sac/constant.dart';
import 'package:sac/screens/login/login.dart';
import 'package:intl/intl.dart';
class Complaint extends StatefulWidget {
  final Function toggleView;
  Complaint({this.toggleView});

  @override
  _ComplaintState createState() => _ComplaintState();
}

class _ComplaintState extends State<Complaint> {

  int PriorityFilter(int c1,int c2,int c3)
  {
    int priority = 0;

    if(c1==1)
      {
        if(c2==1)
          {
            if(c3==1)
              {
                priority = 5;
              }
          }
      }

    /*if(c1 == 1 && c2 ==1 && c3==1){priority = 5;return priority;}
    else if(c1 == 1 && c2 ==1 && c3==2){priority = 5;return priority;}
    else if(c1 == 1 && c2 ==1 && c3==3){priority = 5;return priority;}
    else if(c1 == 2 && c2 ==1 && c3==1){priority = 5;return priority;}
    else if(c1 == 2 && c2 ==1 && c3==2){priority = 5;return priority;}
    else if(c1 == 2 && c2 ==1 && c3==3){priority = 5;return priority;}
    else if(c1 == 3 && c2 ==1 && c3==1){priority = 5;return priority;}
    else if(c1 == 3 && c2 ==1 && c3==2){priority = 5;return priority;}
    else if(c1 == 3 && c2 ==1 && c3==3){priority = 5;return priority;}
    else if(c1 == 4 && c2 ==1 && c3==1){priority = 5;return priority;}
    else if(c1 == 4 && c2 ==1 && c3==2){priority = 5;return priority;}
    else if(c1 == 4 && c2 ==1 && c3==3){priority = 5;return priority;}
    else if(c1 == 1 && c2 ==2 && c3==1){priority = 5;return priority;}
    else if(c1 == 1 && c2 ==2 && c3==2){priority = 5;return priority;}
    else if(c1 == 1 && c2 ==2 && c3==3){priority = 5;return priority;}
    else if(c1 == 2 && c2 ==2 && c3==1){priority = 5;return priority;}
    else if(c1 == 2 && c2 ==2 && c3==2){priority = 5;return priority;}
    else if(c1 == 2 && c2 ==2 && c3==3){priority = 5;return priority;}
    else if(c1 == 3 && c2 ==2 && c3==1){priority = 4;return priority;}
    else if(c1 == 3 && c2 ==2 && c3==2){priority = 4;return priority;}
    else if(c1 == 3 && c2 ==2 && c3==3){priority = 4;return priority;}
    else if(c1 == 4 && c2 ==2 && c3==1){priority = 5;return priority;}
    else if(c1 == 4 && c2 ==2 && c3==2){priority = 5;return priority;}
    else if(c1 == 4 && c2 ==2 && c3==3){priority = 5;return priority;}
    else if(c1 == 1 && c2 ==3 && c3==1){priority = 5;return priority;}
    else if(c1 == 1 && c2 ==3 && c3==2){priority = 5;return priority;}
    else if(c1 == 1 && c2 ==3 && c3==3){priority = 5;return priority;}
    else if(c1 == 2 && c2 ==3 && c3==1){priority = 5;return priority;}
    else if(c1 == 2 && c2 ==3 && c3==2){priority = 5;return priority;}
    else if(c1 == 2 && c2 ==3 && c3==3){priority = 5;return priority;}
    else if(c1 == 3 && c2 ==3 && c3==1){priority = 5;return priority;}
    else if(c1 == 3 && c2 ==3 && c3==2){priority = 5;return priority;}
    else if(c1 == 3 && c2 ==3 && c3==3){priority = 5;return priority;}
    else if(c1 == 4 && c2 ==3 && c3==1){priority = 5;return priority;}
    else if(c1 == 4 && c2 ==3 && c3==2){priority = 5;return priority;}
    else if(c1 == 4 && c2 ==3 && c3==3){priority = 5;return priority;}
    else if(c1 == 1 && c2 ==4 && c3==1){priority = 5;return priority;}
    else if(c1 == 1 && c2 ==4 && c3==2){priority = 5;return priority;}
    else if(c1 == 1 && c2 ==4 && c3==3){priority = 5;return priority;}
    else if(c1 == 2 && c2 ==4 && c3==1){priority = 5;return priority;}
    else if(c1 == 2 && c2 ==4 && c3==2){priority = 5;return priority;}
    else if(c1 == 2 && c2 ==4 && c3==3){priority = 5;return priority;}
    else if(c1 == 3 && c2 ==4 && c3==1){priority = 5;return priority;}
    else if(c1 == 3 && c2 ==4 && c3==2){priority = 5;return priority;}
    else if(c1 == 3 && c2 ==4 && c3==3){priority = 5;return priority;}
    else if(c1 == 4 && c2 ==4 && c3==1){priority = 5;return priority;}
    else if(c1 == 4 && c2 ==4 && c3==2){priority = 5;return priority;}
    else if(c1 == 4 && c2 ==4 && c3==3){priority = 5;return priority;}
    else if(c1 == 1 && c2 ==5 && c3==1){priority = 5;return priority;}
    else if(c1 == 1 && c2 ==5 && c3==2){priority = 5;return priority;}
    else if(c1 == 1 && c2 ==5 && c3==3){priority = 5;return priority;}
    else if(c1 == 2 && c2 ==5 && c3==1){priority = 5;return priority;}
    else if(c1 == 2 && c2 ==5 && c3==2){priority = 5;return priority;}
    else if(c1 == 2 && c2 ==5 && c3==3){priority = 5;return priority;}
    else if(c1 == 3 && c2 ==5 && c3==1){priority = 5;return priority;}
    else if(c1 == 3 && c2 ==5 && c3==2){priority = 5;return priority;}
    else if(c1 == 3 && c2 ==5 && c3==3){priority = 5;return priority;}
    else if(c1 == 4 && c2 ==5 && c3==1){priority = 5;return priority;}
    else if(c1 == 4 && c2 ==5 && c3==2){priority = 5;return priority;}
    else if(c1 == 4 && c2 ==5 && c3==3){priority = 5;return priority;}*/

  }


  TextStyle style = TextStyle(fontFamily: 'Oswald', fontSize: 20.0);
  final AuthenticationService _auth = AuthenticationService();
  final formKey = GlobalKey<FormState>();

  TextEditingController subjectCtrl = TextEditingController();
  TextEditingController detailCtrl = TextEditingController();
  TextEditingController latCtrl = TextEditingController();
  TextEditingController longCtrl = TextEditingController();
  TextEditingController speciesCtrl = TextEditingController();
  bool dataFilled = false;
  String date = new DateFormat.yMMMd().format(new DateTime.now());
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users>(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(

      backgroundColor: Colors.lightBlue,
      resizeToAvoidBottomPadding: false,
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Container(
          /*decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/bg2.jpg"),
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
                            "ADD COMPLAINT",
                            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
                          ),
                          SizedBox(height: size.height*0.02),
                          InputRound(
                            controller: subjectCtrl,
                            validator: (value){
                              if(value.isEmpty){return 'Please enter the title of your complaint such as "Wild Dog Appeared" etc.';}
                              else {return null;}
                            },
                            deco: InputDecoration(
                                hintText: 'Subject',
                                border: InputBorder.none,
                                icon: Icon(Icons.people,color: kPrimaryColor,)
                            ),
                          ),
                      DropdownButton(
                           value: value,
                             items: [
                               DropdownMenuItem(child: Text("Cat"),value: 1,),
                               DropdownMenuItem(child: Text("Dog"),value: 2),
                             ], onChanged: (value){setState(() {value=value;});}
                        ),
                          SizedBox(height: size.height*0.02),
                          TextField(
                            keyboardType: TextInputType.multiline,
                            controller: detailCtrl,
                            maxLines: null,
                          ),
                          SizedBox(height: size.height*0.02),
                        ],
                      )

                  ),


                  SizedBox(height: 9.0),
                  BusyButton(
                    title: 'Submit',
                    onPressed: () async {
                      if (formKey.currentState.validate()) {
                        //register .. send data  to authservices
                        dynamic result = await _auth.regComplaint(date, subjectCtrl.text, detailCtrl.text,  );
                        if(result!=null){
                          showDialog(
                            context: context,
                            barrierDismissible: false, // user must tap button!
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Successfully Registered'),
                                content: SingleChildScrollView(
                                  child: ListView(
                                    children: <Widget>[
                                      Text('Continue to login'),
                                    ],
                                  ),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text('OK'),
                                    onPressed: () async {
                                      dynamic result = await _auth.signOut();
                                      if (result == null) {
                                        int i = 1;
                                        print(i.toString());
                                        Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                LoginView(),
                                          ),
                                              (route) => false,
                                        );
                                      }
                                    },
                                  ),
                                ],
                              );
                            },
                          );}
                        else{
                          showDialog(
                            context: context,
                            barrierDismissible: false, // user must tap button!
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('This account already been used'),
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
