import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medfarm/screens/authentication/authenticate.dart';
import 'package:provider/provider.dart';
import './home/doctor_registration.dart';
import './home/home.dart';


class Wrapper extends StatelessWidget{
  const Wrapper({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final user=context.watch<User?>();
    
    if(user==null){
      return MaterialApp(
      debugShowCheckedModeBanner: false,
      // ignore: unrelated_type_equality_checks
      home: const Authenticate(),
      routes: {
        'doctorregistration': (context) => const DoctorRegistrationPage(),
        'home': (context) =>  Home(forTap: 0,),
        
        
      },
    );
    }else{
      print(user.uid.toString());
      
      return MaterialApp(
      debugShowCheckedModeBanner: false,
      // ignore: unrelated_type_equality_checks
      home:Home(forTap: 0,uid:user.uid.toString()),
      routes: {
        'doctorregistration': (context) => const DoctorRegistrationPage(),
        'home': (context) =>  Home(forTap: 0,),
        
        
      },
    );
    }
    
    
  }
}