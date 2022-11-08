import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:medfarm/services/model/user.dart';
// import 'package:medfarm/services/model/doctorinfo.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import './model/user.dart';
class DoctorService{
  final FirebaseAuth _auth=FirebaseAuth.instance;
  var userDocumentList= FirebaseFirestore.instance.collection('users');
  var doctorDocumentList= FirebaseFirestore.instance.collection('doctors');
  var appointmentDocumentList= FirebaseFirestore.instance.collection('appointments');
  
  Future registerDoctor(String? address,String certificate,String? degree,String? specialisation)async{
     try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      User? user= _auth.currentUser;
    String id=user!.uid;
    String email=user.email!;
    UserData userData=await userDocumentList.where('email',isEqualTo: email).get().then((value) {
     return UserData.fromJson(value.docs[0].data());
    });

    await doctorDocumentList.doc(id).set({
      'email':email,
      'doctorname':userData.username,
      'address':address,
      'degree':degree,
      'certificate':certificate,
      'specialisation':specialisation,
      

    });
    await userDocumentList.doc(id).update({
      'access':"Doctor",
    });
    preferences.setString('access', "Doctor");
    return "true";
    }catch(e){
        print(e);
        return null;
    }

  }
  Future bookAppointment(String? doctorname,String? date,String? time)async{
        try {
          User? user= _auth.currentUser;
          String id=user!.uid;
          String? email=user.email;
          
          UserData userData=await userDocumentList.where('email',isEqualTo: email).get().then((value) {
     return UserData.fromJson(value.docs[0].data());
    });
          String? patientname=userData.username;
          await appointmentDocumentList.doc().set({
             'doctorname': doctorname,
             'patientname':patientname,
             'date':date,
             'time':time
          });
        return "true";
        } catch (e) {
          print(e.toString());
          return null;
        }
  }

  
}