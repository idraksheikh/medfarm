import 'dart:io';

import 'package:file_picker/file_picker.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:open_file_plus/open_file_plus.dart';

class DoctorRegistrationPage extends StatefulWidget {
  const DoctorRegistrationPage({Key? key}) : super(key: key);

  @override
  State<DoctorRegistrationPage> createState() => _DoctorRegistrationPage();
}

class _DoctorRegistrationPage extends State<DoctorRegistrationPage> {
  String? name;
  // final ImagePicker _picker = ImagePicker();
  // XFile? image;
  PlatformFile? certificate;
  File? file;

  @override
  Widget build(BuildContext context) {
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
              child: Column(children: [
                const SizedBox(
                  height: 5,
                ),

                //Name field

                const TextField(
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Name Of Doctor',
                    prefixIcon: Icon(
                      Icons.man,
                      color: Colors.blue,
                    ),
                  ),
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(
                  height: 20,
                ),

                //Degree

                const TextField(
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Degree',
                    prefixIcon: Icon(
                      Icons.notes,
                      color: Colors.blue,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),

                //Specialisation
                const SizedBox(
                  height: 20,
                ),

                const TextField(
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Specialisation',
                    prefixIcon: Icon(
                      Icons.verified_user,
                      color: Colors.blue,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),

                //Clinic address

                const TextField(
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Clinic Address',
                    prefixIcon: Icon(
                      Icons.location_history,
                      color: Colors.blue,
                    ),
                  ),
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

                InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed('home');
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
                ),
                const SizedBox(
                  height: 20,
                )
              ]),
            ),
          )
        ]),
      ),
    );
  }
}
