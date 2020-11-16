import 'package:flutter/material.dart';
import 'package:sac/screens/complaintForm.dart';
class UserHome extends StatefulWidget {
  @override
  _UserHomeState createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
         backgroundColor: Colors.blue[300],
          leading: IconButton(icon: Icon(Icons.admin_panel_settings),onPressed: (){
          print("Click");},),
        ),
    body: const Center(
    ),
        floatingActionButton: FloatingActionButton(
        elevation: 10.0,
          child: Icon(Icons.add),
          onPressed: (){
          Navigator.push(context,
              MaterialPageRoute(builder: (context){return complaintForm();}));
          },
    ),
    );

  }
}
