
import 'package:flutter/material.dart';

import '../style/styles.dart';
class Custom_Button extends StatefulWidget {
  final onPress;
  final title;

  Custom_Button(this.onPress, this.title, );

  @override
  State<Custom_Button> createState() => _Custom_ButtonState();
}

class _Custom_ButtonState extends State<Custom_Button> {
  @override
  var wdth;
  var hght;
  Widget build(BuildContext context) {
    wdth=MediaQuery.of(context).size.width;
    hght=MediaQuery.of(context).size.height;
    return GestureDetector(
      child: Container(

        height:hght/17,
        decoration:BoxDecoration(
            borderRadius:BorderRadius.circular(10),
            color:Colors.black
        ),
        padding:EdgeInsets.all(10),

        child:Center(child: Text(widget.title,style:buttontext,)),
      ),
      onTap:widget.onPress,
    );
  }
}
