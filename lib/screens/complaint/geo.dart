import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:sac/screens/complaint/complaint.dart';
import 'package:sac/services/authservice.dart';
import 'package:sac/screens/UserHome/UserHome.dart';
import 'package:geolocator/geolocator.dart'as a;
import 'package:location/location.dart';
import 'package:sac/services/authservice.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
FirebaseUser user;
TextStyle style = TextStyle(fontFamily: 'Oswald', fontSize: 20.0);
List<Marker> allMarkers = [];
List<Marker> myMarker = [];
LatLng _initialcameraposition = LatLng(2.499930, 102.859573);
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Maps'),
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
                      barrierDismissible: false, // user must tap button!
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
