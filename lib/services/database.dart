

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/scheduler.dart';
import 'package:sac/model/userModel.dart';
class DatabaseService {

  final String uid;

  DatabaseService({this.uid});

  final CollectionReference UserCollection = Firestore.instance.collection(
      'users');

  final CollectionReference ComplaintCollection = Firestore.instance.collection('complaint');

  Future updateUserData( String email, String password, String name,
      String address, String phoneNo) async {
    return await UserCollection.document(uid).setData(
        {
          'Name': name,
          'Email': email,
          'Address': address,
          'Password': password,
          'Phone Number': phoneNo,
          'Role': 'User',
        });
  }

  Future updateAuthoritiesData( String email, String password, String name,
      String address, String phoneNo) async {
    return await UserCollection.document(uid).setData(
        {
          'Name': name,
          'Email': email,
          'Address': address,
          'Password': password,
          'Phone Number': phoneNo,
          'Role': 'Authorities',
        });
  }

  Future updateComplaintData(String date, String detail,double lat,double long,int priority,String species ,String subject, String userid) async {

    return await ComplaintCollection.document().setData(
        {
          'Date': date,
          'Detail': detail,
          'Lat': lat,
          'Long' : long,
          'Priority' :priority,
          'Species' : species,
          'Status' : "On-Going",
          'Subject' : subject,
          'User ID' : uid,

        });
  }
}
