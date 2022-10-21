import 'dart:convert';

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

class Location {
  List<Features>? features;

  Location({this.features});

  Location.fromJson(Map<String, dynamic> json) {
    if (json['features'] != null) {
      features = <Features>[];
      json['features'].forEach((v) {
        features!.add(Features.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    if (features != null) {
      data['features'] = features!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class Features {
  Geometry? geometry;

  Features({this.geometry});

  Features.fromJson(Map<String, dynamic> json) {
    geometry =
        json['geometry'] != null ? Geometry.fromJson(json['geometry']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    if (geometry != null) {
      data['geometry'] = geometry!.toJson();
    }
    return data;
  }
}

class Geometry {
  List<List>? coordinates;

  Geometry({this.coordinates});

  Geometry.fromJson(Map<String, dynamic> json) {
    if (json['coordinates'] != null) {
      coordinates = <List>[];
      json['coordinates'].forEach((v) {
        coordinates!.add(v);
      });
    }
   
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (coordinates != null) {
      data['coordinates'] = coordinates!.map((v) => v).toList();
    }
    
    return data;
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
