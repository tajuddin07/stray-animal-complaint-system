import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:sac/screens/complaint/complaint.dart';
import 'package:sac/services/authservice.dart';
import 'package:sac/screens/UserHome/UserHome.dart';
import 'package:geolocator/geolocator.dart'as a;
import 'package:location/location.dart';
import 'package:sac/services/authservice.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sac/screens/login/login.dart';
import 'package:sac/screens/UserHome/UserProfile.dart';
final FirebaseAuth auth = FirebaseAuth.instance;
FirebaseUser user;
TextStyle style = TextStyle(fontFamily: 'Oswald', fontSize: 20.0);
List<Marker> allMarkers = [];
List<Marker> myMarker = [];
Location _location = Location();
final a.Geolocator geolocator = a.Geolocator()..forceAndroidLocationManager;
a.Position _currentPosition;
String _currentAddress;
final AuthenticationService _auth = AuthenticationService();
GoogleMapController _controller;
double lat;
double long;


class Geo extends StatefulWidget {
  @override
  final String date,detail,species,subject;
  final int radius,priority;

  Geo({this.date,this.detail,this.priority,this.species,this.subject,this.radius});

  _GeoState createState() => _GeoState();
}

class _GeoState extends State<Geo> {

  void _onMapCreated(GoogleMapController _cntlr)
  {
    _controller = _cntlr;
    _location.onLocationChanged.listen((l) {
      _controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(l.latitude, l.longitude),zoom: 10),
        ),
      );
    });
  }
  _getCurrentLocation() {
    geolocator
        .getCurrentPosition(desiredAccuracy: a.LocationAccuracy.best)
        .then((a.Position position) {
      setState(() {
        _currentPosition = position;
      });

      _getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
  }
  _getAddressFromLatLng() async {
    try {
      List<a.Placemark> p = await geolocator.placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      a.Placemark place = p[0];

      setState(() {
        _currentAddress =
        "${place.locality}, ${place.postalCode}, ${place.country}";
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initUser();
    _getCurrentLocation();
    allMarkers.add(Marker(
        markerId: MarkerId('myMarker'),
        draggable: true,
        onTap: () {
          print('Marker Tapped');
        },
        position: LatLng(40.7128, -74.0060)));
  }

  initUser() async {
    user = await auth.currentUser();
    print(user.email);
    setState(() {});
    //print(user.uid);
  }


  @override
  Widget build(BuildContext context) {
    LatLng _initialcameraposition = LatLng(_currentPosition.latitude, _currentPosition.longitude);

    return Scaffold(
      appBar: AppBar(title: Text("Please enter the last seen area"),),
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
      body: Stack(
          children: [Container(
            height: MediaQuery.of(context).size.height*0.8,
            width: MediaQuery.of(context).size.width,
            child: GoogleMap(
              initialCameraPosition: CameraPosition(target: _initialcameraposition,zoom: 17),
              markers: Set.from(myMarker),
              onMapCreated: mapCreated,
              onTap: _handleTap,
            ),
          ),
            Align(
              alignment: Alignment.bottomCenter,
              child:  FloatingActionButton.extended(
                  heroTag: Icons.add,
                  icon: Icon(Icons.add),
                  label : Text("Add Complaint"),
                  onPressed:()async{
                    //regComplaint .. send data  to authservices
                    dynamic result = await _auth.regComplaint(widget.date,widget.detail,lat,long,widget.priority,widget.species,widget.subject,widget.radius);
                    print(result);
                    showDialog(
                      context: context,
                      barrierDismissible: true, // user must tap button!
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Complaint Succesfully issued"),
                          content: SingleChildScrollView(
                            child: ListBody(
                              children: <Widget>[
                                Text('Tap OK to return to Dashbaord'),
                              ],
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: Text('OK'),
                              onPressed: () async {Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) => Dashboard(),
                                ),
                                    (route) => true,
                              );},
                            ),
                          ],
                        );
                      },
                    );

                  } ),
            ),

            SizedBox(
              height: 25.0,
            )
          ]
      ),
    );
  }
  void mapCreated(controller) {
    setState(() {
      _controller = controller;
    });
  }

  _handleTap(LatLng tappedPoint){
    print(tappedPoint);
    setState(() {
      myMarker = [];
      myMarker.add(Marker(
        markerId: MarkerId(tappedPoint.toString()),
        position: tappedPoint,
        draggable: true,
      ));
    });
    lat = tappedPoint.latitude;
    long = tappedPoint.longitude;
    print(lat);
    print(long);

  }

  movetoBoston() {
    _controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(target: LatLng(42.3601, -71.0589), zoom: 14.0, bearing: 45.0, tilt: 45.0),
    ));
  }

  movetoNewYork() {
    _controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(target: LatLng(40.7128, -74.0060), zoom: 12.0),
    ));
  }

  movetoMy() {
    _controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(target: LatLng(_currentPosition.latitude, _currentPosition.longitude), zoom: 12.0),
    ));
  }
}
