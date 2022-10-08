


import 'package:flutter/material.dart';

class Pharmacy extends StatefulWidget{
  const Pharmacy({Key? key}) : super(key: key);

  @override 
  State createState()=> _Pharmacy();
}
class _Pharmacy extends State<Pharmacy>{
  @override
  Widget build(BuildContext context){
    return  Scaffold(
      body:Center(
        child:      Text(
        'Pharmacy',
        style: TextStyle(
          color: Colors.blue.shade600,
        ),
      )
      )
    );
  }
}