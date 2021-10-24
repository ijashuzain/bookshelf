import 'package:book_shelf/constants/colors.dart';
import 'package:book_shelf/constants/config.dart';
import 'package:book_shelf/constants/styling.dart';
import 'package:book_shelf/main.dart';
import 'package:book_shelf/providers/loginProvider.dart';
import 'package:book_shelf/ui/widgets/customTimer.dart';
import 'package:book_shelf/ui/widgets/rounded_button.dart';
import 'package:book_shelf/ui/widgets/shadowedTextField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class OTPSection extends StatefulWidget {
  OTPSection({Key key}) : super(key: key);

  @override
  _OTPSectionState createState() => _OTPSectionState();
}

class _OTPSectionState extends State<OTPSection> {
  Config _config;
  TextEditingController txtotp = TextEditingController();

  @override
  void initState() {
    txtotp.text = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _config = Config(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          children: [
            Container(height: _config.rH(20), child: _topPart()),
            Container(
              child: _middlePart(),
            ),
            Container(
              height: _config.rH(50),
              child: Padding(
                padding: EdgeInsets.all(_config.rWP(10)),
                child: _bottomPart(),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _topPart() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(_config.rHP(2)),
            child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                )),
          ),
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
          Consumer<LoginProvider>(
            builder: (context, provider, child) {
              return Padding(
                padding: EdgeInsets.only(
                    right: _config.rWP(5), left: _config.rWP(5)),
                child: Container(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "We sent an SMS code to \n${provider.phonenumber}",
                      style: headStyle,
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }

  Widget _middlePart() {
    return Padding(
      padding: EdgeInsets.only(top: _config.rHP(10)),
      child: Container(
          child: Column(
        children: [
          Container(
            height: _config.rH(20),
            width: _config.rW(80),
            child: SvgPicture.asset("assets/otpimage.svg"),
          )
        ],
      )),
    );
  }

  Widget _bottomPart() {
    return Container(
      width: _config.rW(100),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: _config.rH(1),
          ),
          Consumer<LoginProvider>(
            builder: (context, provider, child) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Enter OTP",
                    style: boldStyle,
                  ),
                  provider.timeOut
                      ? InkWell(
                          onTap: () async {
                            await provider.verify(provider.phonenumber);
                          },
                          child: Text(
                            provider.codeSent ? "resend code" : "Loading",
                            style: normalTitle,
                          ),
                        )
                      : CustomTimer(
                          timeInMinutes: 1,
                          textStyle: boldStyle,
                          onEnd: () {},
                        ),
                ],
              );
            },
          ),
          SizedBox(
            height: _config.rHP(1),
          ),
          ShadowedField(
            controller: txtotp,
            hint: "Enter 6 digit code",
          ),
          SizedBox(
            height: _config.rH(1),
          ),
          _keyPad(),
          // Center(
          //   child: Container(
          //     height: 35,
          //     child: RoundedButton(
          //       onTap: () {},
          //       bgColor: AppColors.primaryDark,
          //       title: Text(
          //         "Next",
          //         style: boldStyle,
          //       ),
          //       titleColor: Colors.black,
          //       borderColor: Colors.transparent,
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }

  Widget _keyPad() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              InkWell(
                onTap: () {
                  txtotp.text = "${txtotp.text}1";
                },
                child: Container(
                  width: _config.rW(26.6),
                  height: _config.rH(7),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "1",
                      style: headStyle,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  txtotp.text = "${txtotp.text}2";
                },
                child: Container(
                  width: _config.rW(26.6),
                  height: _config.rH(7),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "2",
                      style: headStyle,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  txtotp.text = "${txtotp.text}3";
                },
                child: Container(
                  width: _config.rW(26.6),
                  height: _config.rH(7),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "3",
                      style: headStyle,
                    ),
                  ),
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () {
                  txtotp.text = "${txtotp.text}4";
                },
                child: Container(
                  width: _config.rW(26.6),
                  height: _config.rH(7),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "4",
                      style: headStyle,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  txtotp.text = "${txtotp.text}5";
                },
                child: Container(
                  width: _config.rW(26.6),
                  height: _config.rH(7),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "5",
                      style: headStyle,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  txtotp.text = "${txtotp.text}6";
                },
                child: Container(
                  width: _config.rW(26.6),
                  height: _config.rH(7),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "6",
                      style: headStyle,
                    ),
                  ),
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () {
                  txtotp.text = "${txtotp.text}7";
                },
                child: Container(
                  width: _config.rW(26.6),
                  height: _config.rH(7),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "7",
                      style: headStyle,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  txtotp.text = "${txtotp.text}8";
                },
                child: Container(
                  width: _config.rW(26.6),
                  height: _config.rH(7),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "8",
                      style: headStyle,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  txtotp.text = "${txtotp.text}9";
                },
                child: Container(
                  width: _config.rW(26.6),
                  height: _config.rH(7),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "9",
                      style: headStyle,
                    ),
                  ),
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () {
                  if (txtotp.text != null && txtotp.text.length > 0) {
                    txtotp.text =
                        txtotp.text.substring(0, txtotp.text.length - 1);
                  }
                },
                child: Container(
                  width: _config.rW(26.6),
                  height: _config.rH(7),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Clear",
                      style: boldStyle,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  txtotp.text = "${txtotp.text}0";
                },
                child: Container(
                  width: _config.rW(26.6),
                  height: _config.rH(7),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "0",
                      style: headStyle,
                    ),
                  ),
                ),
              ),
              Consumer<LoginProvider>(
                builder: (context, provider, child) {
                  return InkWell(
                    onTap: () async {
                      var result = await provider.login(
                          txtotp.text, provider.phonenumber);
                      print(result);
                      if (result == "SUCCESS") {
                        Navigator.of(context).popUntil((route) => route.isFirst);
                      }
                    },
                    child: Container(
                      width: _config.rW(26.6),
                      height: _config.rH(7),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          provider.logingIn ? "Loading" : "Login",
                          style: boldStyle,
                        ),
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
