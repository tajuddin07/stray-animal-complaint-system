import 'package:sac/screens/login/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sac/services/authservice.dart';
import 'package:flutter/animation.dart';
import 'package:sac/screens/complaint/complaint.dart';
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
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

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
      floatingActionButton: FloatingActionButton(
          onPressed:(){
         Navigator.push(
          context,
           MaterialPageRoute(
               builder: (context) =>
                   Complaint()),);

      } ),
      resizeToAvoidBottomPadding: false,
      body:Container(
        color: Colors.black12,
        child: Column(
          children:<Widget> [
            SizedBox(height: 15.0),
            Center(child: Text('Complaint List', textAlign: TextAlign.center,
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
                                                    onPressed: (){
                                                      // Navigator.push(
                                                      //   context,
                                                      //   MaterialPageRoute(
                                                      //       builder: (context) =>
                                                      //           StudentEdit(snapshot
                                                      //               .data.documents[i])),
                                                      // );
                                                    },
                                                  )
                                                ],
                                              ),

                                            ],
                                          )
                                      ),
                                    ),

                                    // Row(
                                    //   children: [
                                    //     IconButton(
                                    //         icon: Icon(Icons.edit),
                                    //         onPressed: () {
                                    //           Navigator.push(
                                    //             context,
                                    //             MaterialPageRoute(
                                    //                 builder: (context) =>
                                    //                     StudentUpdate(snapshot
                                    //                         .data.docs[i])),
                                    //           );
                                    //         }),
                                    //     IconButton(
                                    //       icon: Icon(Icons.delete),
                                    //       onPressed: (){
                                    //         deleteStudent(i);
                                    //       },
                                    //     )                                      ],
                                    // ),
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
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Business',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'School',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
