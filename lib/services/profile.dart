import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import './model/user.dart';
class ProfileService {
  late UserData userData;
  
  Future showProfile(String? email)async{
    try {
      var documentList= FirebaseFirestore.instance.collection('users');
      
        await documentList.where("email",isEqualTo: email).get().then((snapshot){
          
          print(snapshot.docs[0].data());
          userData=UserData.fromJson(snapshot.docs[0].data());
        
        });
        
        return userData;
        
    }on FirebaseException catch (e) {
      print(e.code);
      return e.toString();      
    }catch(e){
      print(e);
      return e.toString();

    }
    

  }
  
}