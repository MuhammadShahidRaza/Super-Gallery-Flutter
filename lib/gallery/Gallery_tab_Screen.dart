import 'package:flutter/material.dart';

import 'Pictures_Screen.dart';
import 'Videos_Screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../auth/Login.dart';

class GalleryTabScreen extends StatefulWidget {
  const GalleryTabScreen({Key? key}) : super(key: key);

  @override
  State<GalleryTabScreen> createState() => _GalleryTabScreenState();
}

class _GalleryTabScreenState extends State<GalleryTabScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 15,

            bottom: TabBar(tabs: [
              Tab(text: 'Pictures'),
              Tab(
                text: 'Videos',
              ),
            ]),
            // remove the border
          ),
          body: TabBarView(children: [
            Pictures_Screen(),
            VideosScreen(),
          ]
              // ProductList(showFav),
              ),
        ));
  }
}
