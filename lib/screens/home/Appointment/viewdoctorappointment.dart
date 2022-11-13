import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medfarm/services/model/appointment.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../services/model/user.dart';

class ViewDoctorAppointment extends StatefulWidget{

  @override
  State createState()=> _ViewDoctorAppointment();
}
class _ViewDoctorAppointment extends State<ViewDoctorAppointment> {
  
  Future<List<Appointment>> showDoctorAppointment()async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    var userDocumentList= FirebaseFirestore.instance.collection('users');
    var appointmentDocumentList= FirebaseFirestore.instance.collection('appointments');

    String? email=preferences.getString('email');
    UserData userData=await userDocumentList.where('email',isEqualTo: email).get().then((value) {
     return UserData.fromJson(value.docs[0].data());
    });
    List<Appointment> appointment=await appointmentDocumentList.where('doctorname',isEqualTo: userData.username).get().then(((value) => value.docs.map((val) => Appointment.fromJson(val.data())).toList()));
    return appointment;
  }
  late List<Appointment> doctorAppointment;
  @override
  void initState() {
    super.initState();
    

  }

  Widget buildDoctor(Appointment appointment)=> GestureDetector(
        child: Container(
          height: 100,
          margin: const EdgeInsets.only(top: 10,bottom: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.lightBlue.shade100,
          ),
          child: Row(
            children: [
              Container(
                height: 65,
                width: 65,
                margin: const EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    image: const DecorationImage(
                      image: AssetImage("lib/images/appointment.gif"),
                      fit: BoxFit.cover,
                    )),
              ),
              Container(
                width: 130,

                margin: const EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      
                      "Patient Name : ",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                      
                    ),
                    Text(
                      "${appointment.patientname}",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.blue.shade900,
                      ),
                      maxLines: 2,
                    ),
                  ],
                ),
              ),
              Container(
                height: 70,
                width: 100,
                margin: const EdgeInsets.only(left:10),
                decoration: BoxDecoration(
                  color: Colors.blue.shade300,
                  borderRadius: BorderRadius.circular(10),
                  // borderRadius:const BorderRadius.only(topRight: Radius.circular(40),bottomRight: Radius.circular(40),)
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      
                      child: Text(
                        "${appointment.time}",
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                      child: Text(
                        "${appointment.date}",
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                        ),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage("lib/images/appointment.gif"),
                  fit: BoxFit.cover,
                )),
              ),
            ],
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Paitents Appointment"),
        centerTitle: true,
      ),
      body: Container(
         padding: const EdgeInsets.only(left: 10, right: 10),
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
