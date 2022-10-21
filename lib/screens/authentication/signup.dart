// ignore_for_file: constant_identifier_names

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:tut1/utils/routes.dart';

enum Gender { Male, Female }

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  Gender? _gender;
  TextEditingController dateCtl = TextEditingController();
  final _bg = ["A+", "A-", "B+", "B-", "AB+", "AB-", "O+", "O-"];
  String? _selectedval = "A+";
  String username='';
  String password='';
  String email='';
  String address='';
  int? mobile;
  String? date;
  String? gender='Male';
  



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
                  top: MediaQuery.of(context).size.height * 0.45,
                  left: 35,
                  right: 35,
                  bottom: 0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          hintText: "Enter Username",
                          labelText: "Username"),
                          onChanged: ((val){
                              setState(() {
                                username=val;
                              });
                          }),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        hintText: "Enter Password",
                        labelText: "Password",
                      ),
                      onChanged: ((val){
                              setState(() {
                                password=val;
                              });
                          }),
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
                          onChanged: ((val){
                              setState(() {
                                email=val;
                              });
                          }),
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
                          onChanged: ((val){
                              setState(() {
                                address=val;
                              });
                          }),
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
                          onChanged: ((val){
                              setState(() {
                                mobile=int.parse(val);
                              });
                          }),
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
                                date=dateCtl.text;
                          });
                        }
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
                              _gender=val;
                              if(val==Gender.Male){
                                  setState(() {
                                gender='Male';
                              });
                              }
                              else{
                                setState(() {
                                gender='Female';
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
                              _gender=val;
                              if(val==Gender.Male){
                                  setState(() {
                                    
                                gender='Male';
                              });
                              }
                              else{
                                setState(() {
                                  
                                gender='Female';
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
                    InkWell(
                      onTap: () {
                        print(
                          '{$username , $gender , $_selectedval , $email , $address , $password , $date , $mobile}'
                        );
                        Navigator.of(context).pushNamed("login");
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
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
