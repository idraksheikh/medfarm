import 'package:flutter/material.dart';

class GuidePage extends StatefulWidget {
  const GuidePage({Key? key}) : super(key: key);

  @override
  State createState() => _GuidePage();
}

class _GuidePage extends State<GuidePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Guide'),
          backgroundColor: Colors.blue.shade900,
        ),
        body: Container(
      child: Column(
        children: [
          Card(
            shadowColor: Colors.deepPurpleAccent[100],
            child: SizedBox(
              width: 400,
              height: 500,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    CircleAvatar(
                        backgroundColor: Colors.blue.shade900,
                        radius: 109,
                        child: const  CircleAvatar(
                          backgroundImage: AssetImage("lib/images/heart.png"),
                          radius: 100,
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    const  Text("First Aid For Heart Attack"),
                    const SizedBox(height: 20),
                    const Text("1.The person sit down, rest, and try to keep calm."),
                    const SizedBox(height: 3),
                    const Text("2.Loosen any tight clothing."),
                    const SizedBox(height: 3),
                    const Text(
                        "3.Ask if the person takes any chest pain medicine, such as nitroglycerin for a known heart condition, and help them take it"),
                    const SizedBox( height: 3,),
                    const Text( "4.If the pain does not go away promptly with rest or within 3 minutes of taking nitroglycerin, call for emergency medical help.")
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ),
    );
    
    
    
  }
}