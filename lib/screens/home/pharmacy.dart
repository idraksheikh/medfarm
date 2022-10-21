
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Medicine {
  List<Results>? results;
  Medicine({required this.results});

  Medicine.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(Results.fromJson(v));
      });
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class Results {
  String? type;
  int? position;
  String? name;
  String? image;
  bool? hasPrime;
  bool? isBestSeller;
  bool? isAmazonChoice;
  bool? isLimitedDeal;
  double? stars;
  int? totalReviews;
  String? url;
  int? availabilityQuantity;

  String? priceString;
  String? priceSymbol;
  double? price;

  Results(
      {this.type,
      this.position,
      this.name,
      this.image,
      this.hasPrime,
      this.isBestSeller,
      this.isAmazonChoice,
      this.isLimitedDeal,
      this.stars,
      this.totalReviews,
      this.url,
      this.availabilityQuantity,
      this.priceString,
      this.priceSymbol,
      this.price});

  Results.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    position = json['position'];
    name = json['name'];
    image = json['image'];
    hasPrime = json['has_prime'];
    isBestSeller = json['is_best_seller'];
    isAmazonChoice = json['is_amazon_choice'];
    isLimitedDeal = json['is_limited_deal'];
    stars = json['stars'] == null ? 0.0 : json['stars'].toDouble();
    totalReviews = json['total_reviews'];
    url = json['url'];
    availabilityQuantity = json['availability_quantity'];

    priceString = json['price_string'];
    priceSymbol = json['price_symbol'];
    price = json['price'] == null ? 0.0 : json['price'].toDouble();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['position'] = position;
    data['name'] = name;
    data['image'] = image;
    data['has_prime'] = hasPrime;
    data['is_best_seller'] = isBestSeller;
    data['is_amazon_choice'] = isAmazonChoice;
    data['is_limited_deal'] = isLimitedDeal;
    data['stars'] = stars;
    data['total_reviews'] = totalReviews;
    data['url'] = url;
    data['availability_quantity'] = availabilityQuantity;
    data['price_string'] = priceString;
    data['price_symbol'] = priceSymbol;
    data['price'] = price;

    return data;
  }
}

Future<Medicine> fetchMedicine() async {
  final response = await http.get(Uri.parse(
      'http://api.scraperapi.com/?api_key=c76f87342697c41cc2901443f600d850&autoparse=true&url=https://www.amazon.in/s?k=electral'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.

    var med = response.body;
    Medicine medi = Medicine.fromJson(jsonDecode(med));
    print(' ${medi.results![2].name}  Price ${medi.results![1].price}');
    return medi;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load Location');
  }
}

class Pharmacy extends StatefulWidget {
  const Pharmacy({Key? key}) : super(key: key);

  @override
  State createState() => _Pharmacy();
}

class _Pharmacy extends State<Pharmacy> {
  late Future<Medicine> futureMedicine;

  @override
  void initState() {
    super.initState();
    futureMedicine = fetchMedicine();
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
        height: 230,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(50),
          ),
          color: Color(0x0ff363f3),
        ),
        child: Stack(children: [
          Positioned(
              top: 80,
              left: 0,
              child: Container(
                height: 100,
                width: 300,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(50),
                        bottomRight: Radius.circular(50))),
              )),
          const Positioned(
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
              child:Card(
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
                    image:  DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage('${snapshot.data!.results![0].image}'),
                    ),
                  ),
                  child: Positioned(
                      top: 45,
                      left: 160,
                      child: Container(
                        child: Column(
                          children: const  [

                            Text(
                              /*${snapshot.data!.results![0].name}*/'',
                              style:    TextStyle(
                                  fontSize: 20.0,
                                  color: Color(0xFF363f93),
                                  fontWeight: FontWeight.bold),
                            )

                          ],
                        ),
                      )))

              ),

            ),
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
