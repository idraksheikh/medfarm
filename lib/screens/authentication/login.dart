import 'package:flutter/material.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email = '';
  String password ='';
  bool changestate = false;
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
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.45,left: 35, right: 35,bottom: 0),
              child: SingleChildScrollView(
                child: Column(children: [
                  
                
               TextFormField(
                    decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.email),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        hintText: "Enter Username",
                        labelText: "Username"),
                    onChanged: (value) {
                      
                      setState(() {
                        email=value;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular((10.0))),
                        hintText: "Enter Password",
                        labelText: "Password",
                        
                      ),
                      onChanged:(value){
                          setState(() {
                            password=value;
                          });
                        }, 
                      ),
                 const SizedBox(
                  height: 20,
                 ),
                 InkWell(
                    onTap: () async {
                      debugPrint('$email $password');
                      setState(() {
                        changestate = true;
                      });
                      await Future.delayed(const Duration(seconds: 1));
                      // ignore: use_build_context_synchronously
                      await Navigator.of(context).pushNamed('home');
                    },
                    child: AnimatedContainer(
                      alignment: Alignment.center,
                      duration: const Duration(seconds: 1),
                      width: changestate ? 50 : 130,
                      height: 40,
                      // ignore: sort_child_properties_last
                      child: changestate
                          ? const Icon(Icons.done)
                          : const Text("LOGIN",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.white)),
                      decoration: BoxDecoration(
                          color: Colors.blue.shade600,
                          borderRadius:
                              BorderRadius.circular(changestate ? 50 : 8)),
                    ),
                  ),

                  // ElevatedButton(
                  //   child: Text("Login"),
                  //   style: TextButton.styleFrom(minimumSize: Size(150, 40)),
                  //   onPressed: () {
                  //     Navigator.pushNamed(context, MyRoutes.homeRoute);
                  //   },
                  // )
                  const SizedBox(
                    height: 10.0,
                  ),
                  InkWell(
                      child: const Text("Don't have account? SignUp",
                          style: TextStyle(
                              fontSize: 17, 
                              color: Colors.blue,)),
                      onTap: () {
                        Navigator.of(context).pushNamed('signup');
                      }),
              ]),
              ),
             
            )
          ]
          ),
      ),
    );

  }
}
