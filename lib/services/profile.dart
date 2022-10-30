import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import './model/user.dart';
class ProfileService {
  Future showProfile(String uid)async{
    try {
        DocumentSnapshot<Map<String, dynamic>> res=await FirebaseFirestore.instance.collection('user').doc(uid).get();
        UserData userData=UserData.fromJson(jsonDecode(res[0]));   
        return userData;
    } catch (e) {
      return e.toString();
      
    }
    

  }
  
}