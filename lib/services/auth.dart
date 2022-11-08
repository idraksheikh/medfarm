import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:medfarm/services/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';




class AuthService{
  final FirebaseAuth _auth=FirebaseAuth.instance;
  
  //auth change user stream
  Stream<User?> get user{
    
    return _auth.authStateChanges();
  }

  //login using email and password.

  Future login(String email,String password)async{
   
      try {
         SharedPreferences preferences = await SharedPreferences.getInstance();
          UserCredential result=await _auth.signInWithEmailAndPassword(email: email, password: password);
          preferences.setString('email', email);
          return result.user;
      }on FirebaseAuthException catch (e) {
         print(e.code);
        return e.code;
      }
  }
  //Register using email and password.
  Future sigup(String email,String password,String username,String? bloodgroup, String address,int? mobile,String? dob,String? gender) async{
   
      try{
         SharedPreferences preferences = await SharedPreferences.getInstance();
        await _auth.createUserWithEmailAndPassword(email: email, password: password).then((value) {
          FirebaseFirestore.instance.collection('users').doc(value.user!.uid).set({
          'email':email,          
          'username':username,
          'bloodgroup':bloodgroup,
          'address':address,
          'mobile':mobile,
          'gender':gender,
          'dob':dob,
          'access':'User',
        });
        }); 
        preferences.setString('email', email);
        preferences.setString('access', 'User');
        return user;
      }on FirebaseAuthException catch (e) {
         print(e.code);
        return e.code;
      }
  }
  //SignOut
  Future signOut() async{
    try {
      return await _auth.signOut();
    }on FirebaseAuthException catch (e) {
         print(e.code);
        return e.code;
      }
      catch(e){
        print(e);
        return e;
      }
  }


  
  Future deleteAccount(String email,String password)async{
  try {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    User? user= _auth.currentUser;

    AuthCredential credential=EmailAuthProvider.credential(email: email, password: password);

    await user!.reauthenticateWithCredential(credential).then((value) async{
      String id=value.user!.uid;
      String? access=preferences.getString('access');
      print(id);
      value.user!.delete().then((value) => {
        FirebaseFirestore.instance.collection('users').doc(id).delete().then((value) => {
          if(access=="Doctor"){
              FirebaseFirestore.instance.collection('doctors').doc(id).delete()
          }
        })

        
      });
    });
    return "Delete";
  } catch (e) {
    print(e);
    return null;
  }
  }
}
