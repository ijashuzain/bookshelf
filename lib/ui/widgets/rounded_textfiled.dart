import 'package:book_shelf/constants/colors.dart';
import 'package:book_shelf/constants/config.dart';
import 'package:flutter/material.dart';

Config appConfig;

class RoundedTextField extends StatelessWidget {
  final String hint;
  final TextInputType type;
  final TextEditingController controller;
  const RoundedTextField({Key key, this.hint, this.controller, this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    appConfig = Config(context);
    return TextFormField(
    
      keyboardType: type,
      textAlign: TextAlign.center,
      controller: controller,
      style:
          TextStyle(fontFamily: "Mulish", color: Colors.black87, fontSize: 14),
      cursorColor: AppColors.primaryDark,
      decoration: InputDecoration(
        
          hintText: hint,
          hintStyle:
              TextStyle(fontFamily: "Mulish", color: Colors.grey, fontSize: 12),
          focusColor: Colors.white,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            borderSide: BorderSide(color: AppColors.primaryDark),
          ),
          contentPadding: EdgeInsets.only(top: 40 / 2)),
    );
  }
}
