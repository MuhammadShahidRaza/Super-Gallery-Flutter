import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'auth/Login.dart';

class ImageView extends StatefulWidget {
  const ImageView({Key? key}) : super(key: key);

  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Login()),
    );
  }

  initState() {
    super.initState();
    getdata();
  }

  getdata() async {
    var user = FirebaseAuth.instance.currentUser;
    try {
      EasyLoading.show();

      var data = await FirebaseDatabase.instance
          .ref()
          .child('users')
          .child(user!.uid)
          .child('images')
          .get();
      if (data.exists) {
        var map = data.value as Map<dynamic, dynamic>;
        map.forEach((key, value) {
          var map2 = value as Map<dynamic, dynamic>;
          map2.forEach((key, value) {
            images.addAll(value);
            log(value.toString());
          });
        });
      }
    } catch (e) {
    } finally {
      EasyLoading.dismiss();
      if (mounted) setState(() {});
    }
  }

  List<dynamic> images = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Image Viewer"),
        centerTitle: true,
        elevation: 0, // remove the border
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              _signOut();
            },
          ),
        ],
      ),
      body: GridView.count(
          crossAxisCount: 3,
          mainAxisSpacing: 1.0,
          crossAxisSpacing: 1.0,
          children: List.generate(images.length, (index) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(images[index] ?? "",
                  width: 30,
                  height: 30,
                  fit: BoxFit.cover, errorBuilder: (BuildContext context,
                      Object exception, StackTrace? stackTrace) {
                return Icon(Icons.shopping_basket);
              }, loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                );
              }),
            );
          })),
    );
  }
}
