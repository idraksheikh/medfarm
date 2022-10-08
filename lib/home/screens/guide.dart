


import 'package:flutter/material.dart';

class GuidePage extends StatefulWidget{
  const GuidePage({Key? key}) : super(key: key);

  @override 
  State createState()=> _GuidePage();
}
class _GuidePage extends State<GuidePage>{
  @override
  Widget build(BuildContext context){
    return  Scaffold(
      body:Center(
        child:      Text(
        'GuidePage',
        style: TextStyle(
          color: Colors.blue.shade600,
        ),
      )
      )
    );
  }
}