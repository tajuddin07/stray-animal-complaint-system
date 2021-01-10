import 'package:sac/locator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:sac/model/userModel.dart';
import 'package:sac/services/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:sac/services/database.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final Firestore _fs = Firestore.instance;
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

  Future regComplaint(String date, String detail, double lat, double long,int priority,String species,String subject, String UID) async {
    try {
      Firestore.instance.collection('complaint').document()
          .setData({
        'Date': date,
        'Detail': detail,
        'Lat' : lat,
        'Long' : long,
        'Priority' : priority,
        'Species' : species,
        'Status' : 'On-Going',
        'Subject' : subject,
        'UserID' : UID,
          });
      /*await DatabaseService(uid: user.uid).updateAuthoritiesData(email, password, name, address, phoneNo);
      return _userFromFirebaseUser(user);*/
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<void> deleteComplaint(DocumentSnapshot doc) async {
    _fs.collection("complaint").document(doc.documentID).delete();;
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

 /* Future removeComplaint(String uid) async{
    AuthResult result= await _fs ;
    return ;
  }*/




}



/* Future loginWithEmail({
    @required String email,
    @required String password,
  }) async {
    try {
      var authResult = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      await _populateCurrentUser(authResult.user);
      return authResult.user != null;
    } catch (e) {
      return e.message;
    }
  }*/

/* Future signUpWithEmail({
    @required String email,
    @required String password,
    @required String fullName,
    @required String phoneNo,
    @required String address,
    @required String role,

  }) async {
    try {
      var authResult = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // create a new user profile on firestore
      _currentUser = Users(
        id: authResult.user.uid,
        email: email,
        name: fullName,
        role: role,
        address: address,
        phoneNo: phoneNo,
      ) ;

      await _firestoreService.createUser(_currentUser);

      return authResult.user != null;
    } catch (e) {
      return e.message;
    }
  }*/

/*Future<bool> isUserLoggedIn() async {
    var user = await _firebaseAuth.currentUser;
    await _populateCurrentUser(user);
    return user != null;
  }
*/
/*Future _populateCurrentUser(FirebaseUser user) async {
    if (user != null) {
      _currentUser = await _firestoreService.getUser(user.uid);
    }
  }*/
