
import 'package:sac/screens/complaint/geo.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sac/screens/login/login.dart';
import 'package:sac/services/authservice.dart';
import 'package:sac/screens/Wrapper.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart' as a;
import 'package:location/location.dart';
import 'package:geodesy/geodesy.dart' as d;
import 'package:sac/screens/AWrapper.dart';
class DashboardAuth extends StatefulWidget {
  final appTitle = 'Stray Animal Complaint';
  @override
  _DashboardAuthState createState() => _DashboardAuthState();
}

class _DashboardAuthState extends State<DashboardAuth> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  String uid;
  String role;
  String email;
  FirebaseUser user;
  Future<FirebaseUser> _user = FirebaseAuth.instance.currentUser();
  TextStyle style = TextStyle(fontFamily: 'Oswald', fontSize: 20.0);
  final AuthenticationService _auth = AuthenticationService();
  GoogleMapController _controller;
  Location _location = Location();
  final a.Geolocator geolocator = a.Geolocator()..forceAndroidLocationManager;
  a.Position _currentPosition;
  String _currentAddress;
  d.Geodesy geodesy = new d.Geodesy();
  _getCurrentLocation() {
    geolocator
        .getCurrentPosition(desiredAccuracy: a.LocationAccuracy.best)
        .then((a.Position position) {
      setState(() {
        _currentPosition = position;
      });

    }).catchError((e) {
      print(e);
    });
  }
  @override
  void initState() {
    super.initState();
    initUser();
    _getCurrentLocation();
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

  @override
  Widget build(BuildContext context) {



    fetchComplaint5() {
      return   Firestore.instance
          .collection("complaint")
          .where("Priority",isEqualTo: 5)
          .where("Status",isEqualTo: "On-Going")
          .snapshots();
    }
    fetchComplaint4() {
      return   Firestore.instance
          .collection("complaint")
          .where("Priority",isEqualTo: 4)
          .where("Status",isEqualTo: "On-Going")
          .snapshots();
    }
    fetchComplaint3() {
      return   Firestore.instance
          .collection("complaint")
          .where("Priority",isEqualTo: 3)
          .where("Status",isEqualTo: "On-Going")
          .snapshots();
    }
    fetchComplaint2() {
      return   Firestore.instance
          .collection("complaint")
          .where("Priority",isEqualTo: 2)
          .where("Status",isEqualTo: "On-Going")
          .snapshots();
    }
    fetchComplaint1() {
      return
         Firestore.instance
              .collection("complaint")
                .where("Priority",isEqualTo: 1)
              .where("Status",isEqualTo: "On-Going")
          .snapshots();
    }



    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.blueAccent,
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
                if(result==null){
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
        body: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/bgall.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(

              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ExpansionTile(
                      title: Text("Priority 5",style: TextStyle(color: Colors.white),),
                      children:<Widget> [
                        Container(
                          height: size.height*0.7 ,
                          child: StreamBuilder<QuerySnapshot>(
                            stream: fetchComplaint5(),
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
                                                          onPressed: ()async{
                                                            // get current auth location with distance between complaint area
                                                            d.LatLng currentAuth= d.LatLng(_currentPosition.latitude,_currentPosition.longitude);
                                                            d.LatLng currentUser= d.LatLng(snapshot.data.documents[i]["Lat"],snapshot.data.documents[i]["Long"]);
                                                            double distance = geodesy.distanceBetweenTwoGeoPoints(currentUser, currentAuth);
                                                            double rDistance = distance/1000;
                                                            double calDistance = double.parse(rDistance.toStringAsFixed(2)) ;
                                                            print("[distanceBetweenTwoGeoPoints] Distance: " + distance.toString());
                                                            print("current auth location"+ currentAuth.toString());

                                                            var usDocument = await Firestore.instance.collection('users')
                                                                .document(snapshot.data.documents[i]["User ID"])
                                                                .get();

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
                                                                        SizedBox(height: size.height*0.01),
                                                                        Row(
                                                                          children: [
                                                                            Text("Issuer Name: "),
                                                                            Text(usDocument.data["Name"]),
                                                                          ],
                                                                        ),
                                                                        SizedBox(height: size.height*0.01),
                                                                        Row(
                                                                          children: [
                                                                            Text("Issuer Contact Number: "),
                                                                            Text(usDocument.data["Phone Number"]),
                                                                          ],
                                                                        ),
                                                                        SizedBox(height: size.height*0.01),
                                                                        Row(
                                                                          children: [
                                                                            Text("Issuer Address: "),
                                                                            Expanded(
                                                                              child: Text(usDocument.data["Address"],
                                                                                maxLines :5,
                                                                                textDirection: TextDirection.ltr,
                                                                                textAlign: TextAlign.left,
                                                                              ),
                                                                            )
                                                                          ],
                                                                        ),
                                                                        Row(
                                                                          children: [
                                                                            Text("My Current Location: ",maxLines: 2,),
                                                                            Expanded(
                                                                              child: Text(currentAuth.toString(),
                                                                                textDirection: TextDirection.ltr,
                                                                                textAlign: TextAlign.left,
                                                                              ),
                                                                            )
                                                                          ],
                                                                        ),
                                                                        Row(
                                                                          children: [
                                                                            Text("Distance with complaint area: ",maxLines: 2,),
                                                                            Expanded(
                                                                              child: Text(calDistance.toString()+" KM",
                                                                                textDirection: TextDirection.ltr,
                                                                                textAlign: TextAlign.left,
                                                                              ),
                                                                            )
                                                                          ],
                                                                        ),

                                                                      ],
                                                                    ),
                                                                  ),
                                                                  actions: <Widget>[
                                                                    FloatingActionButton(onPressed: ()
                                                                    {}),
                                                                    Align(
                                                                      alignment: Alignment.bottomLeft,
                                                                      child: TextButton(
                                                                        child: Text('Back'),
                                                                        onPressed: () {
                                                                          Navigator.of(context).pop();
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
                        ),
                      ],
                    ),
                    ExpansionTile(
                      title: Text("Priority 4",style: TextStyle(color: Colors.white),),
                      children:<Widget> [
                        Container(
                          height: size.height*0.7 ,
                          child: StreamBuilder<QuerySnapshot>(
                            stream: fetchComplaint4(),
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
                                                          onPressed: ()async{
                                                            // get current auth location with distance between complaint area
                                                            d.LatLng currentAuth= d.LatLng(_currentPosition.latitude,_currentPosition.longitude);
                                                            d.LatLng currentUser= d.LatLng(snapshot.data.documents[i]["Lat"],snapshot.data.documents[i]["Long"]);
                                                            double distance = geodesy.distanceBetweenTwoGeoPoints(currentUser, currentAuth);
                                                            double rDistance = distance/1000;
                                                            double calDistance = double.parse(rDistance.toStringAsFixed(2)) ;
                                                            print("[distanceBetweenTwoGeoPoints] Distance: " + distance.toString());
                                                            print("current auth location"+ currentAuth.toString());

                                                            var usDocument = await Firestore.instance.collection('users')
                                                                .document(snapshot.data.documents[i]["User ID"])
                                                                .get();

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
                                                                        SizedBox(height: size.height*0.01),
                                                                        Row(
                                                                          children: [
                                                                            Text("Issuer Name: "),
                                                                            Text(usDocument.data["Name"]),
                                                                          ],
                                                                        ),
                                                                        SizedBox(height: size.height*0.01),
                                                                        Row(
                                                                          children: [
                                                                            Text("Issuer Contact Number: "),
                                                                            Text(usDocument.data["Phone Number"]),
                                                                          ],
                                                                        ),
                                                                        SizedBox(height: size.height*0.01),
                                                                        Row(
                                                                          children: [
                                                                            Text("Issuer Address: "),
                                                                            Expanded(
                                                                              child: Text(usDocument.data["Address"],
                                                                                maxLines :5,
                                                                                textDirection: TextDirection.ltr,
                                                                                textAlign: TextAlign.left,
                                                                              ),
                                                                            )
                                                                          ],
                                                                        ),
                                                                        Row(
                                                                          children: [
                                                                            Text("My Current Location: ",maxLines: 2,),
                                                                            Expanded(
                                                                              child: Text(currentAuth.toString(),
                                                                                textDirection: TextDirection.ltr,
                                                                                textAlign: TextAlign.left,
                                                                              ),
                                                                            )
                                                                          ],
                                                                        ),
                                                                        Row(
                                                                          children: [
                                                                            Text("Distance with complaint area: ",maxLines: 2,),
                                                                            Expanded(
                                                                              child: Text(calDistance.toString()+" KM",
                                                                                textDirection: TextDirection.ltr,
                                                                                textAlign: TextAlign.left,
                                                                              ),
                                                                            )
                                                                          ],
                                                                        ),

                                                                      ],
                                                                    ),
                                                                  ),
                                                                  actions: <Widget>[
                                                                    FloatingActionButton(onPressed: ()
                                                                    {}),
                                                                    Align(
                                                                      alignment: Alignment.bottomLeft,
                                                                      child: TextButton(
                                                                        child: Text('Back'),
                                                                        onPressed: () {
                                                                          Navigator.of(context).pop();
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
                        ),
                      ],
                    ),
                    ExpansionTile(
                      title: Text("Priority 3",style: TextStyle(color: Colors.white),),
                      children:<Widget> [
                        Container(
                          height: size.height*0.7 ,
                          child: StreamBuilder<QuerySnapshot>(
                            stream: fetchComplaint3(),
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
                                                          onPressed: ()async{
                                                            // get current auth location with distance between complaint area
                                                            d.LatLng currentAuth= d.LatLng(_currentPosition.latitude,_currentPosition.longitude);
                                                            d.LatLng currentUser= d.LatLng(snapshot.data.documents[i]["Lat"],snapshot.data.documents[i]["Long"]);
                                                            double distance = geodesy.distanceBetweenTwoGeoPoints(currentUser, currentAuth);
                                                            double rDistance = distance/1000;
                                                            double calDistance = double.parse(rDistance.toStringAsFixed(2)) ;
                                                            print("[distanceBetweenTwoGeoPoints] Distance: " + distance.toString());
                                                            print("current auth location"+ currentAuth.toString());

                                                            var usDocument = await Firestore.instance.collection('users')
                                                                .document(snapshot.data.documents[i]["User ID"])
                                                                .get();

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
                                                                        SizedBox(height: size.height*0.01),
                                                                        Row(
                                                                          children: [
                                                                            Text("Issuer Name: "),
                                                                            Text(usDocument.data["Name"]),
                                                                          ],
                                                                        ),
                                                                        SizedBox(height: size.height*0.01),
                                                                        Row(
                                                                          children: [
                                                                            Text("Issuer Contact Number: "),
                                                                            Text(usDocument.data["Phone Number"]),
                                                                          ],
                                                                        ),
                                                                        SizedBox(height: size.height*0.01),
                                                                        Row(
                                                                          children: [
                                                                            Text("Issuer Address: "),
                                                                            Expanded(
                                                                              child: Text(usDocument.data["Address"],
                                                                                maxLines :5,
                                                                                textDirection: TextDirection.ltr,
                                                                                textAlign: TextAlign.left,
                                                                              ),
                                                                            )
                                                                          ],
                                                                        ),
                                                                        Row(
                                                                          children: [
                                                                            Text("My Current Location: ",maxLines: 2,),
                                                                            Expanded(
                                                                              child: Text(currentAuth.toString(),
                                                                                textDirection: TextDirection.ltr,
                                                                                textAlign: TextAlign.left,
                                                                              ),
                                                                            )
                                                                          ],
                                                                        ),
                                                                        Row(
                                                                          children: [
                                                                            Text("Distance with complaint area: ",maxLines: 2,),
                                                                            Expanded(
                                                                              child: Text(calDistance.toString()+" KM",
                                                                                textDirection: TextDirection.ltr,
                                                                                textAlign: TextAlign.left,
                                                                              ),
                                                                            )
                                                                          ],
                                                                        ),

                                                                      ],
                                                                    ),
                                                                  ),
                                                                  actions: <Widget>[
                                                                    FloatingActionButton(onPressed: ()
                                                                    {}),
                                                                    Align(
                                                                      alignment: Alignment.bottomLeft,
                                                                      child: TextButton(
                                                                        child: Text('Back'),
                                                                        onPressed: () {
                                                                          Navigator.of(context).pop();
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
                        ),
                      ],
                    ),
                    ExpansionTile(
                      title: Text("Priority 2",style: TextStyle(color: Colors.white),),
                      children:<Widget> [
                        Container(
                          height: size.height*0.7 ,
                          child: StreamBuilder<QuerySnapshot>(
                            stream: fetchComplaint2(),
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
                                                          onPressed: ()async{
                                                            // get current auth location with distance between complaint area
                                                            d.LatLng currentAuth= d.LatLng(_currentPosition.latitude,_currentPosition.longitude);
                                                            d.LatLng currentUser= d.LatLng(snapshot.data.documents[i]["Lat"],snapshot.data.documents[i]["Long"]);
                                                            double distance = geodesy.distanceBetweenTwoGeoPoints(currentUser, currentAuth);
                                                            double rDistance = distance/1000;
                                                            double calDistance = double.parse(rDistance.toStringAsFixed(2)) ;
                                                            print("[distanceBetweenTwoGeoPoints] Distance: " + distance.toString());
                                                            print("current auth location"+ currentAuth.toString());

                                                            var usDocument = await Firestore.instance.collection('users')
                                                                .document(snapshot.data.documents[i]["User ID"])
                                                                .get();

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
                                                                        SizedBox(height: size.height*0.01),
                                                                        Row(
                                                                          children: [
                                                                            Text("Issuer Name: "),
                                                                            Text(usDocument.data["Name"]),
                                                                          ],
                                                                        ),
                                                                        SizedBox(height: size.height*0.01),
                                                                        Row(
                                                                          children: [
                                                                            Text("Issuer Contact Number: "),
                                                                            Text(usDocument.data["Phone Number"]),
                                                                          ],
                                                                        ),
                                                                        SizedBox(height: size.height*0.01),
                                                                        Row(
                                                                          children: [
                                                                            Text("Issuer Address: "),
                                                                            Expanded(
                                                                              child: Text(usDocument.data["Address"],
                                                                                maxLines :5,
                                                                                textDirection: TextDirection.ltr,
                                                                                textAlign: TextAlign.left,
                                                                              ),
                                                                            )
                                                                          ],
                                                                        ),
                                                                        Row(
                                                                          children: [
                                                                            Text("My Current Location: ",maxLines: 2,),
                                                                            Expanded(
                                                                              child: Text(currentAuth.toString(),
                                                                                textDirection: TextDirection.ltr,
                                                                                textAlign: TextAlign.left,
                                                                              ),
                                                                            )
                                                                          ],
                                                                        ),
                                                                        Row(
                                                                          children: [
                                                                            Text("Distance with complaint area: ",maxLines: 2,),
                                                                            Expanded(
                                                                              child: Text(calDistance.toString()+" KM",
                                                                                textDirection: TextDirection.ltr,
                                                                                textAlign: TextAlign.left,
                                                                              ),
                                                                            )
                                                                          ],
                                                                        ),

                                                                      ],
                                                                    ),
                                                                  ),
                                                                  actions: <Widget>[
                                                                    FloatingActionButton(onPressed: ()
                                                                    {}),
                                                                    Align(
                                                                      alignment: Alignment.bottomLeft,
                                                                      child: TextButton(
                                                                        child: Text('Back'),
                                                                        onPressed: () {
                                                                          Navigator.of(context).pop();
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
                        ),
                      ],
                    ),
                    ExpansionTile(
                      title: Text("Priority 1",style: TextStyle(color: Colors.white),),
                      children:<Widget> [
                        Container(
                          height: size.height*0.7 ,
                          child: StreamBuilder<QuerySnapshot>(
                            stream: fetchComplaint1(),
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
                                                          onPressed: ()async{
                                                            // get current auth location with distance between complaint area
                                                            d.LatLng currentAuth= d.LatLng(_currentPosition.latitude,_currentPosition.longitude);
                                                            d.LatLng currentUser= d.LatLng(snapshot.data.documents[i]["Lat"],snapshot.data.documents[i]["Long"]);
                                                            double distance = geodesy.distanceBetweenTwoGeoPoints(currentUser, currentAuth);
                                                            double rDistance = distance/1000;
                                                            double calDistance = double.parse(rDistance.toStringAsFixed(2)) ;
                                                            print("[distanceBetweenTwoGeoPoints] Distance: " + distance.toString());
                                                            print("current auth location"+ currentAuth.toString());

                                                            var usDocument = await Firestore.instance.collection('users')
                                                                .document(snapshot.data.documents[i]["User ID"])
                                                                .get();

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
                                                                        SizedBox(height: size.height*0.01),
                                                                        Row(
                                                                          children: [
                                                                            Text("Issuer Name: "),
                                                                            Text(usDocument.data["Name"]),
                                                                          ],
                                                                        ),
                                                                        SizedBox(height: size.height*0.01),
                                                                        Row(
                                                                          children: [
                                                                            Text("Issuer Contact Number: "),
                                                                            Text(usDocument.data["Phone Number"]),
                                                                          ],
                                                                        ),
                                                                        SizedBox(height: size.height*0.01),
                                                                        Row(
                                                                          children: [
                                                                            Text("Issuer Address: "),
                                                                            Expanded(
                                                                              child: Text(usDocument.data["Address"],
                                                                                maxLines :5,
                                                                                textDirection: TextDirection.ltr,
                                                                                textAlign: TextAlign.left,
                                                                              ),
                                                                            )
                                                                          ],
                                                                        ),
                                                                        Row(
                                                                          children: [
                                                                            Text("My Current Location: ",maxLines: 2,),
                                                                            Expanded(
                                                                              child: Text(currentAuth.toString(),
                                                                                textDirection: TextDirection.ltr,
                                                                                textAlign: TextAlign.left,
                                                                              ),
                                                                            )
                                                                          ],
                                                                        ),
                                                                        Row(
                                                                          children: [
                                                                            Text("Distance with complaint area: ",maxLines: 2,),
                                                                            Expanded(
                                                                              child: Text(calDistance.toString()+" KM",
                                                                                textDirection: TextDirection.ltr,
                                                                                textAlign: TextAlign.left,
                                                                              ),
                                                                            )
                                                                          ],
                                                                        ),

                                                                      ],
                                                                    ),
                                                                  ),
                                                                  actions: <Widget>[
                                                                    FloatingActionButton(onPressed: ()
                                                                    {}),
                                                                    Align(
                                                                      alignment: Alignment.bottomLeft,
                                                                      child: TextButton(
                                                                        child: Text('Back'),
                                                                        onPressed: () {
                                                                          Navigator.of(context).pop();
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
                        ),
                      ],
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
