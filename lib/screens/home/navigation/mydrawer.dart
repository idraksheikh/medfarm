// import 'dart:convert';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medfarm/screens/home/Doctor/doctorrequest.dart';
import 'package:medfarm/screens/home/home.dart';
import 'package:medfarm/screens/home/Profile/profile.dart';
import 'package:medfarm/services/auth.dart';
import 'package:medfarm/services/model/user.dart';
import 'package:medfarm/services/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyDrawer extends StatefulWidget {
 
  
  
   MyDrawer({Key? key}) : super(key: key);

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  final AuthService _auth=AuthService();
  final ProfileService _profile=ProfileService();
  late Future<UserData?> userData;
   bool admin=false;
 _MyDrawerState();
    // Future<void> isAdmin()async{
    //   SharedPreferences preferences = await SharedPreferences.getInstance();
    //   if(preferences.getString('access')=="Admin"){
    //     setState(() {
    //       admin=true;
    //     });
    //   }
    //   else{
    //     setState(() {
    //       admin=false;
    //     });
    //   }
      
    // }
    
    Future<UserData?> takeValue()async{
    
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      var res=await _profile.showProfile(preferences.getString('email'));
      print(res.toString());
      // isAdmin();
      return  res;
    } catch (e) {
      print("error occured");
      return null;
    }
      
      
   }
    

    @override
  void initState()  {
    super.initState();
    setState(() {
      userData=takeValue();
      
    });
    
    
  }
  @override
  Widget build(BuildContext context) {
    

    return Drawer(
      child: Container(
        color: Colors.blue.shade900,
        child:  ListView(
            children:  [
                DrawerHeader(
                  padding: EdgeInsets.zero,
                  child: FutureBuilder<UserData?>(
                    future: userData,
                    builder: (context, snapshot) {
                      if(snapshot.hasData){
                        return UserAccountsDrawerHeader(
                      margin: EdgeInsets.zero,
                      accountName: Text('${snapshot.data!.username}'),
                      accountEmail: Text('${snapshot.data!.email}'),
                      currentAccountPicture: const CircleAvatar(
                        backgroundImage: AssetImage('lib/images/dummy-user.jpg'),
                      ),
                    );
                      }
                      else if(snapshot.hasError){
                        return const UserAccountsDrawerHeader(
                      margin: EdgeInsets.zero,
                      accountName: Text('Giving error'),
                      accountEmail: Text('dummyemail@gmail.com'),
                      currentAccountPicture:  CircleAvatar(
                        backgroundImage: AssetImage('lib/images/dummy-user.jpg'),
                      ),
                    );
                      }
                      else{
                         return const UserAccountsDrawerHeader(
                      margin: EdgeInsets.zero,
                      accountName: Text(''),
                      accountEmail: Text(''),
                      currentAccountPicture:  CircleAvatar(
                        backgroundImage: AssetImage('lib/images/dummy-user.jpg'),
                      ),
                    );
                      }
                      
                    },
                    
                  )),
              
              ListTile(
                onTap: ((){
                  Navigator.push(context, MaterialPageRoute(builder: ((context) =>  ProfilePage())));
                }),
                leading: const Icon(
                  CupertinoIcons.profile_circled,
                  color: Colors.white,
                ),
                title: const 
                Text(
                  "Profile",
                  textScaleFactor: 1.5,
                  style: TextStyle(color: Colors.white),
                ),
              ),
              
              // admin?
              // ListTile(
              //   onTap: ((){
              //     Navigator.push(context, MaterialPageRoute(builder: ((context) =>  DoctorRequest())));
              //   }),
              //   leading: const Icon(
              //     CupertinoIcons.doc,
              //     color: Colors.white,
              //   ),
              //   title: const 
              //   Text(
              //     "Doctors request",
              //     textScaleFactor: 1.5,
              //     style: TextStyle(color: Colors.white),
              //   ),
              // ):const Text('',
              // style: TextStyle(
              //   fontSize: 1,
              // ),
              // ),
              
              ListTile(
                onTap: (()async{
                  try {
                    await _auth.signOut();
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(e.toString())),
                                  );
                  }
                  
                }),
                leading: const Icon(
                  CupertinoIcons.mail,
                  color: Colors.white,
                ),
                title: const  Text(
                  "Logout",
                  textScaleFactor: 1.5,
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        ),
    
    );
  }
}