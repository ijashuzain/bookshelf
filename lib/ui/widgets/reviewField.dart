import 'package:book_shelf/constants/config.dart';
import 'package:book_shelf/constants/styling.dart';
import 'package:flutter/material.dart';

class ReviewField extends StatelessWidget {
  final String hint;
  final TextEditingController controller;

  ReviewField({Key key, this.hint, this.controller}) : super(key: key);

  Config appConfig;

  @override
  Widget build(BuildContext context) {
    appConfig = Config(context);
    return Container(
      height: appConfig.rW(35),
      width: appConfig.rW(100),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: Align(
        alignment: Alignment.topLeft,
        child: TextField(
          controller: controller,
          style: normalTitle,
          expands: true,
          keyboardType: TextInputType.multiline,
          maxLines: null,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.all(appConfig.rWP(2)),
              border: InputBorder.none,
              hintText: hint,
              hintStyle: latestSubtitle),
        ),
      ),
    );
  }
}
