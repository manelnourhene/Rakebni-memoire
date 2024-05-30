// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, use_build_context_synchronously, unused_local_variable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:imagestorage/services/forgot_password.dart';
import 'package:imagestorage/navBar.dart';
import 'package:imagestorage/register_P.dart';
import 'package:imagestorage/Passenger/Passenger.dart';
import 'package:imagestorage/Passenger/inscriptionP_screen.dart';


class LogInP extends StatefulWidget {
  const LogInP({super.key});

  @override
  State<LogInP> createState() => _LogInPState();
}
class _LogInPState extends State<LogInP> {
  String email = "", password = "", name = "";
  TextEditingController namecontroller = new TextEditingController();
  TextEditingController mailcontroller = new TextEditingController();
  TextEditingController passwordcontroller = new TextEditingController();

  final _formkey = GlobalKey<FormState>();

 userLogin() async {
  String email = mailcontroller.text.trim();
  String password = passwordcontroller.text.trim();
  
  if (email.isNotEmpty && password.isNotEmpty) {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PassengerModePage(userEmail:email, userName: '',)),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Color.fromARGB(255, 222, 214, 63),
          content: Text(
            "No User Found for that Email",
            style: TextStyle(fontSize: 18.0),
          ),
        ));
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Color.fromARGB(255, 222, 14, 14),
          content: Text(
            "Wrong Password Provided by User",
            style: TextStyle(fontSize: 18.0),
          ),
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            "An error occurred. Please try again later.",
            style: TextStyle(fontSize: 18.0),
          ),
        ));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        content: Text(
          "An error occurred. Please try again later.",
          style: TextStyle(fontSize: 18.0),
        ),
      ));
    }
  } else {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.red,
      content: Text(
        "Please provide both email and password.",
        style: TextStyle(fontSize: 18.0),
      ),
    ));
  }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: SingleChildScrollView( // Adding SingleChildScrollView here
         child: Container(
          padding: EdgeInsets.all(20.0), // Adjust padding as needed
          child: Column(
            children: [
              SizedBox(height: 20),
              // logo image
              Icon(
                Icons.person,
                size: 100,
              ),
              SizedBox(height: 30.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter E-mail';
                          }
                          return null;
                        },
                        controller: mailcontroller,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 29, 126, 144),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 29, 126, 144),
                            ),
                          ),
                          fillColor: Colors.white,
                          filled: true,
                          hintText: "Email",
                          hintStyle: TextStyle(
                            color: Color.fromARGB(255, 158, 157, 157),
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                      SizedBox(height: 30.0),
                      TextFormField(
                        controller: passwordcontroller,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Password';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 29, 126, 144),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 29, 126, 144),
                            ),
                          ),
                          fillColor: Colors.white,
                          filled: true,
                          hintText: "Password",
                          hintStyle: TextStyle(
                            color: Color(0xFFb2b7bf),
                            fontSize: 18.0,
                          ),
                        ),
                        obscureText: true,
                      ),
                      SizedBox(height: 30.0),
                      GestureDetector(
                        onTap: () {
                          if (_formkey.currentState!.validate()) {
                            setState(() {
                              email = mailcontroller.text;
                              password = passwordcontroller.text;
                            });
                          }
                          userLogin();
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.symmetric(
                            vertical: 13.0,
                            horizontal: 30.0,
                          ),
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 58, 111, 161),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Text(
                              "Sign In",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ForgotPassword(),
                    ),
                  );
                },
                child: Text(
                  "Forgot Password?",
                  style: TextStyle(
                    color: Color(0xFF8c8e98),
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(height: 30.0),
              SizedBox(height: 40.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: TextStyle(
                      color: Color(0xFF8c8e98),
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(width: 5.0),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => InscriptionPScreen(),
                        ),
                      );
                    },
                    child: Text(
                      "SignUp",
                      style: TextStyle(
                        color: Color(0xFFE9C874),
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
}
} 