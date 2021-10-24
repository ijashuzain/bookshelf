import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final Color bgColor;
  final Widget title;
  final Color titleColor;
  final VoidCallback onTap;
  final Color borderColor;
  const RoundedButton(
      {Key key,
      this.bgColor,
      this.title,
      this.titleColor,
      this.borderColor,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.all(Radius.circular(18)),
      child: InkWell(
        onTap: () {
          onTap();
        },
        child: Container(
          height: 35,
          width: 100,
          decoration: BoxDecoration(
              color: bgColor,
              border: Border.all(color: borderColor),
              borderRadius: BorderRadius.all(Radius.circular(18))),
          child: Center(
            child: title
          ),
        ),
      ),
    );
  }
}
