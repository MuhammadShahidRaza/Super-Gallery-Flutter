import 'package:flutter/material.dart';

class heading_text extends StatefulWidget {
  final title;

  heading_text(
    this.title,
  );

  @override
  State<heading_text> createState() => _heading_textState();
}

class _heading_textState extends State<heading_text> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
