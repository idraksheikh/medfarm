import 'package:flutter/material.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';

class GuidePage extends StatefulWidget {
  const GuidePage({Key? key}) : super(key: key);

  @override
  State createState() => _GuidePage();
}

class _GuidePage extends State<GuidePage> {
  final GlobalKey<ExpansionTileCardState> cardA = GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardB = GlobalKey();
  int currentHeartStep=0;
  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        title: const Text('Guide'),
      ),
      body: ListView(children: <Widget>[
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: ExpansionTileCard(
            baseColor: Colors.cyan[50],
            expandedColor: Colors.blue[50],
            key: cardA,
            leading: const CircleAvatar(
              backgroundImage: AssetImage("lib/images/heart.jpeg"),
            ),
            title: const Text("Heart Attack"),
            subtitle: const Text("FIRST AID FOR HEART ATTACK"),
            children: <Widget>[
              const Divider(
                thickness: 1.0,
                height: 1.0,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: Stepper(
                    
                    steps: const [
                          Step(
                              title: Text("Step 1"),
                              content: Text("Have the person sit down, rest, and try to keep calm")),
                              
                          Step(
                              title: Text("Step 2"),
                              content: Text("Loosen any tight clothing.")
                              
                              ),
                              
                          Step(
                              title: Text("Step 3"),
                              content: Text("Ask if the person takes any chest pain medicine, such as nitroglycerin for a known heart condition, and help them take it.")),
                          Step(
                              title: Text("Step 4"),
                              content: Text("If the pain does not go away promptly with rest or within 3 minutes of taking nitroglycerin, call for emergency medical help.")),                        
                        ],
                        currentStep: currentHeartStep,
                        onStepTapped: (int index){
                          setState(() {
                            currentHeartStep=index;
                          });
                        },
                        elevation: 10,
                        
                        ),
                ),
              ),
             
            ],
          ),
        ),
      ]),
    );
  }
}
