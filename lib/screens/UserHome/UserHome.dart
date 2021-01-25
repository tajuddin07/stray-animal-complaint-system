import 'package:sac/screens/complaint/geo.dart';
import 'package:sac/screens/login/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sac/services/authservice.dart';
import 'package:flutter/animation.dart';
import 'package:sac/screens/complaint/complaint.dart';
import 'package:sac/screens/Wrapper.dart';
import 'package:sac/screens/complaint/geo.dart';

class Dashboard extends StatefulWidget {
  final appTitle = 'Stray Animal Complaint';
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  String uid;
  String role;
  String email;
  FirebaseUser user;
  Future<FirebaseUser> _user = FirebaseAuth.instance.currentUser();
  TextStyle style = TextStyle(fontFamily: 'Oswald', fontSize: 20.0);
  final AuthenticationService _auth = AuthenticationService();



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

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    final shome = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => Dashboard(),
            ),
                (route) => false,
          );
        },
        child: Text("Home",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );



    final logout = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.red,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width * 0.3,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
          dynamic result = await _auth.signOut();
          if(result == null) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => LoginView(),
              ),
                  (route) => false,
            );
          }
        },
        child: Text("Logout",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    final request = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width * 0.3,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () async {
        },
        child: Text("Request",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    fetchComplaint() {
      return   Firestore.instance
          .collection("complaint")
          .where("User ID", isEqualTo:user.uid )
          .snapshots();
    }



    Size size = MediaQuery.of(context).size;

    getData() async {
      uid = (await FirebaseAuth.instance.currentUser()).uid;
      email = (await FirebaseAuth.instance.currentUser()).email;
      print(uid);
      var document = await Firestore.instance.collection('USER')
          .document(uid)
          .get();
      role = document.data['role'].toString();
      print(role);
    }


    return Scaffold(
      appBar: AppBar(
        title: const Text('Stray Animal Complaint System'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () async{
              {
                  //register .. send data  to authservices
                  dynamic result = await _auth.signOut();
                  if(result=null){
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
                          title: Text('Failed to logout'),
                          content: SingleChildScrollView(
                            child: ListBody(
                              children: <Widget>[
                                Text('Try again later'),
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
          IconButton(
            icon: const Icon(Icons.navigate_next),
            tooltip: 'Next page',
            onPressed: () {
              /*openPage(context)*/;
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
         heroTag: Icons.add,
          onPressed:(){
         Navigator.push(
          context,
           MaterialPageRoute(
               builder: (context) =>
                   Complaint()),);

      } ),
      resizeToAvoidBottomPadding: false,
      body:Container(
        color: Colors.lightBlueAccent,
        child: Column(
          children:<Widget> [
            SizedBox(height: 15.0),
            Center(child: Text(' My Complaint List', textAlign: TextAlign.center,
                style: style)),
            SizedBox(height: 10.0),
            Container(
              height: size.height * 0.8,
              child: StreamBuilder<QuerySnapshot>(
                stream: fetchComplaint(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return new Container(
                      child: Text(" No data"),
                    );
                  } else {
                    return ListView.builder(
                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (BuildContext context, int i) {
                          return Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white
                              ),
                              width: size.width*1,
                              height: size.height*0.2,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20), // if you need this
                                        side: BorderSide(
                                          color: Colors.grey.withOpacity(0.2),
                                          width: 1,
                                        ),
                                      ),
                                      child: Container(
                                          color: Colors.white,
                                          width: 400,
                                          height: 100,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Row(
                                                children: [
                                                  Text("Date: "),
                                                  Expanded(
                                                    child: Text(snapshot.data.documents[i]["Date"],
                                                      maxLines :4,
                                                      overflow: TextOverflow.ellipsis,
                                                      textDirection: TextDirection.ltr,
                                                      textAlign: TextAlign.justify,
                                                    ),

                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Text("Detail: "),
                                                  Text(snapshot.data.documents[i]["Detail"]),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Text("Status: "),
                                                  Text(snapshot.data.documents[i]["Status"]),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Text("Species: "),
                                                  Text(snapshot.data.documents[i]["Species"]),
                                                  IconButton(
                                                    icon: Icon(Icons.auto_awesome_motion),
                                                    onPressed: (){},
                                                  )
                                                ],
                                              ),
                                            ],
                                          )
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        });
                  }
                },
              ),
            )
          ],
        ),
      ),
    );

  }
}
