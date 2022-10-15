import 'package:flutter/material.dart';
// import 'package:medfarm/home/screens/BMI/bmi_result_screen.dart';
import 'dart:math';


import 'package:medfarm/screens/home/BMI/bmi_result_screen.dart';

class BMI extends StatefulWidget{
  const BMI({Key? key}) : super(key: key);

  @override
  State createState() => _BMI();

}
class _BMI extends State<BMI>{
  bool iscalculated=true;
   bool isMale = true;
  double height = 180.0;
  int weight = 40;
  int age = 18;


void updateCal(bool isCal){
  setState(() {
    iscalculated=isCal;
  });
}
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue.shade900,
        title:const  Text(
          "BMI Calculator",
        ),
      ),
      body:
      iscalculated
      ?Column(
        children: [
          /*Male or Female Section*/
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isMale = true;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            10.0,
                          ),
                          color: isMale
                              ? Colors.blue.shade900
                              : Colors.blue.shade300,
                        ),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.man,
                                size: 80.0,
                                color: Colors.white,
                              ),
                              const SizedBox(
                                height: 15.0,
                              ),
                              Text(
                                "MALE",
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.white.withOpacity(0.8),
                                ),
                              ),
                            ]),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isMale = false;
                        });
                      },
                      child: Container(
                       
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            10.0,
                          ),
                          color: !isMale
                             ? Colors.blue.shade900
                              : Colors.blue.shade300,
                        ),
                         child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.woman,
                                size: 80.0,
                                color: Colors.white,
                              ),
                              const SizedBox(
                                height: 15.0,
                              ),
                              Text(
                                "FEMALE",
                                style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.white.withOpacity(0.8),
                                ),
                              ),
                            ]),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          /*Height Section*/
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    10.0,
                  ),
                  color: Colors.blue.shade900,
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "HEIGHT",
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${height.round()}",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 60.0,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          const SizedBox(
                            width: 5.0,
                          ),
                          const Text(
                            "CM",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Slider(
                        value: height,
                        min: 80.0,
                        max: 220.0,
                        onChanged: (value) {
                          setState(() {
                            height = value;
                          });
                        },
                        activeColor: Colors.blue.shade300,
                        inactiveColor: Colors.blue.shade600,
                        thumbColor: Colors.blue.shade50,
                      ),
                    ]),
              ),
            ),
          ),

          /*Weight and Age Section*/
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        10.0,
                      ),
                      color: Colors.blue.shade900,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "WEIGHT",
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white.withOpacity(0.8),
                          ),
                        ),
                        Text(
                          "$weight",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 60.0,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FloatingActionButton(
                              onPressed: () {
                                setState(() {
                                  weight--;
                                });
                              },
                              heroTag: 'Weight-',
                              mini: true,
                              child: const Icon(
                                Icons.remove,
                              ),
                            ),
                            FloatingActionButton(
                              onPressed: () {
                                setState(() {
                                  weight++;
                                });
                              },
                              heroTag: 'Weight+',
                              mini: true,
                              child: const Icon(
                                Icons.add,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20.0,
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        10.0,
                      ),
                      color: Colors.blue.shade900,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "AGE",
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white.withOpacity(0.8),
                          ),
                        ),
                        Text(
                          "$age",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 60.0,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FloatingActionButton(
                              onPressed: () {
                                setState(() {
                                  age--;
                                });
                              },
                              heroTag: 'age-',
                              mini: true,
                              child: const Icon(
                                Icons.remove,
                              ),
                            ),
                            FloatingActionButton(
                              onPressed: () {
                                setState(() {
                                  age++;
                                });
                              },
                              heroTag: 'age+',
                              mini: true,
                              child: const Icon(
                                Icons.add,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),

          /*Calculate Button Section*/
          Container(
            decoration:  BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.blue.shade900,
            ),
            height: 75.0,
            
            child: MaterialButton(
              onPressed: () {
                
                // print(result.round());
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => BMIResultScreen(
                //         result: result,
                //         age: age,
                //         isMale: isMale,
                //       ),
                //     ));
                setState(() {
                  iscalculated=false;  
                });
                
              },
              child: const Text(
                "CALCULATE",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          )
        ],
      )

      :BMIResultScreen(
        result: (weight / pow(height / 100, 2).round()),
         age: age,
          isMale: isMale,
          onChanged: (bool cal){
              updateCal(cal);
          },
          )
     );
  }
}
