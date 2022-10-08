// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../doctor_registration.dart';
class ProfilePage extends StatefulWidget{
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State createState()=> _ProfilePage();
}
class _ProfilePage extends State<ProfilePage>{
  @override
  Widget build(BuildContext context){
    return const Scaffold(
      
      
      body:DoctorRegistrationPage(),
      
    );
  }
}