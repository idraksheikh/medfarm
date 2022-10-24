import 'dart:async';
import 'dart:convert';
import './medicine.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PharmacyPage extends StatefulWidget {
  const PharmacyPage({super.key});

  @override
  State createState() => _PharmacyPage();
}

class _PharmacyPage extends State<PharmacyPage> {
  late Future<Medicine> futureMedicine;
  bool showMed = false;
  String nameMedicine = "Disprine";
  List<int> card = [0, 1, 2];
  Future<Medicine> fetchMedicine(String medicineName) async {
    final response = await http.get(Uri.parse(
        'http://api.scraperapi.com/?api_key=3b86a5eeca41b365a84436fbb3913acd&autoparse=true&url=https://www.amazon.in/s?k=$medicineName&i=amazon-pharmacy'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.

      var med = response.body;
      Medicine medi = Medicine.fromJson(jsonDecode(med));
      print(' ${medi.results![0].name}  Price ${medi.results![1].price}');
      return medi;
    } else {
      throw Exception('Failed to load Location');
    }
  }

  void searchMedicine(String medicineName) {
    futureMedicine = fetchMedicine(medicineName);
    setState(() {
      showMed = true;
    });
  }

  // late final TabController _tabController;

  // @override
  // void initState() {
  //   super.initState();
  //   _tabController = TabController(length: 2, vsync: this);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pharmacy'),
        backgroundColor: Colors.blue.shade600,
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
          height: double.infinity,
          // width: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  // width: double.infinity,

                  padding: const EdgeInsets.all(20),
                  height: MediaQuery.of(context).size.height * 0.15,
                  decoration: BoxDecoration(
                    color: Colors.blue.shade600,
                    borderRadius: const BorderRadius.vertical(
                        bottom: Radius.circular(20)),
                  ),
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          prefixIcon: const Icon(Icons.medication_rounded),
                          suffixIcon: const Icon(
                            Icons.search,
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          hintText: "Search Medcine Here",
                        ),
                        onChanged: (value) {
                          setState(() {
                            nameMedicine = value;
                          });
                        },
                        onFieldSubmitted: (val) {
                          showMed = false;
                          searchMedicine(nameMedicine);
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 10),
                  child: Column(
                    children: [
                      showMed
                          ? FutureBuilder<Medicine>(
                              future: futureMedicine,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  // debugPrint(snapshot.data.toString());
                                  return Column(
                                    children: card
                                        .map((e) => Card(
                                              shadowColor: Colors.blue.shade600,
                                              elevation: 5,
                                              margin: const EdgeInsets.only(
                                                  top: 10, bottom: 10),
                                              shape: RoundedRectangleBorder(
                                                side:  BorderSide(
                                                  color: Colors.blue.shade500,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),

                                              
                                              child: Container(
                                                width: 300,
                                                height: 180,
                                                decoration:  BoxDecoration(
                                                  // borderRadius:
                                                  //     BorderRadius.circular(30),
                                                   color: Colors.blue.shade50,
                                                ),
                                                child: Column(children: [
                                                  Row(children: [
                                                    Container(
                                                      height: 90,
                                                      width: 100,
                                                      margin:
                                                          const EdgeInsets.only(
                                                              top: 10,
                                                              left: 10),
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(5),
                                                        image: DecorationImage(
                                                          alignment:
                                                              Alignment.topLeft,
                                                          fit: BoxFit.fill,
                                                          image: NetworkImage(
                                                            '${snapshot.data!.results![e].image}',
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              left: 30),
                                                      width: 150,
                                                      child: Text(
                                                        '${snapshot.data!.results![e].name}',
                                                        maxLines: 2,
                                                        style: TextStyle(
                                                          color: Colors
                                                              .blue.shade600,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ),
                                                  ]),
                                                  Row(
                                                    children: [
                                                      InkWell(
                                                        onTap: () {},
                                                        child: Container(
                                                            margin:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 30,
                                                                    top: 10),
                                                            width: 70,
                                                            height: 40,
                                                            decoration:
                                                                BoxDecoration(
                                                                  borderRadius: BorderRadius.circular(5),
                                                              color: Colors.blue
                                                                  .shade700,
                                                            ),
                                                            child: const Center(
                                                              child: Text(
                                                                'BUY',
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              ),
                                                            )),
                                                      ),
                                                      Container(
                                                        margin: const EdgeInsets
                                                            .only(left: 50),
                                                        width: 100,
                                                        child: Text(
                                                          'Price : ₹ ${snapshot.data!.results![e].price}',
                                                          maxLines: 1,
                                                          style: TextStyle(
                                                            color: Colors
                                                                .blue.shade600,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ]),
                                              ),
                                            ))
                                        .toList(),
                                  );
                                } else if (snapshot.hasError) {
                                  return Text('${snapshot.error}');
                                }

                                return Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical:
                                          (MediaQuery.of(context).size.height *
                                              0.06)),
                                  child: const CircularProgressIndicator(),
                                );
                              })
                          : const Text(''),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
