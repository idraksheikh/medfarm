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
  final GlobalKey<ExpansionTileCardState> cardC = GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardD = GlobalKey();

  int currentStep = 0;
  int heartSteps = 0;
  int heatSteps = 0;
  int dropSteps = 0;
  int bloodSteps = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        title: const Text('Guide'),
      ),
      body: ListView(children: <Widget>[
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.blue.shade50)),
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                ExpansionTileCard(
                  baseColor: Colors.blue[50],
                  expandedColor: Colors.blue[50],
                  key: cardA,
                  onExpansionChanged: (bool f) {
                    setState(() {
                      heartSteps = 0;
                    });
                    cardB.currentState?.collapse();
                    cardC.currentState?.collapse();
                    cardD.currentState?.collapse();
                  },
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
                                content: Text(
                                    "Have the person sit down, rest, and try to keep calm")),
                            Step(
                                title: Text("Step 2"),
                                content: Text("Loosen any tight clothing.")),
                            Step(
                                title: Text("Step 3"),
                                content: Text(
                                    "Ask if the person takes any chest pain medicine, such as nitroglycerin for a known heart condition, and help them take it.")),
                            Step(
                                title: Text("Step 4"),
                                content: Text(
                                    "If the pain does not go away promptly with rest or within 3 minutes of taking nitroglycerin, call for emergency medical help.")),
                          ],
                          currentStep: heartSteps,
                          onStepTapped: (int index) {
                            setState(() {
                              heartSteps = index;
                            });
                          },
                          elevation: 10,
                          onStepContinue: () {
                            if (heartSteps != 3) {
                              setState(() => heartSteps++);
                            }
                          },
                          onStepCancel: () {
                            if (heartSteps != 0) {
                              setState((() => heartSteps--));
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.blue.shade50)),
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                ExpansionTileCard(
                  baseColor: Colors.blue[50],
                  expandedColor: Colors.blue[50],
                  key: cardB,
                  onExpansionChanged: (bool f) {
                    setState(() {
                      heatSteps = 0;
                    });

                    cardA.currentState?.collapse();
                    cardC.currentState?.collapse();
                    cardD.currentState?.collapse();
                  },
                  leading: const CircleAvatar(
                    backgroundImage: AssetImage("lib/images/heat.jpeg"),
                  ),
                  title: const Text("Heat Stroke"),
                  subtitle: const Text("FIRST AID FOR HEAT STROKE"),
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
                                content: Text(" Go to a cooler location ")),
                            Step(
                                title: Text("Step 2"),
                                content: Text(
                                    "Cool down by removing excess clothing and taking sips of sports drinks or water")),
                            Step(
                                title: Text("Step 3"),
                                content: Text(
                                    "Call your healthcare provider if symptoms get worse or last more than an hour")),
                          ],
                          currentStep: heatSteps,
                          onStepTapped: (int index) {
                            setState(() {
                              heatSteps = index;
                            });
                          },
                          elevation: 10,
                          onStepContinue: () {
                            if (heatSteps != 2) {
                              setState(() => heatSteps++);
                            }
                          },
                          onStepCancel: () {
                            if (heatSteps != 0) {
                              setState((() => heatSteps--));
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.blue.shade50)),
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                ExpansionTileCard(
                  baseColor: Colors.blue[50],
                  expandedColor: Colors.blue[50],
                  key: cardC,
                  onExpansionChanged: (bool f) {
                    setState(() {
                      dropSteps = 0;
                    });
                    cardB.currentState?.collapse();
                    cardA.currentState?.collapse();
                    cardD.currentState?.collapse();
                  },
                  leading: const CircleAvatar(
                    backgroundImage: AssetImage("lib/images/drop.jpeg"),
                  ),
                  title: const Text("Deep Cut"),
                  subtitle: const Text("FIRST AID FOR DEEP CUT"),
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
                                content: Text(
                                    "Apply direct pressure on the cut or wound with a clean cloth, tissue, or piece of gauze until bleeding stops.")),
                            Step(
                                title: Text("Step 2"),
                                content: Text(
                                    "If blood soaks through the material, don’t remove it. Put more cloth or gauze on top of it and continue to apply pressure.")),
                            Step(
                                title: Text("Step 3"),
                                content: Text(
                                    "If the wound is on the arm or leg, raise limb above the heart, if possible, to help slow bleeding.")),
                            Step(
                                title: Text("Step 4"),
                                content: Text(
                                    "Do not apply a tourniquet unless the bleeding is severe and not stopped with direct pressure.")),
                          ],
                          currentStep: dropSteps,
                          onStepTapped: (int index) {
                            setState(() {
                              dropSteps = index;
                            });
                          },
                          elevation: 10,
                          onStepContinue: () {
                            if (dropSteps != 3) {
                              setState(() => dropSteps++);
                            }
                          },
                          onStepCancel: () {
                            if (dropSteps != 0) {
                              setState((() => dropSteps--));
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.blue.shade50)),
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                ExpansionTileCard(
                  baseColor: Colors.blue[50],
                  expandedColor: Colors.blue[50],
                  key: cardD,
                  onExpansionChanged: (bool f) {
                    setState(() {
                      bloodSteps = 0;
                    });
                    cardB.currentState?.collapse();
                    cardC.currentState?.collapse();
                    cardA.currentState?.collapse();
                  },
                  leading: const CircleAvatar(
                    backgroundImage: AssetImage("lib/images/bloodpres.jpeg"),
                  ),
                  title: const Text("High Blood Pressure"),
                  subtitle: const Text("FIRST AID IGH BLOOD PRESSURE"),
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
                                content: Text(
                                    "Eating a healthy diet. To help manage your blood pressure, you should limit the amount of sodium (salt) that you eat and increase the amount of potassium in your diet")),
                            Step(
                                title: Text("Step 2"),
                                content: Text(
                                    "Getting regular exercise. Exercise can help you maintain a healthy weight and lower your blood pressure. You should try to get moderate-intensity aerobic exercise at least 2 and a half hours per week")),
                            Step(
                                title: Text("Step 3"),
                                content: Text(
                                    "Being at a healthy weight. Being overweight or having obesity increases your risk for high blood pressure. Maintaining a healthy weight can help you control high blood pressure and reduce your risk for other health problems.")),
                            Step(
                                title: Text("Step 4"),
                                content: Text(
                                    "Limiting alcohol. Drinking too much alcohol can raise your blood pressure. It also adds extra calories, which may cause weight gain")),
                          ],
                          currentStep: bloodSteps,
                          onStepTapped: (int index) {
                            bloodSteps = index;
                          },
                          elevation: 10,
                          onStepContinue: () {
                            if (bloodSteps < 2) {
                              setState(() => bloodSteps++);
                            }
                          },
                          onStepCancel: () {
                            if (bloodSteps != 0) {
                              setState((() => bloodSteps--));
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
