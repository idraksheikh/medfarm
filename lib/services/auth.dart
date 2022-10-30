import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';




class AuthService{
  final FirebaseAuth _auth=FirebaseAuth.instance;
  
  //auth change user stream
  Stream<User?> get user{
    
    return _auth.authStateChanges();
  }

  //login using email and password.

  Future login(String email,String password)async{
      try {
          UserCredential result=await _auth.signInWithEmailAndPassword(email: email, password: password);
          return result.user;
      }on FirebaseAuthException catch (e) {
         print(e.code);
        return e.code;
      }
  }
  //Register using email and password.
  Future sigup(String email,String password,String username,String? bloodgroup, String address,int? mobile,String? dob,String? gender) async{
      try{
        await _auth.createUserWithEmailAndPassword(email: email, password: password).then((value) {
          FirebaseFirestore.instance.collection('users').doc(value.user!.uid).set({
          'email':email,          
          'username':username,
          'bloodgroup':bloodgroup,
          'address':address,
          'mobile':mobile,
          'gender':gender,
          'dob':dob,
        });
        }); 
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
         
        return e.code;
      }
  }
  //forgot password
  
}
