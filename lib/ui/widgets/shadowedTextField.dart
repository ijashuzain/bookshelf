import 'package:book_shelf/constants/config.dart';
import 'package:book_shelf/constants/styling.dart';
import 'package:flutter/material.dart';

class ShadowedField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final bool active;

  ShadowedField({Key key, this.controller, this.hint, this.active}) : super(key: key);

  Config _config;

  @override
  Widget build(BuildContext context) {
    _config = Config(context);
    return Container(
      height: _config.rH(5),
      width: _config.rW(80),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Color(0xFFB9A9999), width: 1.5),
          borderRadius: BorderRadius.all(Radius.circular(5)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey[400],
              blurRadius: 6,
              spreadRadius: 2,
              offset: Offset(3, 3),
            )
          ]),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: EdgeInsets.all(_config.rWP(2)),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: "$hint",
              hintStyle: latestSubtitle,
              disabledBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              enabled: active == null ? false : true,
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(
                bottom: _config.rHP(1.7),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
