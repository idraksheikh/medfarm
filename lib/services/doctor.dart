import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import './model/user.dart';
class DoctorService{
  final FirebaseAuth _auth=FirebaseAuth.instance;
  var userDocumentList= FirebaseFirestore.instance.collection('users');
  var doctorDocumentList= FirebaseFirestore.instance.collection('pendingdoctors');

  Future registerDoctor(String? name,String? address,String certificate,String? degree,String? specialisation)async{
     try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      User? user= _auth.currentUser;
    String id=user!.uid;
    String email=user.email!;
    await doctorDocumentList.doc(id).set({
      'email':email,
      'doctorname':name,
      'address':address,
      'degree':degree,
      'certificate':certificate,
      'specialisation':specialisation,
      

    });
    await userDocumentList.doc(id).update({
      'access':"Doctor-Pending",
    });
    preferences.setString('access', "Doctor-Pending");
    return "true";
    }catch(e){
        print(e);
        return null;
    }

  }
}