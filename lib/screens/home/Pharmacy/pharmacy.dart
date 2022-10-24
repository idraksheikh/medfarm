import 'dart:convert';
import './medicine.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class Pharmacy extends StatefulWidget {
  const Pharmacy({Key? key}) : super(key: key);

  @override
  State createState() => _Pharmacy();
}

class _Pharmacy extends State<Pharmacy> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: FutureBuilder<Medicine>(
          future: futureMedicine,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              print(snapshot.data.toString());

              return Column(children: [
                Container(
                  height: 180,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(50),
                    ),
                    color: Colors.indigoAccent,
                  ),
                  child: Stack(children: [
                    Positioned(
                        top: 50,
                        left: 0,
                        child: Container(
                          height: 80,
                          width: 230,
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(50),
                                  bottomRight: Radius.circular(50))),
                        )),
                    const Positioned(
                      top: 80,
                      left: 20,
                      child: Text("Pharmacy Store",
                          style: TextStyle(
                              fontSize: 20, color: Color(0xFF363f93))),
                    ),
                  ]),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
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
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.blue.withOpacity(0.1),
                                      offset: const Offset(-10.0, 10.0),
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
                            shadowColor: Colors.blue.shade100,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Container(
                              height: 150,
                              width: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(
                                      '${snapshot.data!.results![0].image}'),
                                ),
                              ),
                            )),
                      ),
                      Positioned(
                          top: 45,
                          left: 200,
                          child: Container(
                            child: Column(
                              children: const [
                                Text(
                                  "ashwin khale",
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      color: Color(0xFF363f93),
                                      fontWeight: FontWeight.bold),
                                ),
                                Divider(
                                  color: Colors.black,
                                  height: 10,
                                ),
                                Text(
                                  "Price:- 200",
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ))
                    ],
                  ),
                ),
              ]);
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            // By default, show a loading spinner.
            return const CircularProgressIndicator();
          }),
    ));
  }
}