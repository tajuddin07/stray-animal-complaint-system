

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:sac/locator.dart';
import 'package:sac/model/userModel.dart';
import 'package:sac/services/api.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CRUDModel extends ChangeNotifier{
  Api _api= locator<Api>();

  List<Users> users;

  Future<List<Users>> fetchProducts() async {
    var result = await _api.getDataCollection();
    users = result.documents
        .map((doc) => Users.fromMap(doc.data, doc.documentID))
        .toList();
    return users;
  }

  Stream<QuerySnapshot> fetchProductsAsStream() {
    return _api.streamDataCollection();
  }

  Future<Users> getProductById(String id) async {
    var doc = await _api.getDocumentById(id);
    return  Users.toJson(doc.data, doc.documentID) ;
  }


  Future removeProduct(String id) async{
    await _api.removeDocument(id) ;
    return ;
  }
  Future updateProduct(Users data,String id) async{
    await _api.updateDocument(data.toJson(), id) ;
    return ;
  }

  Future addProduct(Users data) async{
    var result  = await _api.addDocument(data.toJson()) ;

    return ;

  }

}