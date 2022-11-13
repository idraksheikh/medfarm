import 'package:flutter/material.dart';
import 'package:medfarm/screens/home/home.dart';


// import 'package:medfarm/screens/home/home.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  State createState() => _DashBoard();
}

class _DashBoard extends State<DashBoard> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return  Column(
        children: [
          
          Container(
            margin: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.025,
                right: MediaQuery.of(context).size.width * 0.025,
                top: 30),
            alignment: Alignment.center,
            height: MediaQuery.of(context).size.height * 0.4,
            width: MediaQuery.of(context).size.width * 0.95,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.white,
              image: DecorationImage(
                  image: AssetImage("lib/images/home2.png"),
                  fit: BoxFit.cover,
                  opacity: 0.8),
              // boxShadow: [
              //   BoxShadow(
              //     color: Colors.grey,
              //     offset: Offset(-10.0, 10.0),
              //     blurRadius: 20,
              //     spreadRadius: 4,
              //   )
              // ],
            ),
            child: Stack(
              children: [
            //     Positioned(
            //   left: 20,
            //   top: 20,
            //   child: IconButton(
            //     icon: const Icon(Icons.menu),
            //     onPressed: () => scaffoldKey.currentState!.openDrawer(),
            //   ),
            // ),
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    alignment: Alignment.center,
                    height: 60,
                    width: 320,
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                        color: Colors.white.withOpacity(0.7)),
                    child: Stack(
                      children: [
                        
                        Container(
                            margin: const EdgeInsets.only(left: 0, top: 5),
                            height: 50,
                            
                            decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                color: Colors.white.withOpacity(0.5)),
                            child: Image.asset('lib/images/medicine.jpeg')),
                        Positioned(
                            top: 6,
                            left: 110,
                            child: Container(
                              child: Column(
                                children: [
                                  Text(
                                    "MedFarm ",
                                    style: TextStyle(
                                        fontSize: 23,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue[700]),
                                  ),
                                ],
                              ),
                            )),
                        Container(
                          margin: const EdgeInsets.only(top: 32, left: 70),
                          child: Column(
                            children: [
                              Text(
                                "A One Stop Medical Solution ",
                                style:
                                    TextStyle(fontSize: 18, color: Colors.grey[800]),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.03,
              right: MediaQuery.of(context).size.width * 0.03,
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(),
                    InkWell(
                      onTap: () {
                       Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Home(forTap:1)
                        ),
                      );
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: MediaQuery.of(context).size.height * 0.25,
                        width: MediaQuery.of(context).size.width * 0.4,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black,
                          image: const DecorationImage(
                            alignment: Alignment.bottomLeft,
                            image: AssetImage("lib/images/pharmacy.png"),
                            fit: BoxFit.cover,
                            opacity: 0.5,
                          ),
                        ),
                        child: const Text(
                          'PHARMACY',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    InkWell(
                      onTap: () {
                       Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Home(forTap:3)
                        ),
                      );
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: MediaQuery.of(context).size.height * 0.25,
                        width: MediaQuery.of(context).size.width * 0.4,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10),
                          image: const DecorationImage(
                            alignment: Alignment.bottomLeft,
                            image: AssetImage("lib/images/doctor.png"),
                            fit: BoxFit.cover,
                            opacity: 0.5,
                          ),
                        ),
                        child: const Text(
                          'DOCTOR',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: (){
                   Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Home(forTap:4)
                        ),
                      );
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: MediaQuery.of(context).size.height * 0.15,
                    width: MediaQuery.of(context).size.width * 0.85,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.black,
                      image: const DecorationImage(
                        alignment: Alignment.bottomLeft,
                        image: AssetImage("lib/images/guidance.png"),
                        fit: BoxFit.cover,
                        opacity: 0.5,
                      ),
                    ),
                    child: const Text(
                      'GUIDANCE',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      );
  }
}
