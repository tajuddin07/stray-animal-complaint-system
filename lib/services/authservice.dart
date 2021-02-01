import 'package:sac/locator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:sac/model/userModel.dart';
import 'package:sac/services/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:sac/services/database.dart';
import 'package:sac/screens/Wrapper.dart';
class AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final Firestore _fs = Firestore.instance;
  FirebaseUser us ;
  String email = "";
  String userid = "";
  String role = "";


  Users _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? Users(id: user.uid) : null;
  }

  Stream<Users> get user {
    return _firebaseAuth.onAuthStateChanged
        .map(_userFromFirebaseUser);
  }

  Future regUser(String email, String password, String name, String address,
      String phoneNo) async {
    try {
      AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      await DatabaseService(uid: user.uid).updateUserData(email, password, name,address,phoneNo);
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future regAuthorities(String email, String password, String name, String address,
      String phoneNo) async {
    try {
      AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      await DatabaseService(uid: user.uid).updateAuthoritiesData(email, password, name, address, phoneNo);
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future regComplaint(String date, String detail, double lat, double long,int priority,String species,String subject,int radius) async {
    try {
      userid = (await _firebaseAuth.currentUser()).uid;
      await DatabaseService(uid: userid).updateComplaintData(date, detail, lat, long,priority,species,subject,radius,userid);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future updateProfile(String email, String password, String name, String address,String phoneNo) async {
    try {
      userid = (await _firebaseAuth.currentUser()).uid;
      await DatabaseService(uid: userid).updateUserData(email, password,name, address,phoneNo);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future updateProfileAuth(String email, String password, String name,
      String address, String phoneNo) async {
    try {
      userid = (await _firebaseAuth.currentUser()).uid;
      await DatabaseService(uid: userid).updateAuthoritiesData(
          email, password, name, address, phoneNo);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<void> deleteComplaint(DocumentSnapshot doc) async {
    _fs.collection("complaint").document(doc.documentID).delete();
  }


  Future signOut() async {
    try {
      return await _firebaseAuth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signInUser(String email, String password) async {
    try {
      AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(
          email: email,
          password: password);
      FirebaseUser users = result.user;
      return _userFromFirebaseUser(users);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future updateComplete(String status, String completeTime,String id) async {
    try {
      await DatabaseService().updateComplete(status, completeTime,id);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future updateInvalid(String status, String completeTime,String id) async {
      try {
        await DatabaseService().updateInvalid(status, completeTime,id);
      } catch (e) {
        print(e.toString());
        return null;
      }
    }
 /* Future removeComplaint(String uid) async{
    AuthResult result= await _fs ;
    return ;
  }*/




}




