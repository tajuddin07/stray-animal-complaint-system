import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sac/components/rounded_input_field.dart';
import 'package:provider/provider.dart';
import 'package:sac/model/userModel.dart';
import 'package:sac/components/busybutton.dart';
import 'package:sac/screens/UserHome/UserHome.dart';
import 'package:sac/screens/complaint/geo.dart';
import 'package:sac/services/authservice.dart';
import 'package:sac/constant.dart';
import 'package:sac/screens/login/login.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sac/screens/Wrapper.dart';
import 'package:flutter_geofence/geofence.dart';
import 'package:flutter_geofence/Geolocation.dart';
import 'package:sac/screens/UserHome/UserProfile.dart';
class Complaint extends StatefulWidget {
  final Function toggleView;
  Complaint({this.toggleView});

  @override
  _ComplaintState createState() => _ComplaintState();
}

class _ComplaintState extends State<Complaint> {

  String species;
  List <String> animals = ['Dog', 'Cat',];
  String c1,c2,c3;
  int radius;

  final FirebaseAuth auth = FirebaseAuth.instance;
  String uid;
  String role;
  String email;
  FirebaseUser user;
  Future<FirebaseUser> _user = FirebaseAuth.instance.currentUser();
  TextStyle style = TextStyle(fontFamily: 'Oswald', fontSize: 20.0);
  final AuthenticationService _auth = AuthenticationService();

  double lat = 0.0001;
  double long = 0.0001;
  int priority =5;

  @override
  void initState() {
    super.initState();
    initUser();
  }

  initUser() async {
    user = await auth.currentUser();
    setState(() {});
    print(user.uid);
  }

  int PriorityFilter(int c1,int c2,int c3)
  {
    int priority = 0;

    if(c1==1)
      {
        if(c2==1)
          {
            if(c3==1||c3==2||c3==3)
              {
                priority = 5;
              }
          }
        else if(c2==2)
            {
              if(c3==1) {priority =5;}
              else {priority=4;}
            }
        else if(c2==3)
            {
              if(c3==1) {priority=5;}
              else{priority=4;}
            }
        else if(c2==4){
            if(c3==1) {priority=5;}
            else {priority=3;}
        }else if(c2==5)
          {
            if(c3==1){priority=4;}
            else{priority=3;}
          }
        }
    else if(c1==2)
        {
          if(c2==1)
            {
              if(c3==1){priority=4;}
              else {priority=3;}
            }else if(c2==2)
            {
              if(c3==1){priority=4;}
              else{priority=3;}
            }else if(c2==3)
            {
              if(c3==1){priority=4;}
              else{priority=3;}
            }else if(c2==3)
            {
              if(c3==1){priority=4;}
              else{priority=3; }
            }else if(c2==4)
            {
              if(c3==1||c3==2){priority=4;}
              else{priority=3;}
            }else if(c2==5)
            {
              if(c3==1||c3==2){priority=4;}
              else{priority =2;}
            }
        }
    else if(c1==3)
       {
            if(c2==1)
            {
              if(c3==1||c3==2){priority=4;}
              else{priority=3;}
            }else if(c2==2)
            {
              if(c3==1||c3==2||c3==3){priority=3;}
            }else if(c2==3)
            {
              if(c3==1){priority=3;}
              else{priority=2;}
            }else if(c2==4)
            {
              if(c3==1){priority=3;}
              else{priority=1;}
            }else if(c2==5)
            {
              if(c3==1){priority=3;}
              else{priority=1;}
            }
       }
    else if(c1==4)
      {
            if(c2==1)
            {
              if(c3==1||c3==2){priority=5;}
              else{priority=4;}
            }else if(c2==2)
            {
              if(c3==1||c3==2){priority=4;}
              else{priority=3;}
            }else if(c2==3)
            {
              if(c3==1){priority=3;}
              else{priority=2;}
            }else if(c2==4)
            {
              if(c3==1||c3==2){priority=3;}
              else{priority=1;}
            }else if(c2==5)
            {
              if(c3==1){priority=2;}
              else{priority=1;}
            }
      }
    return priority;
  }

  int findRadius(int priority,String species){
    int radius;
  if(priority==1)
  {
    if(species=="Cat")
    radius=8000;
    else if (species=="Dog")
      radius= 16000;
  }else if(priority==2)
  {
    if(species=="Cat")
      radius=7000;
    else if (species=="Dog")
      radius= 15000;
  }else if(priority==3)
  {
    if(species=="Cat")
      radius=2500;
    else if (species=="Dog")
      radius= 13000;
  }else if(priority==4)
  {
    if(species=="Cat")
      radius=2000;
    else if (species=="Dog")
      radius= 10000;
  }else
    if(priority==5)
    {
      if(species=="Cat")
        radius=1000;
      else if (species=="Dog")
        radius= 8000;
    }

  return radius;
  }

  final formKey = GlobalKey<FormState>();
  GoogleMapController mapController;
  final LatLng center = const LatLng(45.521563, -122.677433);
  TextEditingController subjectCtrl = TextEditingController();
  TextEditingController detailCtrl = TextEditingController();
  TextEditingController latCtrl = TextEditingController();
  TextEditingController longCtrl = TextEditingController();
  TextEditingController speciesCtrl = TextEditingController();
  bool dataFilled = false;
  String date = new DateFormat.yMMMd().format(new DateTime.now());

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }


  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users>(context);
    Size size = MediaQuery.of(context).size;



    return Scaffold(
      backgroundColor: Colors.indigoAccent[100],
      appBar: AppBar(title: Text("Add Complaint"),),
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
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Container(
          /*decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/bg2.jpg"),
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
                                hintText: 'Subject eg :- "Wild Dog Appeared"',
                                border: InputBorder.none,
                                icon: Icon(Icons.people,color: kPrimaryColor,)
                            ),
                          ),
                          DropdownButtonFormField<String>(
                            hint:  Text("Select Animal Species"),
                            value: species,
                            onChanged: (Value) {
                              setState(() {
                                species = Value;

                              });
                            },
                            items: animals.map((animal) {
                              return  DropdownMenuItem(
                                child: new Text(animal),
                                value: animal,
                              );
                            }).toList(),

                          ),

                          SizedBox(height: size.height*0.02),
                          DropdownButtonFormField<String>
                            (
                            value: c1,
                              items:[
                                DropdownMenuItem<String>(
                                    value: '1',
                                    child: Text("Showing their teeth,drooling saliva, walked abnormally",maxLines: 2,),
                                ),
                                DropdownMenuItem<String>(
                                  value: '2',
                                  child: Text("showing their teeth look unhealthy,not drooling, walked abnormally",maxLines: 2,),
                                ),
                                DropdownMenuItem<String>(
                                  value: '3',
                                  child: Text("not showing their teeth walked abnormally",maxLines: 2,),
                                ),
                                DropdownMenuItem<String>(
                                  value: '4',
                                  child: Text("looks normal and walked normally",maxLines: 2,),
                                ),

                              ],
                              onChanged: (_value) {
                                setState(() {
                                  c1 = _value;
                                });
                              },
                            hint:Text("Please choose the animal expression",maxLines: 2,
                              style: TextStyle(fontFamily: "Oswald",fontWeight: FontWeight.bold),
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please choose the animal expression';
                              }
                              else {
                                return null;
                              }
                            },
                          ),
                          SizedBox(height: size.height*0.02),
                          DropdownButtonFormField<String>
                            (
                              value: c2,
                              items:[
                                DropdownMenuItem<String>(
                                  value: '1',
                                  child: Text("Very aggressive toward other people,chasing them and attacking them",maxLines: 2,),
                                ),
                                DropdownMenuItem<String>(
                                  value: '2',
                                  child: Text("Very aggressive to creature coming near it",maxLines: 2,),
                                ),
                                DropdownMenuItem<String>(
                                  value: '3',
                                  child: Text("Making loud noise all the time but don't attack people",maxLines: 2,),
                                ),
                                DropdownMenuItem<String>(
                                  value: '4',
                                  child: Text("Littering the area,don't attack, not scared of people",maxLines: 2,),
                                ),
                                DropdownMenuItem<String>(
                                  value: '5',
                                  child: Text("Littering the area & run away from people",maxLines: 2,
                                  ),
                                ),

                              ],
                              onChanged: (_value) {
                                setState(() {
                                  c2 = _value;
                                });
                              },
                              hint:Text("Please choose the animal behaviour",maxLines: 2,
                                style: TextStyle(fontFamily: "Oswald",
                                    fontWeight: FontWeight.bold),
                              ),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please choose the animal behaviour';
                                }
                                else {
                                  return null;
                                }
                              }
                          ),
                          SizedBox(height: size.height*0.02),
                          DropdownButtonFormField<String>
                            (
                              value: c3,
                              items:[
                                DropdownMenuItem<String>(
                                  value: '1',
                                  child: Text("Have poor skin condition/multiple wounds on body and no fur at all",maxLines: 2,),
                                ),
                                DropdownMenuItem<String>(
                                  value: '2',
                                  child: Text("Have messy fur condition"),
                                ),
                                DropdownMenuItem<String>(
                                  value: '3',
                                  child: Text("Have a good fur condition"),
                                ),
                              ],
                              onChanged: (_value) {
                                setState(() {
                                  c3 = _value;
                                });
                              },
                              hint:Text("Please choose the animal condition",maxLines: 2,
                                style: TextStyle(fontFamily: "Oswald",
                                    fontWeight: FontWeight.bold),
                              ),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please choose the animal physical condition';
                                }
                                else {
                                  return null;
                                }
                              }
                          ),
                          SizedBox(height: size.height*0.02),
                          TextField(
                            decoration: InputDecoration(fillColor: Colors.white60,
                                hintText: 'Please enter the detail, such as the color of the animal, breed and etc',
                            ),
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
                    title: 'Next',
                    onPressed: () async {
                      priority = PriorityFilter(int.parse(c1), int.parse(c2),int.parse(c3) );
                      radius = findRadius(priority,species);
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => Geo(date: date,detail: detailCtrl.text,priority: priority,species: species,subject: subjectCtrl.text,radius: radius,),
                        ),
                            (route) => false,
                      );

                    },
                  ),


                  SizedBox(height: 10.0),

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


