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
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sac/screens/UserHome/UserProfile.dart';

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
  GoogleMapController _controller;
  Position ps;


  @override
  void initState() {
    super.initState();
    initUser();
  }
  void mapCreated(controller) {
    setState(() {
      _controller = controller;
    });
  }
  initUser() async {
    user = await auth.currentUser();
    setState(() {});
    print(user.uid);
  }

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);



  @override
  Widget build(BuildContext context) {

    bool visI= false;
    bool visC=false;
    fetchComplaint() {
      return   Firestore.instance
          .collection("complaint")
          .where("User ID", isEqualTo:user.uid )
          .snapshots();
    }

    Size size = MediaQuery.of(context).size;


    return Scaffold(
      appBar: AppBar(title: Text("Home"),),
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
      floatingActionButton: FloatingActionButton.extended(
         heroTag: Icons.add,
          onPressed:(){
         Navigator.push(
          context,
           MaterialPageRoute(
               builder: (context) =>
                   Complaint()),);

      },
        icon: Icon(Icons.add),
        label : Text("Add Complaint"),
      ),

      /*resizeToAvoidBottomPadding: false,*/
      body:Container(
        /*color: Colors.lightBlueAccent,*/
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bguserhome.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          children:<Widget> [
            SizedBox(height: 15.0),
            Center(child: Text(' My Complaint List', textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,fontFamily: "Oswald",color: Colors.white))),
            SizedBox(height: 10.0),
            Container(
              height: size.height*0.7 ,
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
                          if(snapshot.data.documents[i]["Completion Time"]!=null){visC = true;}
                          else{visC=false;}
                          if(snapshot.data.documents[i]["Rejection Time"]!=null){visI = true;}
                          else{visC=false;}
                          return Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white70
                              ),
                              width: size.width*1,
                              height: size.height*0.2,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Card(
                                      elevation: 8.0,
                                      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                                      child: Container(
                                        decoration: BoxDecoration(color: Color.fromRGBO(72, 58, 119, .9)),
                                        child: ListTile(
                                          contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                                          leading: Container(
                                            padding: EdgeInsets.only(right: 12.0),
                                            decoration: new BoxDecoration(
                                                border: new Border(
                                                    right: new BorderSide(width: 1.0, color: Colors.white24))),
                                            child: Icon(Icons.system_update_alt, color: Colors.white),
                                          ),
                                          title: Text(
                                            snapshot.data.documents[i]["Subject"],
                                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                          ),

                                          subtitle:Row(
                                            children: [
                                              Text("Subject: ",style:TextStyle(color: Colors.white, fontWeight: FontWeight.bold) ,),
                                              Expanded(
                                                child:Text(snapshot.data.documents[i]["Detail"],
                                                  maxLines :2,
                                                  overflow: TextOverflow.ellipsis,
                                                  textDirection: TextDirection.ltr,
                                                  textAlign: TextAlign.justify,
                                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                              ),
                                              )
                                            ],
                                          ),
                                          trailing:
                                          IconButton(icon: Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0),
                                              onPressed: (){
                                                myMarker.add(Marker(
                                                    markerId: MarkerId(snapshot.data.documents[i]["User ID"]),
                                                    draggable: true,
                                                    onTap: () {
                                                    },
                                                    position: LatLng(snapshot.data.documents[i]["Lat"], snapshot.data.documents[i]["Long"])));
                                                showDialog(
                                                  context: context,
                                                  barrierDismissible: false, // user must tap button!
                                                  builder: (BuildContext context) {
                                                    return AlertDialog(
                                                      title: Text(snapshot.data.documents[i]["Subject"]),
                                                      content: SingleChildScrollView(
                                                        child: ListBody(
                                                          children: <Widget>[
                                                            Container(
                                                              height: MediaQuery.of(context).size.height*0.5,
                                                              width: MediaQuery.of(context).size.width,
                                                              child: GoogleMap(
                                                                initialCameraPosition: CameraPosition(target:LatLng(snapshot.data.documents[i]["Lat"], snapshot.data.documents[i]["Long"]), zoom: 15.0),
                                                                onMapCreated: mapCreated,
                                                                markers: Set.from(myMarker),
                                                              ),
                                                            ),
                                                            SizedBox(height: size.height*0.01),
                                                            Row(
                                                              children: [
                                                                Text("Date: "),
                                                                Expanded(
                                                                  child: Text(snapshot.data.documents[i]["Date"],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(height: size.height*0.01),
                                                            Row(children: [Text("Detail: "),],),
                                                              Row(
                                                                children: [
                                                                    Text(""),Expanded(

                                                                    child:Text(snapshot.data.documents[i]["Detail"],
                                                                      maxLines: 4,
                                                                      overflow: TextOverflow.ellipsis,
                                                                       textDirection: TextDirection.ltr,
                                                                      textAlign: TextAlign.justify,
                                                                    ),
                                                                  )
                                                                     ]
                                                                 ),
                                                            SizedBox(height: size.height*0.01),
                                                            Row(
                                                              children: [
                                                                Text("Status: "),
                                                                Text(snapshot.data.documents[i]["Status"]),
                                                              ],
                                                            ),
                                                            SizedBox(height: size.height*0.01),
                                                          ],

                                                        ),
                                                      ),
                                                      actions: <Widget>[
                                                        Align(
                                                          alignment: Alignment.bottomLeft,
                                                          child: TextButton(
                                                            child: Text('Back'),
                                                            onPressed: () {
                                                              Navigator.of(context).pop();
                                                            },
                                                          ),
                                                        ),
                                                        Align(
                                                          alignment: Alignment.bottomLeft,
                                                          child: TextButton(
                                                            child: Text('Delete'),
                                                            onPressed: () async {
                                                              String cid = snapshot.data.documents[i].documentID;
                                                              var result =Firestore.instance.collection('complaint').document(cid).delete();
                                                              if(result!= null)
                                                                {
                                                                  showDialog(
                                                                                              context: context,
                                                                                              barrierDismissible: false, // user must tap button!
                                                                                              builder: (BuildContext context) {
                                                                                                return AlertDialog(
                                                                                                  title: Text('Delete Success'),
                                                                                                  content: SingleChildScrollView(
                                                                                                    child: ListBody(
                                                                                                      children: <Widget>[
                                                                                                        Text('Please click okay'),
                                                                                                      ],
                                                                                                    ),
                                                                                                  ),
                                                                                                  actions: <Widget>[
                                                                                                    TextButton(
                                                                                                      child: Text('OK'),
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
                                                                                                  ],
                                                                                                );
                                                                                              },
                                                                                            );
                                                                }
                                                              else
                                                                {
                                                                  showDialog(
                                                                                              context: context,
                                                                                              barrierDismissible: false, // user must tap button!
                                                                                              builder: (BuildContext context) {
                                                                                                return AlertDialog(
                                                                                                  title: Text('Delete Success'),
                                                                                                  content: SingleChildScrollView(
                                                                                                    child: ListBody(
                                                                                                      children: <Widget>[
                                                                                                        Text('Please click okay'),
                                                                                                      ],
                                                                                                    ),
                                                                                                  ),
                                                                                                  actions: <Widget>[
                                                                                                    TextButton(
                                                                                                      child: Text('OK'),
                                                                                                      onPressed: () {
                                                                                                        Navigator.of(context).pop();
                                                                                                        Navigator.of(context).pop();
                                                                                                      },
                                                                                                    ),
                                                                                                  ],
                                                                                                );
                                                                                              },
                                                                                            );
                                                                }
                                                            },
                                                          ),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                );
                                              }
                                          ),

                                        ),
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
