// import 'package:flutter/cupertino.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:medfarm/screens/home/home.dart';

import '../../services/profile.dart';
import 'package:flutter/material.dart';
import '../../services/model/user.dart';
// import 'doctor_registration.dart';
class ProfilePage extends StatefulWidget{
  String? email;
   ProfilePage({Key? key,this.email}) : super(key: key);

  @override
  State createState()=> _ProfilePage(email:this.email);
}
class _ProfilePage extends State<ProfilePage>{
  String? email;
   _ProfilePage({this.email});
   final ProfileService _profile=ProfileService();
    Future<UserData?> takeValue()async{
    
    try {
      
      var res=await _profile.showProfile(email!);
      print(res.toString());
      return  res;
    } catch (e) {
      print("error occured");
      return null;
    }
      
      
   }
    late Future<UserData?> userData;

    @override
  void initState()  {
    super.initState();
    setState(() {
    userData=takeValue();  
    });
    
    
  }

   
  @override
  Widget build(BuildContext context){
    
    return  Scaffold(
      appBar: AppBar(
        title:const Text("Profile"),
        centerTitle: true,
        
      ),
      
      body:Container(
        decoration: BoxDecoration(

        ),
        child: FutureBuilder<UserData?>(
          future: userData,
          builder: (context,snapshot){
            if(snapshot.hasData){
              return Text('${snapshot.data!.username}');
            }else if(snapshot.hasError){
              return const Text('Some error occure');
            }
            return const Text("Loading data please wait");
          },
        ),
      ),
    
    );
  }
}