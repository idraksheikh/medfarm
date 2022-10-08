import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const imgurl = "https://statinfer.com/front-page/dummy-user/";

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
                    backgroundImage: NetworkImage(imgurl),
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
              onTap: ((){}),
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