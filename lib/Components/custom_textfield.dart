import 'package:flutter/material.dart';
class custom_textfield extends StatefulWidget {

  final width;
  final height;
  final hinttitle;
  final controller;
  final onchange;
  final obsecure;
  @override
  State<custom_textfield> createState() => _custom_textfieldState();

  custom_textfield({this.width, this.height, this.hinttitle,this.controller,this.onchange,this.obsecure});
}

class _custom_textfieldState extends State<custom_textfield> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      // width:wdth/1.0,
      // height:hght/13,
      width:widget.width,
      height: widget.height,
      decoration:BoxDecoration(
        border: Border.all(color: Colors.grey,width:0.5),
        borderRadius: BorderRadius.circular(5),
        color:Colors.black12,
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 0),
          child: TextField(
            
            onChanged: widget.onchange??(value){},
            controller: widget.controller??TextEditingController(),
            obscureText: widget.obsecure??false,
            decoration: InputDecoration(
              border: InputBorder.none,
               hintText:widget.hinttitle??"",
              contentPadding: EdgeInsets.only(left: 20),

              // hintStyle: TextStyle(
              //   color: Colors.black45,
              //   fontSize: 12,
              //
              // )
            ),
          ),
        ),
      ),

    );
  }
}
