import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class AddUser extends StatelessWidget {
  final String fullName;
  final String email;
  final String password;
  final String address;
  final String phoneNumb;

  AddUser(this.fullName,this.email,this.password,this.address,this.phoneNumb);

  @override
  Widget build(BuildContext context) {

    CollectionReference users = FirebaseFirestore.instance.collection('users');
    
    Future <void> addUser(){
      return users
          .add({
        'full_name': fullName,
        'email': email,
        'password':password,
        'address' : null,
        'phoneNo' : phoneNumb
      })
      .then((value) => print("User Added"))
          .catchError((error) => print("Failed to Add"));
    }
    return TextButton(
        onPressed: addUser,
        child: Text("Add User"),);
  }
}