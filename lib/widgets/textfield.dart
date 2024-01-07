import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyTextfield extends StatelessWidget {
   MyTextfield({Key? key,
     required this.hintText,
     required this.labelText,required this.onChangeee,
   this.prefixIcon,this.suffixIcon}) : super(key: key);

   String hintText;
   String labelText;
   Function(String) onChangeee;
   Icon? prefixIcon;
   Icon? suffixIcon;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChangeee,
      decoration: InputDecoration(enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16)
    )
      ,hintText:hintText,labelText: labelText
      ,focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16)
      ),
    ),
    );
  }
}
