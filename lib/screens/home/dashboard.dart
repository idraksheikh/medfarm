


import 'package:flutter/material.dart';

class DashBoard extends StatefulWidget{
  const DashBoard({Key? key}) : super(key: key);

  @override 
  State createState()=> _DashBoard();
}
class _DashBoard extends State<DashBoard>{
  @override
  Widget build(BuildContext context){
    return  Scaffold(
      body:Center(
        child:      Text(
        'HomePage',
        style: TextStyle(
          color: Colors.blue.shade600,
        ),
      )
      )

    );
  }
}