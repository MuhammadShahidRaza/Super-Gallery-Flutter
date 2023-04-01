import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../Components/custom_textfield.dart';

import '../Components/heading_text.dart';
import '../Tab_Screen.dart';
import '../models/User.dart';
import 'Signup.dart';

class Login extends StatefulWidget {
  const Login();

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var email = TextEditingController();
  var password = TextEditingController();
  List<String> wrontexts = ['', ''];
  var wdth;
  var hght;
  @override
  Widget build(BuildContext context) {
    wdth = MediaQuery.of(context).size.width;
    hght = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Color.fromARGB(255, 38, 166, 154),
          child: Center(
              child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 4,
                ),
                Image.asset(
                  'assets/logo.png',
                  fit: BoxFit.fill,
                ),
                Container(
                  width: wdth / 1.1,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      border: Border.all(color: Colors.grey, width: 0.5)),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SizedBox(width: 10),
                          ],
                        ),
                        Stack(
                          children: [
                            TextFormField(
                              controller: email,
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.grey[600],
                              ),
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.fromLTRB(52.0, 16.0, 16.0, 16.0),
                                filled: true,
                                fillColor: Colors.grey[200],
                                hintText: "Email",
                                hintStyle: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.grey[400],
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide.none,
                                ),
                                prefixIcon:
                                    Icon(Icons.email, color: Colors.grey[600]),
                              ),
                            ),
                          ],
                        ),
                        if (wrontexts[0].trim().isNotEmpty)
                          Text(
                            wrontexts[0],
                            style: TextStyle(color: Colors.red),
                          ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [],
                        ),
                        Stack(
                          children: [
                            TextFormField(
                              obscureText: true,
                              controller: password,
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.grey[600],
                              ),
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.fromLTRB(52.0, 16.0, 16.0, 16.0),
                                filled: true,
                                fillColor: Colors.grey[200],
                                hintText: "Password",
                                hintStyle: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.grey[400],
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide.none,
                                ),
                                suffixIcon: Icon(
                                  Icons.lock,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ),
                            Positioned(
                              left: 16.0,
                              top: 16.0,
                              child: Icon(
                                Icons.lock_outline,
                                color: Colors.grey[600],
                                size: 20.0,
                              ),
                            ),
                          ],
                        ),
                        if (wrontexts[1].trim().isNotEmpty)
                          Text(
                            wrontexts[1],
                            style: TextStyle(color: Colors.red),
                          ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              child: Row(
                                children: [
                                  Text(
                                    "If you don't have an account? ",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  Text(
                                    "Sign Up",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.blue,
                                      decoration: TextDecoration.underline,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const Signup()));
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: loginfun,
                              child: Container(
                                width: wdth / 4.4,
                                height: hght / 17,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.blueAccent,
                                      Colors.blue,
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: Text(
                                    'LOG IN',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
        ),
      ),
    );
  }

  Future<void> loginfun() async {
    for (int i = 0; i < wrontexts.length; i++) wrontexts[i] = '';
    setState(() {});

    if (email.text.trim().isEmpty && password.text.trim().isEmpty) {
      wrontexts[0] = 'Email couldn\'t be empty!!';
      wrontexts[1] = 'Password couldn\'t be empty!!';
      setState(() {});
      return;
    }
    if (email.text.trim().isEmpty) {
      wrontexts[0] = 'Email couldn\'t be empty!!';
      setState(() {});
      return;
    }
    if (password.text.trim().isEmpty) {
      wrontexts[1] = 'Password couldn\'t be empty!!';
      setState(() {});
      return;
    }
    if (password.text.trim().length < 6) {
      wrontexts[1] = 'Password should be 6 characters !!';
      setState(() {});
      return;
    }
    try {
      EasyLoading.show();

      try {
        UserCredential user = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: email.text.trim(), password: password.text.trim());
        if (user.user != null)
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const TabScreen()),
              (roure) => false);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          EasyLoading.showToast('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          EasyLoading.showToast('Wrong password provided for that user.');
        }
      }
    } catch (e) {
    } finally {
      EasyLoading.dismiss();
    }
  }
}
