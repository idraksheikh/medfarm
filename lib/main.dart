import 'package:flutter/material.dart';
import 'package:medfarm/authentication/signup.dart';
import 'home/doctor_registration.dart';
import 'home/home.dart';
import 'authentication/login.dart';

void main() {
  runApp(const Medfarm());
}

class Medfarm extends StatelessWidget {
  const Medfarm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const LoginPage(),
      routes: {
        'doctorregistration': (context) => const DoctorRegistrationPage(),
        'home': (context) => const Home(),
        'login': (context) => const LoginPage(),
        'signup':(context) => const SignupPage(),
      },
    ));
  }
}
