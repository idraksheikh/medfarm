import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medfarm/services/auth.dart';

class MyDrawer extends StatelessWidget {
  final AuthService _auth=AuthService();
   MyDrawer({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    

    return Drawer(
      child: Container(
        color: Colors.blue.shade900,
        child: ListView(
          children:  [
           const  DrawerHeader(
                padding: EdgeInsets.zero,
                child: UserAccountsDrawerHeader(
                  margin: EdgeInsets.zero,
                  accountName: Text("Ashwin Khale"),
                  accountEmail: Text("ashwinkhale09@gmail.com"),
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: AssetImage('lib/images/dummy-user.jpg'),
                  ),
                )),
            ListTile(
              onTap: (() {
                
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
                Navigator.of(context).pushNamed('doctorregistration');
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
                await _auth.signOut();
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