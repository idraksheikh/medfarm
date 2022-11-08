import 'dart:ffi';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:medfarm/screens/home/Profile/profile.dart';
import 'package:medfarm/services/doctor.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DoctorRegistrationPage extends StatefulWidget {
  const DoctorRegistrationPage({Key? key}) : super(key: key);

  @override
  State<DoctorRegistrationPage> createState() => _DoctorRegistrationPage();
}

class _DoctorRegistrationPage extends State<DoctorRegistrationPage> {
  String? name;
  // final ImagePicker _picker = ImagePicker();
  // XFile? image;
  final _formkey = GlobalKey<FormState>();
  PlatformFile? certificate;
  File? file;
    String? doctorname;
    String? address;
    String? degree;
    String? specialisation;
    bool _showregbutton= true;
  final DoctorService _doctor=DoctorService();
  @override
  Widget build(BuildContext context) {
    Future uploadFile() async {
      try {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        String? fileName = preferences.getString('email');
        final path = "certificate/$fileName";
        final upFile = File(file!.path);
        final ref = FirebaseStorage.instance.ref().child(path);
        final uploadTask = ref.putFile(upFile);
        final snapshot = await uploadTask.whenComplete(() {});
        final urlDownload = await snapshot.ref.getDownloadURL();
        return urlDownload;
      } catch (e) {
        print(e);
        return null;
      }
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        title: const Center(
          child: Text('Doctor registration'),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('lib/images/background.png'),
              fit: BoxFit.cover),
        ),
        child: Stack(children: [
          Container(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.40,
                left: 35,
                right: 35),
            child: SingleChildScrollView(
              child: Form(
                key: _formkey,
                child: Column(children: [
                  // const SizedBox(
                  //   height: 5,
                  // ),

                  //Name field

                  // TextFormField(
                  //   style: const TextStyle(color: Colors.black),
                  //   decoration: const InputDecoration(
                  //     border: OutlineInputBorder(),
                  //     labelText: 'Name Of Doctor',
                  //     prefixIcon: Icon(
                  //       Icons.man,
                  //       color: Colors.blue,
                  //     ),
                  //   ),
                  //   onChanged: ((val) {
                  //             setState(() {
                  //               doctorname = val;
                  //             });
                  //           }),
                  //   textInputAction: TextInputAction.next,
                  //   validator: (value) {
                  //     if (value == null || value.isEmpty) {
                  //       return "Please enter the value";
                  //     } else if ((value.contains(RegExp(r'[0-9]'))) ||
                  //         (!value.contains(
                  //             RegExp(r"^[_A-z]*((-|\s)*[_A-z])*$")))) {
                  //       return "Please enter valid name";
                  //     }
                  //     return null;
                  //   },
                  // ),
                  const SizedBox(
                    height: 20,
                  ),

                  //Degree

                  TextFormField(
                    style: const TextStyle(color: Colors.black),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Degree',
                      prefixIcon: Icon(
                        Icons.notes,
                        color: Colors.blue,
                      ),
                    ),
                    onChanged: ((val) {
                              setState(() {
                                degree = val;
                              });
                            }),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter valid address";
                      }
                      return null;
                    },
                  ),
                  // const SizedBox(
                  //   height: 20,
                  // ),

                  //Specialisation
                  const SizedBox(
                    height: 20,
                  ),

                  TextFormField(
                    style: const TextStyle(color: Colors.black),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Specialisation',
                      prefixIcon: Icon(
                        Icons.verified_user,
                        color: Colors.blue,
                      ),
                    ),
                    onChanged: ((val) {
                              setState(() {
                               specialisation = val;
                              });
                            }),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter valid address";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),

                  //Clinic address

                  TextFormField(
                    style: const TextStyle(color: Colors.black),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Clinic Address',
                      prefixIcon: Icon(
                        Icons.location_history,
                        color: Colors.blue,
                      ),
                    ),
                    onChanged: ((val) {
                              setState(() {
                               address = val;
                              });
                            }),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter valid address";
                      }
                      return null;
                    },
                  ),

                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                      onTap: (() async {
                        // image =
                        //     await _picker.pickImage(source: ImageSource.gallery);
                        final FilePickerResult? result =
                            await FilePicker.platform.pickFiles(
                          type: FileType.custom,
                          allowedExtensions: ['pdf', '.doc', '.jpg'],
                        );
                        if (result != null) {
                          setState(() {
                            certificate = result.files.first;
                            name = result.files.first.name;
                            file = File(certificate!.path.toString());
                          });
                        } else {
                          // User canceled the picker
                        }
                      }),
                      child: Column(
                        children: [
                          if (certificate != null)
                            InkWell(
                              onTap: (() {
                                OpenFile.open(certificate!.path.toString());
                              }),
                              child: Container(
                                alignment: Alignment.center,
                                height: 50,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text("$name"),
                              ),
                            ),
                          Container(
                            alignment: Alignment.center,
                            height: 50,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text("Upload Certificate",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.white)),
                          ),
                        ],
                      )),

                  const SizedBox(
                    height: 20,
                  ),

                  _showregbutton? InkWell(
                    onTap: () async {
                      try {
                        
                        if (file != null) {
                          if (_formkey.currentState!.validate()) {
                            setState(() {
                              _showregbutton=false;
                            });
                            String certificateAdd = await uploadFile();
                            // ignore: unrelated_type_equality_checks
                            if(certificateAdd !=Null){
                              
                              dynamic res=await _doctor.registerDoctor(address, certificateAdd, degree, specialisation);
                              if(res=="true"){
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ProfilePage()));

                              }
                              else{
                                print("error occured");
                                setState(() {
                                  _showregbutton=true;
                                });
                              }
                            }
                            
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Please upload Certificate")),
                          );
                        }
                      } catch (e) {
                        setState(() {
                          _showregbutton=true;
                        });
                         ScaffoldMessenger.of(context).showSnackBar(
                         SnackBar(
                                content: Text("Error:${e.toString()}")),);
                      }

                      // Navigator.of(context).pushNamed('home');
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 40,
                      width: 150,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text("Register",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.white)),
                    ),
                  ):const CircularProgressIndicator(),
                  const SizedBox(
                    height: 20,
                  )
                ]),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
