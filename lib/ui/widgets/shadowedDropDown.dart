import 'package:book_shelf/constants/config.dart';
import 'package:book_shelf/constants/styling.dart';
import 'package:flutter/material.dart';

class ShadowedDropDown extends StatelessWidget {
  final String hint;
  final dynamic value;
  final Function onChange;
  final List<DropdownMenuItem<dynamic>> items;

  ShadowedDropDown({Key key, this.hint, this.value, this.onChange, this.items})
      : super(key: key);

  Config _config;

  @override
  Widget build(BuildContext context) {
    _config = Config(context);
    return Container(
        height: 45,
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
        child: Padding(
          padding: EdgeInsets.all(_config.rWP(2)),
          child: DropdownButton(
            value: value,
            items: items,
            onChanged: (val) {
              onChange(val);
            },
            isExpanded: true,
            underline: Container(),
            hint: Text(
              "$hint",
              style: latestSubtitle,
            ),
          ),
        ));
  }
}
