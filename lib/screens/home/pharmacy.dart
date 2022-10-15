import 'package:flutter/material.dart';

class Pharmacy extends StatefulWidget {
  const Pharmacy({Key? key}) : super(key: key);

  @override
  State createState() => _Pharmacy();
}

class _Pharmacy extends State<Pharmacy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      Container(
        height: 230,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(50),
          ),
          color: Color(0xFF363f3),
        ),
        child: Stack(children: [
          Positioned(
              top: 80,
              left: 0,
              child: Container(
                height: 100,
                width: 300,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(50),
                        bottomRight: Radius.circular(50))),
              )),
          Positioned(
            top: 110,
            left: 20,
            child: Text("Pharmacy Store",
                style: TextStyle(fontSize: 20, color: Color(0xFF363f93))),
          ),
        ]),
      ),
      SizedBox(
        height: MediaQuery.of(context).size.height * 0.05,
      ),
      Container(
       
        height: 230,
        child: Stack(
          children: [
            Positioned(
              top: 35,
              left: 20,
              child: Material(
                child: Container(
                  height: 188.0,
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.blue.withOpacity(0.3),
                            offset: Offset(-10.0, 10.0),
                            blurRadius: 20.0,
                            spreadRadius: 4.0)
                      ]),
                ),
              ),
            ),
            Positioned(
                top: 0,
                left: 30,
                child: Card(
                  elevation: 10.0,
                  shadowColor: Colors.blue.shade300,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Container(
                    height: 200,
                    width: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage("lib/images/heart.jpeg"),
                      ),
                    ),
                    child:Positioned(
                top: 45,
                left: 160,
                child: Container(
                  child: Column(
                    children:const  [
                      Text(
                        "Ashwin Khale",
                        style: TextStyle(
                            fontSize: 20.0,
                            color: Color(0xFF363f93),
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                )) ,
                  ),
                ),
                ),
            
          ],
        ),
      )
    ]));
  }
}