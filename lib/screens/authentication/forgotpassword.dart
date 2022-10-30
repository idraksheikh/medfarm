// import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';


class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  ForgotPasswordState createState() => ForgotPasswordState();
}

class ForgotPasswordState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();
  late String email;
  String error='';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Column(
          
            children: [
              Container(
                    margin: const EdgeInsets.only(top: 30),
                    child: Image.asset("lib/images/verification.jpeg"),
                  ),
              Container(
                padding: const EdgeInsets.only(left: 20,right: 20,bottom: 20),
                child: Column(
                  children: [
                    
                    Container(
            
                          alignment: Alignment.topLeft,
                          child: const Text("Please Enter the email...",
                          style: TextStyle(color: Colors.black, fontSize: 20)),
                    ),
                    
                    const SizedBox(
                      height: 30,
                    ),
                    Form(
                      key: _formKey,
                      child: TextFormField(
                          decoration: InputDecoration(
                            
                              prefixIcon: const Icon(Icons.email),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              hintText: "Enter email",
                              labelText: "Email"),
                          onChanged: (value) {
                            setState(() {
                              email = value;
                            });
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter email";
                            } else if (!(EmailValidator.validate(value))) {
                              return "Please enter valid email";
                            }
                            return null;
                          },
                        ),),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      padding:const EdgeInsets.symmetric(horizontal: 30),
                      child: MaterialButton(
                        height: 40,
                        minWidth: MediaQuery.of(context).size.width * 1,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        elevation: 5,
                        color:const Color(0xffFF5733),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                                    // If the form is valid, display a snackbar. In the real world,
                                    // you'd often call a server or save the information in a database.
                                    try {
                                      await FirebaseAuth.instance.sendPasswordResetEmail(email: email).then((value) => Navigator.of(context).pop());
                                      
                                    }on FirebaseAuthException catch (e) {
                                      print(e.code);
                                      switch (e.code) {
                                      case 'invalid-email':
                                        error = "Email is inValid";
                                        
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(content: Text(error)),
                                        );
                                        break;
                                      case 'missing-android-pkg-name':
                                        error = "Missing android pkg name";
                                        
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(content: Text(error)),
                                        );
                                        break;
                                      case 'missing-continue-uri':
                                        error = "Missing continue uri";
                                        
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(content: Text(error)),
                                        );
                                        break;
                                      case 'missing-ios-bundle-id':
                                        error = "Missing ios bundle id";
                                        
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(content: Text(error)),
                                        );
                                        break;
                                      case'invalid-continue-uri':
                                         error = "Invalid continue uri";
                                        
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(content: Text(error)),
                                        );
                                        break;
                                        case'unauthorized-continue-uri':
                                         error = "Unauthorized continue uri";
                                        
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(content: Text(error)),
                                        );
                                        break;case'user-not-found':
                                         error = "User not found";
                                        
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(content: Text(error)),
                                        );
                                        break;
                                      default:
                                      
                                    }
                                    }
                                    
                                  }
                          
                        },
                        child: Stack(
                          children: const[
                            Text('Verify',
                                style: TextStyle(color: Colors.white, fontSize: 20))
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}