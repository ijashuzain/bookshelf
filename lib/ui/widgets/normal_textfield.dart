import 'package:book_shelf/constants/colors.dart';
import 'package:flutter/material.dart';

class NormalTextfield extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final IconData icon;

  NormalTextfield({Key key, this.hint, this.controller, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20),
      child: TextFormField(

        controller: controller,
        decoration: InputDecoration(
          fillColor: AppColors.secondaryDark,
          focusColor: AppColors.secondaryDark,
            icon: Icon(
              icon
            ),
            hintStyle: TextStyle(
                color: Colors.grey,
                fontSize: 13,
                fontFamily: "Mulish"
            ),
            hintText: hint,
        ),
      ),
    );
  }
}
