// import 'dart:convert';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medfarm/screens/home/home.dart';
import 'package:medfarm/screens/home/profile.dart';
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
 String? email;
 _MyDrawerState();
  getEmail()async{
       SharedPreferences preferences = await SharedPreferences.getInstance();
      setState(() {
        email=preferences.getString('email');
        if(email!=null){
          userData=takeValue(email); 
        }
        
      });
      
    }
    Future<UserData?> takeValue(String? email)async{
    
    try {
      
      var res=await _profile.showProfile(email);
      print(res.toString());
      return  res;
    } catch (e) {
      print("error occured");
      return null;
    }
      
      
   }
    

    @override
  void initState()  {
    super.initState();
    getEmail();
    
    
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
                onTap: (() {
                  Navigator.push(context, MaterialPageRoute(builder: ((context) => Home(forTap: 0))));
                }),
                leading: const Icon(
                  CupertinoIcons.home,
                  color: Colors.white,
                ),
                title: const Text(
                  "Home",
                  textScaleFactor: 1.5,
                  style: TextStyle(color: Colors.white),
                ),
              ),
              ListTile(
                onTap: ((){
                  Navigator.push(context, MaterialPageRoute(builder: ((context) =>  ProfilePage(email:email!))));
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