import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:flutter_map_line_editor/polyeditor.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:medfarm/screens/home/Emergency/hosplocation.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import './location.dart';
import 'package:geolocator/geolocator.dart';

/// Determine the current position of the device.
///
/// When the location services are not enabled or permissions
/// are denied the `Future` will return an error.

class PolylinePage extends StatefulWidget {
  const PolylinePage({Key? key}) : super(key: key);

  @override
  State<PolylinePage> createState() => _PolylinePageState();
}

class _PolylinePageState extends State<PolylinePage> {
  late PolyEditor polyEditor;
  late Future<GetLocation> futureLocation;
  late Future<HospLocation> futureHospitalLocation;
  late List<LatLng> polylineCoordinates = [];
  late List<Features> locate;
  late bool navigationMode;
  late int pointerCount;
  late CenterOnLocationUpdate _centerOnLocationUpdate;
  late TurnOnHeadingUpdate _turnOnHeadingUpdate;
  late StreamController<double?> _centerCurrentLocationStreamController;
  late StreamController<void> _turnHeadingUpStreamController;
  String metaData = 'Fetching your Location';
  bool getlatlng = false;
  Position? pos;

  Future<Position> _determinePosition() async {
    LocationPermission permission;

    setState(() {
      metaData = metaData;
    });
    // if (!serviceEnabled) {
    //   return Future.error('Location services are disabled.');
    // }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    pos = await Geolocator.getCurrentPosition();
    futureHospitalLocation = _hospitalNear(pos!);
    futureLocation = fetchLocation(pos!, await _hospitalNear(pos!));

    setState(() {
      {
        getlatlng = true;
      }
    });

    return await Geolocator.getCurrentPosition();
  }

  Future<HospLocation> _hospitalNear(Position pos) async {
    setState(() {
      metaData = "Searching Neaby Hospital";
    });
    final response = await http.get(Uri.parse(
        'https://api.geoapify.com/v2/places?categories=healthcare.hospital&bias=proximity:${pos.longitude},${pos.latitude}&limit=1&apiKey=bcd7fb5652cd4bc9ad3f84db8378fe5a'));

    if (response.statusCode == 200) {
      setState(() {
        metaData = "Hospital Location Recived";
      });
      return HospLocation.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load Location');
    }
  }

  Future<GetLocation> fetchLocation(Position pos, HospLocation hospos) async {
    double lat = pos.latitude;
    double long = pos.longitude;
    // print(pos.latitude);
    setState(() {
      metaData = "Fetching map";
    });
    final response = await http.get(Uri.parse(
        'https://api.openrouteservice.org/v2/directions/driving-car?api_key=5b3ce3597851110001cf6248b042fdf069484904a8d48e459ae7ad7c&start=$long,$lat&end=${hospos.features![0].geometry!.coordinates![0]},${hospos.features![0].geometry!.coordinates![1]}'));

    if (response.statusCode == 200) {
      setState(() {
        locate = GetLocation.fromJson(jsonDecode(response.body)).features!;
        // print(locate);
      });
      drawStrava();
      return GetLocation.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load Location');
    }
  }

  List<Polyline> polyLines = [];
  var testPolyline = Polyline(
      color: Colors.blue.shade700,
      borderColor: Colors.blue.shade900,
      strokeWidth: 15,
      borderStrokeWidth: 5,
      points: []);

// List<Polyline> dottedPolyLines = [];
//   var dotted = Polyline(
//       color: Colors.blue.shade700,
//       borderColor: Colors.blue.shade900,
//       strokeWidth: 15,
//       borderStrokeWidth: 5,
//       points: []);

  Future drawStrava() async {
    if (locate.isNotEmpty) {
      for (var point in locate[0].geometry!.coordinates!) {
        setState(() {
          polylineCoordinates.add(LatLng(point[1], point[0]));
        });
      }

      setState(() {
        // print(polylineCoordinates);
        testPolyline = Polyline(
            color: Colors.blue.shade700,
            borderColor: Colors.blue.shade900,
            strokeWidth: 10,
            borderStrokeWidth: 5,
            points: polylineCoordinates);
        polyLines.add(testPolyline);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    navigationMode = true;
    pointerCount = 0;
    _centerOnLocationUpdate = CenterOnLocationUpdate.never;
    _turnOnHeadingUpdate = TurnOnHeadingUpdate.never;
    _centerCurrentLocationStreamController = StreamController<double?>();
    _turnHeadingUpStreamController = StreamController<void>();
    _determinePosition();
  }

  void callfunc() async {
    // await _listenLocationStream();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Emergency')),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => {callfunc()},
      //   child: const Icon(Icons.add),
      // ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
        ),
        child: getlatlng
            ? FutureBuilder<GetLocation>(
                future: futureLocation,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return FlutterMap(
                      options: MapOptions(
                        absorbPanEventsOnScrollables: false,
                        onTap: (_, ll) {
                          polyEditor.add(testPolyline.points, ll);
                        },
                        center: LatLng(pos!.latitude, pos!.longitude),
                        zoom: 16,
                        maxZoom: 18.3,
                        onPointerDown: _onPointerDown,
                        onPointerUp: _onPointerUp,
                        onPointerCancel: _onPointerUp,
                      ),
                      // ignore: sort_child_properties_last
                      children: [
                        TileLayer(
                            urlTemplate:
                                'https://api.mapbox.com/styles/v1/gurpreetachint/cl5rvxqts00i214rznevk6ick/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiZ3VycHJlZXRhY2hpbnQiLCJhIjoiY2wwMTl0ZjhzMDI2YzNscGEybXQ2MnNvbiJ9.aNZsNi-jXP_wVCH47oNXzQ',
                            subdomains: const ['a', 'b', 'c']),
                        FutureBuilder<HospLocation>(
                          future: futureHospitalLocation,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return PopupMarkerLayerWidget(
                                options: PopupMarkerLayerOptions(
                                  markers: <Marker>[
                                    Marker(
                                      point: LatLng(
                                          snapshot.data!.features![0].geometry!
                                              .coordinates![1],
                                          snapshot.data!.features![0].geometry!
                                              .coordinates![0]),
                                      builder: (BuildContext ctx) => Icon(
                                        Icons.local_hospital,
                                        color: Colors.blue.shade400,
                                        size: 30,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                        ),

                        PolylineLayer(polylines: polyLines),
                        // DragMarkers(markers: polyEditor.edit()),
                        CurrentLocationLayer(
                          centerCurrentLocationStream:
                              _centerCurrentLocationStreamController.stream,
                          turnHeadingUpLocationStream:
                              _turnHeadingUpStreamController.stream,
                          centerOnLocationUpdate: _centerOnLocationUpdate,
                          turnOnHeadingUpdate: _turnOnHeadingUpdate,
                          style: const LocationMarkerStyle(
                            marker: DefaultLocationMarker(
                              child: Icon(
                                Icons.navigation,
                                color: Colors.white,
                              ),
                            ),
                            markerSize: Size(40, 40),
                            markerDirection: MarkerDirection.heading,
                          ),
                        ),
                      ],
                      nonRotatedChildren: [
                        Positioned(
                          right: 20,
                          bottom: 20,
                          child: FloatingActionButton(
                            backgroundColor:
                                navigationMode ? Colors.blue : Colors.grey,
                            foregroundColor: Colors.white,
                            onPressed: () {
                              setState(
                                () {
                                  navigationMode = !navigationMode;
                                  _centerOnLocationUpdate = navigationMode
                                      ? CenterOnLocationUpdate.always
                                      : CenterOnLocationUpdate.never;
                                  _turnOnHeadingUpdate = navigationMode
                                      ? TurnOnHeadingUpdate.always
                                      : TurnOnHeadingUpdate.never;
                                },
                              );
                              if (navigationMode) {
                                _centerCurrentLocationStreamController.add(18);
                                _turnHeadingUpStreamController.add(null);
                              }
                            },
                            child: const Icon(
                              Icons.navigation_outlined,
                            ),
                          ),
                        )
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }

                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                })
            : Center(
                child: Container(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.3),
                  child: Column(
                    children: [
                      Text(metaData),
                      const CircularProgressIndicator(),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  // Disable center and turn temporarily when user is manipulating the map.
  void _onPointerDown(e, l) {
    pointerCount++;
    setState(() {
      _centerOnLocationUpdate = CenterOnLocationUpdate.never;
      _turnOnHeadingUpdate = TurnOnHeadingUpdate.never;
    });
  }

  // Enable center and turn again when user end manipulation.
  void _onPointerUp(e, l) {
    if (--pointerCount == 0 && navigationMode) {
      setState(() {
        _centerOnLocationUpdate = CenterOnLocationUpdate.always;
        _turnOnHeadingUpdate = TurnOnHeadingUpdate.always;
      });
      _centerCurrentLocationStreamController.add(18);
      _turnHeadingUpStreamController.add(null);
    }
  }
}
