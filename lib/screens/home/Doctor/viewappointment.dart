// import 'package:flutter/cupertino.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:medfarm/screens/home/home.dart';
// import 'package:flutter/foundation.dart';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import '../../../services/model/doctorinfo.dart';
import '../../../services/profile.dart';
import 'package:flutter/material.dart';
// import '../../../services/model/user.dart';

// import 'doctor_registration.dart';
class ViewAppointment extends StatefulWidget {
  ViewAppointment({Key? key}) : super(key: key);

  @override
  State createState() => _ViewAppointment();
}

class _ViewAppointment extends State<ViewAppointment> {
  _ViewAppointment();
  final ProfileService _profile = ProfileService();
  var appointmentDocumentList= FirebaseFirestore.instance.collection('appointments');
  
 
   Stream<List<DoctorInfo>> showDoctorsProfile(){
    final FirebaseAuth _auth= FirebaseAuth.instance;
    User? user= _auth.currentUser;
    String? email=user!.email;
        return appointmentDocumentList.snapshots().map((snapshot) => snapshot.docs.map((doc) => DoctorInfo.fromJson(doc.data())).toList());
        // return appointmentDocumentList.where('doctorname',isEqualTo:name).get().then((value) => value.docs.map((doc) => DoctorInfo.fromJson(doc.data())).toList());
    } 
   
  Widget buildDoctor(DoctorInfo doctor)=> GestureDetector(
    child: Container(
      
      height: 90,
        margin: const EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(5)),
            child: Column(
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${doctor.doctorname}'),
                  ],
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${doctor.degree}'),
                  ],
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${doctor.specialisation}'),
                  ],
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${doctor.address}'),
                  ],
                ),
              ],
            ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Doctor Request"),
        centerTitle: true,

      ),
      body: StreamBuilder<List<DoctorInfo>>(
        stream: showDoctorsProfile(),
        builder: (context, snapshot) {
          final doctors=snapshot.data!;
          return ListView(
            children: doctors.map(buildDoctor).toList(),
          );

        },
      ),
      
    );
    
  }

 
}
