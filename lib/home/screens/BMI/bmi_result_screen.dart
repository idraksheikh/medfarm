

import 'package:flutter/material.dart';


typedef BoolCallBack = void Function(bool isCalculated);

class BMIResultScreen extends StatelessWidget {
  final bool isMale;
  final double result;
  final int age;
  final cal = true;
  final BoolCallBack onChanged;

  BMIResultScreen(
      {required this.result,
      required this.age,
      required this.isMale,
      required this.onChanged});
 
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.2),
      alignment: Alignment.center,
      decoration:const  BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
         
        children: [
           Text(
                      "Your Body Mass Index(BMI) is",
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.blue.shade900,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),

          // for underweight
          result < 18.5
              ? Column(
                
                  children: [
                    Container(
                      alignment: Alignment.center,
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.red.shade400,
                      ),
                      child: Text("${result.round()}",
                        style:const  TextStyle(
                        fontSize: 25.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Your are Under Weight",
                      style: TextStyle(
                        fontSize: 25.0,
                        color: Colors.red.shade400,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )
              : const Text(''),

              //normal range
               (result >=18.5)&&(result<25)
              ? Column(
                
                  children: [
                    Container(
                      alignment: Alignment.center,
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.green.shade400,
                      ),
                      child: Text("${result.round()}",
                        style:const  TextStyle(
                        fontSize: 25.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Your are in Normal Range",
                      style: TextStyle(
                        fontSize: 25.0,
                        color: Colors.green.shade400,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )
              : const Text(''),



               (result >=25)&&(result<30)
              ? Column(
                
                  children: [
                    Container(
                      alignment: Alignment.center,
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.yellow.shade600,
                      ),
                      child: Text("${result.round()}",
                        style:const  TextStyle(
                        fontSize: 25.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Your are Over Weight",
                      style: TextStyle(
                        fontSize: 25.0,
                        color: Colors.yellow.shade600,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )
              : const Text(''),

              //for obese I

              (result >=30)&&(result<35)
              ? Column(
                
                  children: [
                    Container(
                      alignment: Alignment.center,
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.red.shade400,
                      ),
                      child: Text("${result.round()}",
                        style:const  TextStyle(
                        fontSize: 25.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Your are Obese",
                      style: TextStyle(
                        fontSize: 25.0,
                        color: Colors.red.shade400,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Obese Class I",
                      style: TextStyle(
                        fontSize: 25.0,
                        color: Colors.red.shade400,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )
              : const Text(''),


              //for obese II

               (result >=35)&&(result<40)
              ? Column(
                
                  children: [
                    Container(
                      alignment: Alignment.center,
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.red.shade400,
                      ),
                      child: Text("${result.round()}",
                        style:const  TextStyle(
                        fontSize: 25.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Your are Obese",
                      style: TextStyle(
                        fontSize: 25.0,
                        color: Colors.red.shade500,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Obese Class II",
                      style: TextStyle(
                        fontSize: 25.0,
                        color: Colors.red.shade500,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )
              : const Text(''),

              //for obese III

               (result >=40)
              ? Column(
                
                  children: [
                    Container(
                      alignment: Alignment.center,
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.red.shade400,
                      ),
                      child: Text("${result.round()}",
                        style:const  TextStyle(
                        fontSize: 25.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Your are Obese",
                      style: TextStyle(
                        fontSize: 25.0,
                        color: Colors.red.shade600,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Obese Class III",
                      style: TextStyle(
                        fontSize: 25.0,
                        color: Colors.red.shade600,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )
              : const Text(''),
              const SizedBox(
                height:20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed('home');
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 50,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text("Home",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white)),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                InkWell(
                  onTap: () {
                    onChanged(cal);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 50,
                    width: 200,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text("Calculate Again",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white)),
                  ),
                ),
                ],
              ),



              
          
        ],
      ),
    );
  }
}
