// import 'package:flutter/cupertino.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:medfarm/screens/home/home.dart';
// import 'package:flutter/foundation.dart';
import 'package:medfarm/screens/home/Profile/deleteaccount.dart';
import 'package:medfarm/screens/home/Profile/editprofile.dart';
import 'package:medfarm/screens/home/Doctor/doctor_registration.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../services/profile.dart';
import 'package:flutter/material.dart';
import '../../../services/model/user.dart';

// import 'doctor_registration.dart';
class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key}) : super(key: key);

  @override
  State createState() => _ProfilePage();
}

class _ProfilePage extends State<ProfilePage> {
  _ProfilePage();
  final ProfileService _profile = ProfileService();
  Future<UserData?> takeValue() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      var res = await _profile.showProfile(preferences.getString('email'));
      print(res.toString());
      return res;
    } catch (e) {
      print("error occured");
      return null;
    }
  }

  late Future<UserData?> userData;

  @override
  void initState() {
    super.initState();
    setState(() {
      userData = takeValue();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: true,
      ),
      body: Container(
        padding:
            const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
        child: FutureBuilder<UserData?>(
          future: userData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                  child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          showAlertDialogForEdit(context);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 50,
                          width: 150,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.edit,
                                semanticLabel: 'Edit Profile',
                                color: Colors.white,
                              ),
                              Text(
                                'Edit Profile',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      InkWell(
                        onTap: () {
                          showAlertDialogForDelete(context);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 50,
                          width: 150,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.delete,
                                semanticLabel: 'Delete Account',
                                color: Colors.white,
                              ),
                              Text(
                                'Delete Account',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Stack(
                    children: [
                      Container(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              displayContent(
                                  "UserName", '${snapshot.data!.username}'),
                              const SizedBox(
                                height: 10,
                              ),
                              displayContent(
                                  "Mobile No", '${snapshot.data!.mobile}'),
                              const SizedBox(
                                height: 10,
                              ),
                              displayContent(
                                  "Date Of Birth", '${snapshot.data!.dob}'),
                              const SizedBox(
                                height: 10,
                              ),
                              displayContent(
                                  "Address", '${snapshot.data!.address}'),
                              const SizedBox(
                                height: 10,
                              ),
                              displayContent(
                                  "Gender", '${snapshot.data!.gender}'),
                              const SizedBox(
                                height: 10,
                              ),
                              displayContent("Blood Group",
                                  '${snapshot.data!.bloodgroup}'),
                              const SizedBox(
                                height: 10,
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: Container(
                                  height: 70,
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  padding: const EdgeInsets.only(left: 20),
                                  decoration: BoxDecoration(
                                    color: Colors.blue.shade50.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        "Profile",
                                        style: TextStyle(
                                          color: Colors.blue.shade900,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 30,
                                      ),
                                      snapshot.data!.access == "User"
                                          ? Row(
                                              children: [
                                                Text(
                                                  '${snapshot.data!.access}',
                                                  style: TextStyle(
                                                    color: Colors.blue.shade900,
                                                    fontSize: 12,
                                                  ),
                                                  maxLines: 1,
                                                ),
                                                const SizedBox(
                                                  width: 30,
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    showAlertDialogForUpdate(
                                                        context);
                                                  },
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    height: 40,
                                                    width: 150,
                                                    decoration: BoxDecoration(
                                                      color: Colors.blue,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: const [
                                                        Icon(
                                                          Icons.upgrade,
                                                          semanticLabel:
                                                              'Update to Doctor',
                                                          color: Colors.white,
                                                        ),
                                                        Text(
                                                          'Update to Doctor',
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              ],
                                            )
                                          : Text(
                                              '${snapshot.data!.access}',
                                              style: TextStyle(
                                                color: Colors.blue.shade900,
                                                fontSize: 12,
                                              ),
                                              maxLines: 1,
                                            ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ));
            } else if (snapshot.hasError) {
              return const Center(child: Text('Some error occure'));
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  Widget displayContent(String field, String value) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 70,
        width: MediaQuery.of(context).size.width * 0.9,
        padding: const EdgeInsets.only(left: 20),
        decoration: BoxDecoration(
          color: Colors.blue.shade50.withOpacity(0.5),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Text(
              field,
              style: TextStyle(
                color: Colors.blue.shade900,
              ),
            ),
            const SizedBox(
              width: 30,
            ),
            Text(
              value,
              style: TextStyle(
                color: Colors.blue.shade900,
                fontSize: 12,
              ),
              maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }

  showAlertDialogForDelete(BuildContext context) {
    // set up the buttons
    Widget cancelButton = ElevatedButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = ElevatedButton(
      child: Text("Continue"),
      onPressed: () {
        Navigator.push(context,MaterialPageRoute(builder: ((context) =>const DeleteAccount())));
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Delete Account"),
      content: const Text(
        "Would you really want to delete your account.",
        style: TextStyle(
          color: Colors.red,
        ),
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showAlertDialogForEdit(BuildContext context) {
    // set up the buttons
    Widget cancelButton = ElevatedButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = ElevatedButton(
      child: Text("Continue"),
      onPressed: () {
        Navigator.push(context,MaterialPageRoute(builder: ((context) =>const EditProfile())));
        
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Edit Profile"),
      content: const Text("Want to Edit Your Profile ?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showAlertDialogForUpdate(BuildContext context) {
    // set up the buttons
    Widget cancelButton = ElevatedButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = ElevatedButton(
      child: Text("Continue"),
      onPressed: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => DoctorRegistrationPage()));
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Update To Doctor"),
      content: const Text("Want to Upgrade your profile to doctor."),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
    
  }
}
