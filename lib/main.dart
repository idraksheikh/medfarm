// import 'dart:async';
// import 'dart:convert';
// import 'package:json_annotation/json_annotation.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// part 'main.g.dart';

// Future<Album> fetchAlbum() async {
//   final response = await http.get(Uri.parse(
//       'https://api.openrouteservice.org/v2/directions/driving-car?api_key=5b3ce3597851110001cf6248b042fdf069484904a8d48e459ae7ad7c&start=8.681495,49.41461&end=8.687872,49.420318'));

//   if (response.statusCode == 200) {
//     // If the server did return a 200 OK response,
//     // then parse the JSON.

//     return Album.fromJson(jsonDecode(response.body));
//   } else {
//     // If the server did not return a 200 OK response,
//     // then throw an exception.
//     throw Exception('Failed to load album');
//   }
// }

// // @JsonSerializable()
// // class Location {
// //   @JsonKey(defaultValue: "key")
// //   final List<double> coordinates;
// //   Location(this.coordinates);

// //   factory Location.fromJson(Map<String, dynamic> json) =>
// //       _$LocationFromJson(json);

// //   Map<String, dynamic> toJson() => _$LocationToJson(this);
// // }



// void main() => runApp(const MyApp());

// class MyApp extends StatefulWidget {
//   const MyApp({super.key});

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   late Future<Album> futureAlbum;

//   @override
//   void initState() {
//     super.initState();
//     futureAlbum = fetchAlbum();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Fetch Data Example',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Fetch Data Example'),
//         ),
//         body: Center(
//           child: FutureBuilder<Album>(
//             future: futureAlbum,
//             builder: (context, snapshot) {
//               if (snapshot.hasData) {
//                 return Text(snapshot.data!.type);
//               } else if (snapshot.hasError) {
//                 return Text('${snapshot.error}');
//               }
//               // By default, show a loading spinner.
//               return const CircularProgressIndicator();
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }




import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medfarm/screens/Wrapper.dart';
import 'package:medfarm/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:shared_preferences/shared_preferences.dart';

void main() {
    
  runApp(const Medfarm());
}
class Medfarm extends StatelessWidget {
  const Medfarm({Key? key}) : super(key: key);
  

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      future: Firebase.initializeApp(),
       builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return const Text('Something Went Wrong');
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return StreamProvider<User?>.value(
      value:AuthService().user,
      initialData: null,
      child:  const Wrapper(),
      );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return const CircularProgressIndicator();
       }
    );
    
  }
}
