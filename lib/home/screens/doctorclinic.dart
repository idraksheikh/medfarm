


import 'package:flutter/material.dart';

class DoctorClinic extends StatefulWidget{
  const DoctorClinic({Key? key}) : super(key: key);

  @override 
  State createState()=> _DoctorClinic();
}
class _DoctorClinic extends State<DoctorClinic>{
  @override
  Widget build(BuildContext context){
    return  Scaffold(
       body:Center(
        child:      Text(
        'DoctorClinic',
        style: TextStyle(
          color: Colors.blue.shade600,
        ),
      )
      )
    );
  }
}