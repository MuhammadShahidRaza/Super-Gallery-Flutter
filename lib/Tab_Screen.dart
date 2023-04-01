import 'package:flutter/material.dart';

import 'ImageView.dart';
import 'gallery/Gallery_tab_Screen.dart';
import 'ocr/OcrScreen.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({Key? key}) : super(key: key);

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_pageslectedindex]['page'],
      bottomNavigationBar: BottomNavigationBar(
          onTap: _selectPage,
          backgroundColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.purple,
          selectedItemColor: Colors.white,
          currentIndex: _pageslectedindex,
          type: BottomNavigationBarType.shifting,
          items: [
            BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: const Icon(
                Icons.photo,
                color: Colors.white,
              ),
              label: 'Categories',
            ),
            BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: const Icon(
                Icons.document_scanner,
                color: Colors.white,
              ),
              label: 'OCR',
            ),
            BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: const Icon(
                Icons.image,
                color: Colors.white,
              ),
              label: 'Images',
            ),
          ]),
    );
  }

  late List<Map<String, dynamic>> _pages;

  int _pageslectedindex = 0;
  @override
  void initState() {
    _pages = [
      {
        'page': const GalleryTabScreen(),
        'title': 'Gallery',
      },
      {
        'page': const OCRscreen(),
        'title': 'OCR',
      },
      {
        'page': const ImageView(),
        'title': 'Image Viewer',
      },
    ];
    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
      _pageslectedindex = index;
    });
  }
}
