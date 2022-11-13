import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './model/user.dart';
class ProfileService {
  late UserData userData;
  final FirebaseAuth _auth=FirebaseAuth.instance;
  var documentList= FirebaseFirestore.instance.collection('users');
  var doctordocumentList= FirebaseFirestore.instance.collection('doctors');
  Future showProfile(String? email)async{
    try {
      
      SharedPreferences preferences = await SharedPreferences.getInstance();
        await documentList.where("email",isEqualTo: email).get().then((snapshot){
          
          print(snapshot.docs[0].data());
          userData=UserData.fromJson(snapshot.docs[0].data());
        
        });
        await preferences.setString('access', userData.access!);
        return userData;
        
    }on FirebaseException catch (e) {
      print(e.code);
      return e.toString();      
    }catch(e){
      print(e);
      return e.toString();

    }   

  }
  Future updateProfile(String? username,String? address,int? mobile,String? gender,String? dob,String? bloodgroup)async{
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      User? user= _auth.currentUser;
    String id=user!.uid;
    String? access=preferences.getString('access');
    await documentList.doc(id).update({
      
                  
          'username':username,
          'bloodgroup':bloodgroup,
          'address':address,
          'mobile':mobile,
          'gender':gender,
          'dob':dob,
          
        
    });
    if(access=="Doctor"){
      await doctordocumentList.doc(id).update({
        'doctorname':username,
      });
    }
    return "true";
    } catch (e) {
      print(e);
      return e;
    }
    
    
  }
  
}