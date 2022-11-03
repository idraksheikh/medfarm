// ignore_for_file: constant_identifier_names


import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:email_validator/email_validator.dart';

import 'package:medfarm/services/auth.dart';

// import 'package:tut1/utils/routes.dart';
typedef changeScreen = void Function();

enum Gender { Male, Female }

class SignupPage extends StatefulWidget {
  final changeScreen onHarkt;
  
  const SignupPage({Key? key, required this.onHarkt}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState(onHarkt);
}

class _SignupPageState extends State<SignupPage> {
  final AuthService _auth=AuthService();
  Gender? _gender = Gender.Male;

  TextEditingController dateCtl = TextEditingController();
  final _bg = ["A+", "A-", "B+", "B-", "AB+", "AB-", "O+", "O-"];
  String? _selectedval = "A+";
  String username = '';
  String password = '';
  String email = '';
  String address = '';
  int? mobile;
  String? date;
  String? gender = 'Male';
  bool _validPass = false;
  bool _showregbutton=true;
  String error='';
  changeScreen onHarkt;
  late TextEditingController _passController;

  _SignupPageState(this.onHarkt);
  @override
  void initState() {
    super.initState();
    _passController = TextEditingController(text: '');
  }

  final _formKey = GlobalKey<FormState>();
  bool _lockPass = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      body: Container(
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
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            hintText: "Enter email",
                            labelText: "Email"),
                        onChanged: ((val) {
                          setState(() {
                            email = val;
                          });
                        }),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter email";
                          } else if (!(EmailValidator.validate(value))) {
                            return "Please enter valid email";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
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
                            hintText: "Enter DOB",
                            labelText: "Date of Birth"),
                        onTap: () async {
                          DateTime? pickeddate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
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
                      TextFormField(
                        obscureText: _lockPass,
                        controller: _passController,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon: IconButton(
                            icon: _lockPass
                                ? const Icon(Icons.visibility)
                                : const Icon(Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                _lockPass = !(_lockPass);
                              });
                            },
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular((10.0))),
                          hintText: "Enter Password",
                          labelText: "Password",
                        ),
                        onChanged: (value) {
                          setState(() {
                            password = value;
                          });
                        },
                        validator: (value) {
                          if (!_validPass) {
                            return "Please enter valid password";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      FlutterPwValidator(
                        controller: _passController,
                        minLength: 6,
                        uppercaseCharCount: 1,
                        numericCharCount: 1,
                        specialCharCount: 1,
                        width: 400,
                        height: 150,
                        onSuccess: () {
                          setState(() {
                            _validPass = true;
                          });
                        },
                        onFail: () {
                          setState(() {
                            _validPass = false;
                          });
                        },
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      _showregbutton? InkWell(
                        onTap: () async{
                          if (_formKey.currentState!.validate()) {
                            // If the form is valid, display a snackbar. In the real world,
                            // you'd often call a server or save the information in a database.
                            setState(() {
                              _showregbutton=false;
                            });
                            dynamic result=await _auth.sigup(email, password, username, _selectedval, address, mobile, date, gender);
                            
                            
                            switch (result) {
                                case 'invalid-email':
                                  error = "Email is inValid";
                                  setState(() {
                                    _showregbutton = true;
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(error)),
                                  );
                                  break;
                                case 'email-already-in-use':
                                  error = "Email already exists try login";
                                  setState(() {
                                    _showregbutton = true;
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(error)),
                                  );
                                  break;
                                case 'operation-not-allowed':
                                  error = "Operation not allowed";
                                  setState(() {
                                    _showregbutton = true;
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(error)),
                                  );
                                  break;
                                case 'weak-password:':
                                  error = "Weak Password";
                                  setState(() {
                                    _showregbutton = true;
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(error)),
                                  );
                                  break;
                                case'too-many-requests':
                                   error = "Too many Request,try again Later ";
                                  setState(() {
                                    _showregbutton = true;
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(error)),
                                  );
                                  break;

                                default:
                                
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
                          child: const Text("Register",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.white)),
                        ),
                      ):const CircularProgressIndicator(),
                      const SizedBox(
                        height: 20,
                      ),
                      InkWell(
                          child: const Text("Already Registered ? Sign In",
                              style: TextStyle(
                                fontSize: 17,
                                color: Colors.blue,
                              )),
                          onTap: () {
                            setState(() {
                              onHarkt();
                            });
                          }),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Text(error),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
