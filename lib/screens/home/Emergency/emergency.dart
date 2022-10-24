import 'dart:convert';
import 'location.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Location> fetchLocation() async {
  final response = await http.get(Uri.parse(
      'https://api.openrouteservice.org/v2/directions/driving-car?api_key=5b3ce3597851110001cf6248b042fdf069484904a8d48e459ae7ad7c&start=8.681495,49.41461&end=8.687872,49.420318'));

  if (response.statusCode == 200) {
    return Location.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load Location');
  }
}

class EmergencyCase extends StatefulWidget {
  const EmergencyCase({Key? key}) : super(key: key);

  @override
  State createState() => _EmergencyCase();
}

class _EmergencyCase extends State<EmergencyCase> {
  late Future<Location> futureLocation;

  @override
  void initState() {
    super.initState();
    futureLocation = fetchLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<Location>(
          future: futureLocation,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              
              return Text('Latitude ${snapshot.data!.features![0].geometry!.coordinates![0][0]} , Longitude ${snapshot.data!.features![0].geometry!.coordinates![0][1]}'); 
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            // By default, show a loading spinner.
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
