import 'package:flutter/material.dart';
class simple_text extends StatefulWidget {
  final title;
  @override
  State<simple_text> createState() => _simple_textState();

  simple_text(this.title,);
}

class _simple_textState extends State<simple_text> {
  @override
  Widget build(BuildContext context) {
    return Text(widget.title,style: TextStyle(
      fontSize:16,
      color:Colors.black,
    ),);
  }
}
