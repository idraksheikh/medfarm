import 'package:flutter/material.dart';
import 'package:medfarm/screens/wrapper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Starting extends StatefulWidget {
  Starting({Key? key}) : super(key: key);

  @override
  _StartingState createState() => _StartingState();
}

class _StartingState extends State<Starting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue,
        body: Container(
            child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 30),
              child: Image.asset("lib/images/start.jpeg"),
            ),
            Container(
              margin: EdgeInsets.only(top: 60),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    child: Text(
                      "MedFarm",
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 7, left: 10, right: 10),
                    child: Text(
                      "A One Stop Medical  Solution For All Needs. Get Quality Services at affordable cost",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 30),
              margin: EdgeInsets.only(top: 100),
              child: MaterialButton(
                height: 45,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                elevation: 5,
                color: Color(0xffFF5733),
                onPressed: () async{
                  SharedPreferences preferences = await SharedPreferences.getInstance();
                  await preferences.setInt('aScreen', 1);
                  // ignore: use_build_context_synchronously
                  Navigator.push(context,MaterialPageRoute(builder: (context)=>const Wrapper()));
                },
                child: Stack(
                  children: [
                    Text('Get Started',
                        style: TextStyle(color: Colors.white, fontSize: 20)),
                  ],
                ),
              ),
            ),
          ],
        )));
  }
}