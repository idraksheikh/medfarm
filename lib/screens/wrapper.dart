import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medfarm/screens/authentication/authenticate.dart';
// import 'package:medfarm/screens/starting.dart';
import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import './home/doctor_registration.dart';
import './home/home.dart';

// int? aScreen;
// Future<void> screen()async {
// SharedPreferences preferences = await SharedPreferences.getInstance();
//   aScreen =  preferences.getInt('aScreen');
//   print(aScreen);
// }

class Wrapper extends StatefulWidget{
  const Wrapper({Key? key}) : super(key: key);

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  void initState() {
    
    super.initState();
    // screen();
  }
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
        'home': (context) =>  Home(forTap: 0),
        
        
      },
    );
    }else{
      print(user.uid.toString());
      
      return MaterialApp(
      debugShowCheckedModeBanner: false,
      // ignore: unrelated_type_equality_checks
      home:Home(forTap: 0),
      routes: {
        'doctorregistration': (context) => const DoctorRegistrationPage(),
        'home': (context) =>  Home(forTap: 0),
        
        
      },
    );
    }
   
    
    
    
    
  }
}