// ignore_for_file: constant_identifier_names


import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medfarm/screens/home/Profile/profile.dart';
import '../../../services/model/user.dart';

import 'package:shared_preferences/shared_preferences.dart';
import '../../../services/profile.dart';

// import 'package:tut1/utils/routes.dart';


enum Gender { Male, Female }

class EditProfile extends StatefulWidget {

  
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  
  Gender? _gender = Gender.Male;

  TextEditingController dateCtl = TextEditingController();
  final _bg = ["A+", "A-", "B+", "B-", "AB+", "AB-", "O+", "O-"];
  String? _selectedval = "A+";
  String username = '';
  
  String address = '';
  int? mobile=9999999000;
  String? date;
  String? gender = 'Male';
  
  bool _showregbutton=true;
  String error='';
  late Future<UserData?> userData;
  late UserData? us;
  final ProfileService _profile = ProfileService();
  Future<UserData?> takeValue() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      var res = await _profile.showProfile(preferences.getString('email'));
      print(res.toString());
      
      if(res==null){
        print("No data");
      }
      else{
        assignval(res);
      }
      return res;
    } catch (e) {
      print("error occured");
      return null;
    }
  }

  
  void assignval(UserData? info){
    if(info!=null){
setState(() {
      username=info.username!;
      address=info.address!;
      mobile=info.mobile!;
      _selectedval=info.bloodgroup!;
      gender=info.gender!;
      date=info.dob!;

      
    });
    if(gender=='Male'){
        setState(() {
          _gender=Gender.Male;
        });
    }
    else if(gender=='Female'){
       setState(() {
          _gender=Gender.Female;
        });
    }
    }
    
  }
  
  @override
  void initState() {
    super.initState();
    print('running');
    userData=takeValue();
    }
    
  

  final _formKey = GlobalKey<FormState>();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      body: Container(
        decoration:const BoxDecoration(
          color: Colors.white,
        ),
        child: FutureBuilder<UserData?>(
          future: userData,
          builder: ((context, snapshot) {
            if(snapshot.hasData) {
              
              return Container(
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('lib/images/background.png'),
                  fit: BoxFit.cover),
            ),
            child: Stack(
              children: [
                Container(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.4,
                      left: 35,
                      right: 35,
                      bottom: 0),
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 10.0,
                          ),
                          TextFormField(
                            initialValue: username,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                                hintText: "Enter Username",
                                labelText: "Username"),
                            onChanged: ((val) {
                              setState(() {
                                username = val;
                              });
                            }),
                            
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter the value";
                              } else if ((value.contains(RegExp(r'[0-9]'))) ||
                                  (!value.contains(RegExp(r"^[_A-z]*((-|\s)*[_A-z])*$")))) {
                                return "Please enter valid name";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          
                          TextFormField(
                            initialValue: address,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                                hintText: "Enter address",
                                labelText: "Address"),
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
                            height: 10.0,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0)),
                            child: DropdownButtonFormField<String>(
                              
                              isExpanded: true,
                              value: _selectedval,
                              items: _bg
                                  .map((e) => DropdownMenuItem(
                                        value: e,
                                        child: Center(
                                          child: Text(
                                            e,
                                            style: const TextStyle(fontSize: 20),
                                          ),
                                        ),
                                      ))
                                  .toList(),
                              onChanged: (val) {
                                setState(() {
                                  _selectedval = val as String;
                                });
                              },
                              icon: const Icon(Icons.arrow_drop_down_circle,
                                  color: Colors.blue),
                              dropdownColor: Colors.blue.shade100,
                              decoration: InputDecoration(
                                labelText: "Select Blood Group",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          TextFormField(
                             initialValue: '$mobile',
                            inputFormatters: [LengthLimitingTextInputFormatter(10)],
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                                hintText: "Enter Mobile Number",
                                labelText: "Mobile Number"),
                            onChanged: ((val) {
                              setState(() {
                                mobile = int.parse(val);
                              });
                            }),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter mobile number";
                              } else if (value.trim().length < 10) {
                                return "Please enter valid mobile number";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          TextFormField(
                           
                            showCursor: true,
                            readOnly: true,
                            controller: dateCtl,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                                
                                labelText: "DOB $date"),
                            onTap: () async {
                              DateTime? pickeddate = await showDatePicker(
                                currentDate:DateFormat('dd-MM-yyy').parse('$date'),
                                  context: context,
                                  initialDate: DateFormat('dd-MM-yyy').parse('$date'),
                                  firstDate: DateTime(1947),
                                  lastDate: DateTime.now());
                              if (pickeddate != null) {
                                setState(() {
                                  dateCtl.text =
                                      DateFormat('dd-MM-yyyy').format(pickeddate);
                                  date = dateCtl.text;
                                });
                              }
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter Date of birth";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: RadioListTile<Gender>(
                                  contentPadding: const EdgeInsets.all(0.0),
                                  value: Gender.Male,
                                  groupValue: _gender,
                                  dense: true,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                  tileColor: Colors.blue.shade500,
                                  title: Text(Gender.Male.name),
                                  onChanged: (val) {
                                    _gender = val;
                                    if (val == Gender.Male) {
                                      setState(() {
                                        gender = 'Male';
                                      });
                                    } else {
                                      setState(() {
                                        gender = 'Female';
                                      });
                                    }
                                  },
                                ),
                              ),
                              const SizedBox(width: 5.0),
                              Expanded(
                                child: RadioListTile<Gender>(
                                  contentPadding: const EdgeInsets.all(0.0),
                                  value: Gender.Female,
                                  title: Text(Gender.Female.name),
                                  groupValue: _gender,
                                  dense: true,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                  tileColor: Colors.blue.shade500,
                                  onChanged: (val) {
                                    _gender = val;
                                    if (val == Gender.Male) {
                                      setState(() {
                                        gender = 'Male';
                                      });
                                    } else {
                                      setState(() {
                                        gender = 'Female';
                                      });
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          
                          const SizedBox(
                            height: 10.0,
                          ),
                          if (_showregbutton) InkWell(
                            onTap: () async{
                              if (_formKey.currentState!.validate()) {
                                // If the form is valid, display a snackbar. In the real world,
                                // you'd often call a server or save the information in a database.
                                setState(() {
                                  _showregbutton=false;
                                });
                                 dynamic result=await _profile.updateProfile(username,address,mobile,gender,date,_selectedval);
                                
                                
                                // switch (result) {
                                //     case 'invalid-email':
                                //       error = "Email is inValid";
                                //       setState(() {
                                //         _showregbutton = true;
                                //       });
                                //       ScaffoldMessenger.of(context).showSnackBar(
                                //         SnackBar(content: Text(error)),
                                //       );
                                //       break;
                                //     case 'email-already-in-use':
                                //       error = "Email already exists try login";
                                //       setState(() {
                                //         _showregbutton = true;
                                //       });
                                //       ScaffoldMessenger.of(context).showSnackBar(
                                //         SnackBar(content: Text(error)),
                                //       );
                                //       break;
                                //     case 'operation-not-allowed':
                                //       error = "Operation not allowed";
                                //       setState(() {
                                //         _showregbutton = true;
                                //       });
                                //       ScaffoldMessenger.of(context).showSnackBar(
                                //         SnackBar(content: Text(error)),
                                //       );
                                //       break;
                                //     case 'weak-password:':
                                //       error = "Weak Password";
                                //       setState(() {
                                //         _showregbutton = true;
                                //       });
                                //       ScaffoldMessenger.of(context).showSnackBar(
                                //         SnackBar(content: Text(error)),
                                //       );
                                //       break;
                                //     case'too-many-requests':
                                //        error = "Too many Request,try again Later ";
                                //       setState(() {
                                //         _showregbutton = true;
                                //       });
                                //       ScaffoldMessenger.of(context).showSnackBar(
                                //         SnackBar(content: Text(error)),
                                //       );
                                //       break;
        
                                //     default:
                                    
                                //   }
                                if(result=="true"){
                                  Navigator.pushReplacement(context,MaterialPageRoute(builder: ((context) =>  ProfilePage())));
                                }
                                else{
                                  _showregbutton==true;
                                   ScaffoldMessenger.of(context).showSnackBar(
                                       SnackBar(content: Text('error occure')),
                                     );
                                }
                              }
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: 40,
                              width: 150,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Text("Update",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Colors.white)),
                            ),
                          ) else const CircularProgressIndicator(),
                          const SizedBox(
                            height: 20,
                          ),
                          
                          const SizedBox(
                            height: 10.0,
                          ),
                          Text('$error'),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
          }
          else if(snapshot.hasError){
            return const Center(
              child:Text("Something went Wrong"),
            );

          }
            return const Center(
                child: CircularProgressIndicator(),
              );
          
          }
          
        ),
    ),
      ));
  }
}
