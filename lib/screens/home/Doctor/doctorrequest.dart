// import 'package:flutter/cupertino.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:medfarm/screens/home/home.dart';
// import 'package:flutter/foundation.dart';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../services/model/doctorinfo.dart';
import '../../../services/profile.dart';
import 'package:flutter/material.dart';
import '../../../services/model/user.dart';

// import 'doctor_registration.dart';
class DoctorRequest extends StatefulWidget {
  DoctorRequest({Key? key}) : super(key: key);

  @override
  State createState() => _DoctorRequest();
}

class _DoctorRequest extends State<DoctorRequest> {
  _DoctorRequest();
  final ProfileService _profile = ProfileService();
  var doctorDocumentList= FirebaseFirestore.instance.collection('pendingdoctors');
  
 
   Stream<List<DoctorInfo>> showDoctorsProfile(){
        return doctorDocumentList.snapshots().map((snapshot) => snapshot.docs.map((doc) => DoctorInfo.fromJson(doc.data())).toList());
    } 
   
  Widget buildDoctor(DoctorInfo doctor)=>  ListTile(
      title: Text(doctor.doctorname!),
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
