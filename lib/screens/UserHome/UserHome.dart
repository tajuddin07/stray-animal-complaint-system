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


  @override
  Widget build(BuildContext context) {


    fetchComplaint() {
      return   Firestore.instance
          .collection("complaint")
          .where("User ID", isEqualTo:user.uid )
          .snapshots();
    }



    Size size = MediaQuery.of(context).size;




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
                  dynamic result1 = await _auth.signOut();
                  print(result1);
                  if(result1==null){
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
                                  builder: (BuildContext context) => LoginView(),
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
                                        decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
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
                                                            Row(
                                                              children: [
                                                                Text("Detail: "),
                                                                Expanded(
                                                                  child: Text(snapshot.data.documents[i]["Detail"],
                                                                    maxLines :4,
                                                                    overflow: TextOverflow.ellipsis,
                                                                    textDirection: TextDirection.ltr,
                                                                    textAlign: TextAlign.justify,
                                                                  ),

                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(height: size.height*0.01),
                                                            Row(
                                                              children: [
                                                                Text("Status: "),
                                                                Text(snapshot.data.documents[i]["Status"]),
                                                              ],
                                                            ),
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
                                                         /* alignment: Alignment.bottomLeft,
                                                          child: TextButton(
                                                            child: Text('Call'),
                                                            onPressed: () {
                                                              // Navigator.of(context).pop();
                                                              UrlLauncher.launch('tel:'+snapshot.data.documents[i]["Phone Number"]);
                                                            },
                                                          ),*/
                                                        ),
                                                        /*TextButton(
                                                          child: Text('Route'),
                                                          onPressed: () async{
                                                            final availableMaps = await MapLauncher.installedMaps;
                                                            print(availableMaps); // [AvailableMap { mapName: Google Maps, mapType: google }, ...]

                                                            await availableMaps.first.showMarker(
                                                              coords: Coords(snapshot.data.documents[i]["latitude"], snapshot.data.documents[i]["longtitude"]),
                                                              title: snapshot.data.documents[i]["Garage Name"],
                                                            );
                                                          },
                                                        ),*/
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
