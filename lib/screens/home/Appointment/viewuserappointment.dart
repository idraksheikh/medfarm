import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../services/model/appointment.dart';
import '../../../services/model/user.dart';

class ViewUserAppointment extends StatefulWidget{

  @override
  State createState()=> _ViewUserAppointment();
}
class _ViewUserAppointment extends State<ViewUserAppointment> {
  

  
  Future<List<Appointment>> showDoctorAppointment()async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    var userDocumentList= FirebaseFirestore.instance.collection('users');
    var appointmentDocumentList= FirebaseFirestore.instance.collection('appointments');

    String? email=preferences.getString('email');
    UserData userData=await userDocumentList.where('email',isEqualTo: email).get().then((value) {
     return UserData.fromJson(value.docs[0].data());
    });
    List<Appointment> appointment=await appointmentDocumentList.where('patientname',isEqualTo: userData.username).get().then(((value) => value.docs.map((val) => Appointment.fromJson(val.data())).toList()));
    return appointment;
  }
  late List<Appointment> doctorAppointment;
  @override
  void initState() {
    super.initState();
    

  }

  Widget buildDoctor(Appointment appointment)=> GestureDetector(
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
                    Text('Patient Name : ${appointment.patientname}'),
                  ],
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Doctor Name : ${appointment.doctorname}'),
                  ],
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Date Of Appointment : ${appointment.date}'),
                  ],
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Time Of Appointment : ${appointment.time}'),
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
        title: const Text("Your Appointment"),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            
        ),
        child:FutureBuilder<List<Appointment>>(
              future: showDoctorAppointment(),
              builder: ((context, snapshot) {
                if(snapshot.hasData){
                  if(snapshot.data!.isEmpty){
                      return Container(
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("lib/images/noData.gif"),
                          )
                        ),
                      );
                  }
                  else{ final appointment=snapshot.data!;
          return ListView(
            children: appointment.map(buildDoctor).toList(),
          );

                  }
                }else if(snapshot.hasError){
                  return const  Center(
                                    child:Text('Some Error Occured'),
                                  ); 
                }
                else{
                  return const Center(
                                    child:  CircularProgressIndicator(
                                    color: Colors.blue,
                                  ),
                                  );
                }
              }
              )
      ),
    ));
      
  }
  
}
