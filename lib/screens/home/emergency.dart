import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Location> fetchLocation() async {
  final response = await http.get(Uri.parse(
      'https://api.openrouteservice.org/v2/directions/driving-car?api_key=5b3ce3597851110001cf6248b042fdf069484904a8d48e459ae7ad7c&start=8.681495,49.41461&end=8.687872,49.420318'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.

    return Location.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load Location');
  }
}

class Location {
	String? type;
	List<Features>? features;
	List<double>? bbox;
	Metadata? metadata;

	Location({this.type, this.features, this.bbox, this.metadata});

	Location.fromJson(Map<String, dynamic> json) {
		type = json['type'];
		if (json['features'] != null) {
			features = <Features>[];
			json['features'].forEach((v) { features!.add(Features.fromJson(v)); });
		}
		bbox = json['bbox'].cast<double>();
		metadata = json['metadata'] != null ? Metadata.fromJson(json['metadata']) : null;
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = Map<String, dynamic>();
		data['type'] = this.type;
		if (this.features != null) {
      data['features'] = this.features!.map((v) => v.toJson()).toList();
    }
		data['bbox'] = this.bbox;
		if (this.metadata != null) {
      data['metadata'] = this.metadata!.toJson();
    }
		return data;
	}
}

class Features {
	List<double>? bbox;
	String? type;
	Properties? properties;
	Geometry? geometry;

	Features({this.bbox, this.type, this.properties, this.geometry});

	Features.fromJson(Map<String, dynamic> json) {
		bbox = json['bbox'].cast<double>();
		type = json['type'];
		properties = json['properties'] != null ? Properties.fromJson(json['properties']) : null;
		geometry = json['geometry'] != null ? Geometry.fromJson(json['geometry']) : null;
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = Map<String, dynamic>();
		data['bbox'] = this.bbox;
		data['type'] = this.type;
		if (this.properties != null) {
      data['properties'] = this.properties!.toJson();
    }
		if (this.geometry != null) {
      data['geometry'] = this.geometry!.toJson();
    }
		return data;
	}
}

class Properties {
	List<Segments>? segments;
	Summary? summary;
	List<int>? wayPoints;

	Properties({this.segments, this.summary, this.wayPoints});

	Properties.fromJson(Map<String, dynamic> json) {
		if (json['segments'] != null) {
			segments = <Segments>[];
			json['segments'].forEach((v) { segments!.add(Segments.fromJson(v)); });
		}
		summary = json['summary'] != null ? Summary.fromJson(json['summary']) : null;
		wayPoints = json['way_points'].cast<int>();
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = Map<String, dynamic>();
		if (this.segments != null) {
      data['segments'] = this.segments!.map((v) => v.toJson()).toList();
    }
		if (this.summary != null) {
      data['summary'] = this.summary!.toJson();
    }
		data['way_points'] = this.wayPoints;
		return data;
	}
}

class Segments {
	double? distance;
	double? duration;
	List<Steps>? steps;

	Segments({this.distance, this.duration, this.steps});

	Segments.fromJson(Map<String, dynamic> json) {
		distance = json['distance'];
		duration = json['duration'];
		if (json['steps'] != null) {
			steps = <Steps>[];
			json['steps'].forEach((v) { steps!.add(Steps.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = Map<String, dynamic>();
		data['distance'] = this.distance;
		data['duration'] = this.duration;
		if (this.steps != null) {
      data['steps'] = this.steps!.map((v) => v.toJson()).toList();
    }
		return data;
	}
}

class Steps {
	double? distance;
	double? duration;
	int? type;
	String? instruction;
	String? name;
	List<int>? wayPoints;

	Steps({this.distance, this.duration, this.type, this.instruction, this.name, this.wayPoints});

	Steps.fromJson(Map<String, dynamic> json) {
		distance = json['distance'];
		duration = json['duration'];
		type = json['type'];
		instruction = json['instruction'];
		name = json['name'];
		wayPoints = json['way_points'].cast<int>();
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = Map<String, dynamic>();
		data['distance'] = this.distance;
		data['duration'] = this.duration;
		data['type'] = this.type;
		data['instruction'] = this.instruction;
		data['name'] = this.name;
		data['way_points'] = this.wayPoints;
		return data;
	}
}

class Summary {
	double? distance;
	int? duration;

	Summary({this.distance, this.duration});

	Summary.fromJson(Map<String, dynamic> json) {
		distance = json['distance'];
		duration = json['duration'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = Map<String, dynamic>();
		data['distance'] = this.distance;
		data['duration'] = this.duration;
		return data;
	}
}

class Geometry {
	List<List>? coordinates;
	String? type;

	Geometry({this.coordinates, this.type});

	Geometry.fromJson(Map<String, dynamic> json) {
		if (json['coordinates'] != null) {
			coordinates = <List>[];
			json['coordinates'].forEach((v) { coordinates!.add(v); });
		}
		type = json['type'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = Map<String, dynamic>();
		if (this.coordinates != null) {
      data['coordinates'] = this.coordinates!.map((v) => v).toList();
    }
		data['type'] = this.type;
		return data;
	}
}

// class Coordinates {


// 	// Coordinates({});

// 	Coordinates.fromJson(Map<String, dynamic> json) {
// 	}

// 	Map<String, dynamic> toJson() {
// 		final Map<String, dynamic> data = Map<String, dynamic>();
// 		return data;
// 	}
// }

class Metadata {
	String? attribution;
	String? service;
	int? timestamp;
	Query? query;
	Engine? engine;

	Metadata({this.attribution, this.service, this.timestamp, this.query, this.engine});

	Metadata.fromJson(Map<String, dynamic> json) {
		attribution = json['attribution'];
		service = json['service'];
		timestamp = json['timestamp'];
		query = json['query'] != null ? Query.fromJson(json['query']) : null;
		engine = json['engine'] != null ? Engine.fromJson(json['engine']) : null;
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = Map<String, dynamic>();
		data['attribution'] = this.attribution;
		data['service'] = this.service;
		data['timestamp'] = this.timestamp;
		if (this.query != null) {
      data['query'] = this.query!.toJson();
    }
		if (this.engine != null) {
      data['engine'] = this.engine!.toJson();
    }
		return data;
	}
}

class Query {
	List<List>? coordinates;
	String? profile;
	String? format;

	Query({this.coordinates, this.profile, this.format});

	Query.fromJson(Map<String, dynamic> json) {
		if (json['coordinates'] != null) {
			coordinates = <List>[];
			json['coordinates'].forEach((v) { coordinates!.add(v); });
		}
		profile = json['profile'];
		format = json['format'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = Map<String, dynamic>();
		if (this.coordinates != null) {
      data['coordinates'] = this.coordinates!.map((v) => v).toList();
    }
		data['profile'] = this.profile;
		data['format'] = this.format;
		return data;
	}
}

class Engine {
	String? version;
	String? buildDate;
	String? graphDate;

	Engine({this.version, this.buildDate, this.graphDate});

	Engine.fromJson(Map<String, dynamic> json) {
		version = json['version'];
		buildDate = json['build_date'];
		graphDate = json['graph_date'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = Map<String, dynamic>();
		data['version'] = this.version;
		data['build_date'] = this.buildDate;
		data['graph_date'] = this.graphDate;
		return data;
	}
}

class EmergencyCase extends StatefulWidget{
  const EmergencyCase({Key? key}) : super(key: key);

  @override 
  State createState()=> _EmergencyCase();
}
class _EmergencyCase extends State<EmergencyCase>{
  late Future<Location> futureLocation;

  @override
  void initState() {
    super.initState();
    futureLocation = fetchLocation();
  }
  @override
  Widget build(BuildContext context){
    return  Scaffold(
      body:Center(
          child: FutureBuilder<Location>(
            future: futureLocation,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data!.features.toString());
              } else if (snapshot.hasError) {
                return Text('${snapshot}');
              }
              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ),

    );
  }
}