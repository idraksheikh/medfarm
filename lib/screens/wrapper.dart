// ignore_for_file: file_names

import 'package:flutter/material.dart';
import './authentication/login.dart';
import './authentication/signup.dart';
import './home/doctor_registration.dart';
import './home/home.dart';
class Wrapper extends StatelessWidget{
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const LoginPage(),
      routes: {
        'doctorregistration': (context) => const DoctorRegistrationPage(),
        'home': (context) => const Home(),
        'login': (context) => const LoginPage(),
        'signup':(context) => const SignupPage(),
        
      },
    );
    
  }
}