


import 'package:flutter/material.dart';

class EmergencyCase extends StatefulWidget{
  const EmergencyCase({Key? key}) : super(key: key);

  @override 
  State createState()=> _EmergencyCase();
}
class _EmergencyCase extends State<EmergencyCase>{
  @override
  Widget build(BuildContext context){
    return  Scaffold(
      body:Center(
        child:      Text(
        'EmergencyCase',
        style: TextStyle(
          color: Colors.blue.shade600,
        ),
      )
      )

    );
  }
}