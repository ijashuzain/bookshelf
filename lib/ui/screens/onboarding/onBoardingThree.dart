import 'package:book_shelf/constants/config.dart';
import 'package:book_shelf/constants/styling.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnBoardingThree extends StatelessWidget {
  OnBoardingThree({Key key}) : super(key: key);

  Config _config;

  @override
  Widget build(BuildContext context) {
    _config = Config(context);
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: _config.rH(10),
          ),
          Container(
            height: _config.rH(15),
            child: Column(
              children: [
                Padding(
            padding:
                EdgeInsets.only(right: _config.rWP(40), left: _config.rWP(5)),
            child: Container(
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Welcome",
                    style: latestSubtitle,
                    textAlign: TextAlign.left,
                  )),
            ),
          ),
          Padding(
            padding:
                EdgeInsets.only(right: _config.rWP(20), left: _config.rWP(5)),
            child: Container(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "We are made of Stories...\nLet's Begin...",
                  style: headStyle,
                  textAlign: TextAlign.left,
                ),
              ),
            ),
          ),
              ],
            ),
          ),
          Container(
            height: _config.rH(50),
            width: _config.rW(90),
            child: SvgPicture.asset("assets/onbThree.svg"),
          )
        ],
      ),
    );
  }
}
