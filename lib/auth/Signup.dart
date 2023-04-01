import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:img_to_txt/auth/Login.dart';
import '../../Components/custom_textfield.dart';
import '../../Components/heading_text.dart';
import '../../models/User.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  var email = TextEditingController();
  var name = TextEditingController();
  var password = TextEditingController();
  var cpassword = TextEditingController();
  var address = TextEditingController();
  var contact = TextEditingController();
  var postcode = TextEditingController();
  bool check1 = false;
  bool check2 = false;
  List<String> wrontexts = ['', '', '', '', '', '', '', '', ''];
  var wdth;
  var hght;
  @override
  Widget build(BuildContext context) {
    wdth = MediaQuery.of(context).size.width;
    hght = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text("Log In"),
      ),
      body: Container(
          color: Color.fromARGB(255, 38, 166, 154),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    color: Color.fromARGB(255, 38, 166, 154),
                    child: Center(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Container(
                            width: wdth / 1.1,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                border:
                                    Border.all(color: Colors.grey, width: 0.5)),
                            child: Container(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Column(
                                        children: [
                                          //Image.asset("images/logo.png",width:wdth/2,height: hght/3,),

                                          heading_text("Create a new account"),
                                        ],
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(width: 10),
                                    ],
                                  ),
                                  Stack(
                                    children: [
                                      TextFormField(
                                        controller: name,
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          color: Colors.grey[600],
                                        ),
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.fromLTRB(
                                              52.0, 16.0, 16.0, 16.0),
                                          filled: true,
                                          fillColor: Colors.grey[200],
                                          hintText: "Full Name",
                                          hintStyle: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.grey[400],
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            borderSide: BorderSide.none,
                                          ),
                                          prefixIcon: Icon(Icons.person,
                                              color: Colors.grey[600]),
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
                                  // Row(
                                  //   children: [heading_text("Full Name")],
                                  // ),
                                  // custom_textfield(
                                  //   width: wdth / 1.0,
                                  //   height: hght / 13,
                                  //   hinttitle: "",
                                  //   controller: name,
                                  // ),
                                  // if (wrontexts[0].trim().isNotEmpty)
                                  //   Text(
                                  //     wrontexts[0],
                                  //     style: TextStyle(color: Colors.red),
                                  //   ),
                                  // SizedBox(
                                  //   height: 10,
                                  // ),
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
                                          contentPadding: EdgeInsets.fromLTRB(
                                              52.0, 16.0, 16.0, 16.0),
                                          filled: true,
                                          fillColor: Colors.grey[200],
                                          hintText: "Password",
                                          hintStyle: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.grey[400],
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
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
                                    children: [],
                                  ),
                                  Stack(
                                    children: [
                                      TextFormField(
                                        obscureText: true,
                                        controller: cpassword,
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          color: Colors.grey[600],
                                        ),
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.fromLTRB(
                                              52.0, 16.0, 16.0, 16.0),
                                          filled: true,
                                          fillColor: Colors.grey[200],
                                          hintText: " Confirm Password",
                                          hintStyle: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.grey[400],
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
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
                                          contentPadding: EdgeInsets.fromLTRB(
                                              52.0, 16.0, 16.0, 16.0),
                                          filled: true,
                                          fillColor: Colors.grey[200],
                                          hintText: "Email",
                                          hintStyle: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.grey[400],
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            borderSide: BorderSide.none,
                                          ),
                                          prefixIcon: Icon(Icons.email,
                                              color: Colors.grey[600]),
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
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: register,
                                        child: Container(
                                          width: wdth / 4.4,
                                          height: hght / 17,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(30),
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
                                                color: Colors.grey
                                                    .withOpacity(0.5),
                                                spreadRadius: 2,
                                                blurRadius: 5,
                                                offset: Offset(0, 3),
                                              ),
                                            ],
                                          ),
                                          child: Center(
                                            child: Text(
                                              'Sign Up',
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
              ),
            ],
          )),
    );
  }

  Future<void> register() async {
    for (int i = 0; i < wrontexts.length; i++) wrontexts[i] = '';
    setState(() {});

    if (name.text.trim().isEmpty &&
        email.text.trim().isEmpty &&
        password.text.trim().isEmpty &&
        cpassword.text.isEmpty) {
      wrontexts[0] = 'Name couldn\'t be empty!!';
      wrontexts[1] = 'Password couldn\'t be empty!!';
      wrontexts[2] = 'Confirm password couldn\'t be empty!!';
      wrontexts[3] = 'Email couldn\'t be empty!!';

      setState(() {});
      return;
    }
    if (name.text.trim().isEmpty) {
      wrontexts[0] = 'Name couldn\'t be empty!!';
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
    if (password.text != cpassword.text || cpassword.text.isEmpty) {
      wrontexts[2] = 'Password & confirm should be same!!';
      setState(() {});
      return;
    }
    if (email.text.trim().isEmpty) {
      wrontexts[3] = 'Email couldn\'t be empty!!';
      setState(() {});
      return;
    }

    try {
      EasyLoading.show();
      UserModel u = new UserModel(
          name: name.text, email: email.text, password: password.text);
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: email.text.trim(), password: password.text.trim());
        try {
          await FirebaseDatabase.instance
              .ref()
              .child('users')
              .child(userCredential.user!.uid)
              .set(u.tojson());
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => const Login()));

          // doc(
          //     userCredential.user?.uid).set(u.tojson()).whenComplete(() {
          //   Navigator.push(context,
          //       MaterialPageRoute(builder: (context) => const Login()));
          // });
        } catch (e) {
          print("************************************************");
          print(e);
          print("************************************************");
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          EasyLoading.showToast('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          EasyLoading.showToast('The account already exists for that email.');
        }
      } catch (e) {
        print(e);
      }
    } catch (e) {
    } finally {
      EasyLoading.dismiss();
    }
  }
}
