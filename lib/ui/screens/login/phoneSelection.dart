import 'package:book_shelf/constants/colors.dart';
import 'package:book_shelf/constants/config.dart';
import 'package:book_shelf/constants/styling.dart';
import 'package:book_shelf/providers/loginProvider.dart';
import 'package:book_shelf/ui/screens/login/otpSection.dart';
import 'package:book_shelf/ui/widgets/rounded_button.dart';
import 'package:book_shelf/ui/widgets/shadowedTextField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class PhoneSelection extends StatefulWidget {
  PhoneSelection({Key key}) : super(key: key);

  @override
  _PhoneSelectionState createState() => _PhoneSelectionState();
}

class _PhoneSelectionState extends State<PhoneSelection> {
  Config _config;
  TextEditingController txtPhone = TextEditingController();
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  LoginProvider loginProvider;

  @override
  void initState() {
    txtPhone.text = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _config = Config(context);
    return Scaffold(
      key: _scaffoldKey,
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
          Padding(
            padding:
                EdgeInsets.only(right: _config.rWP(5), left: _config.rWP(5)),
            child: Container(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Fill the form to become our \nGuest",
                  style: headStyle,
                  textAlign: TextAlign.left,
                ),
              ),
            ),
          ),
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
            child: SvgPicture.asset("assets/phone.svg"),
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
          Text(
            "Enter your Phone Number",
            style: boldStyle,
          ),
          SizedBox(
            height: _config.rHP(1),
          ),
          ShadowedField(
            controller: txtPhone,
            hint: "Enter 10 digit phone number",
          ),
          SizedBox(
            height: _config.rH(1),
          ),
          _keyPad(),
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
                  txtPhone.text = "${txtPhone.text}1";
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
                  txtPhone.text = "${txtPhone.text}2";
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
                  txtPhone.text = "${txtPhone.text}3";
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
                  txtPhone.text = "${txtPhone.text}4";
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
                  txtPhone.text = "${txtPhone.text}5";
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
                  txtPhone.text = "${txtPhone.text}6";
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
                  txtPhone.text = "${txtPhone.text}7";
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
                  txtPhone.text = "${txtPhone.text}8";
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
                  txtPhone.text = "${txtPhone.text}9";
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
                  if (txtPhone.text != null && txtPhone.text.length > 0) {
                    txtPhone.text =
                        txtPhone.text.substring(0, txtPhone.text.length - 1);
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
                  txtPhone.text = "${txtPhone.text}0";
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
                      if (txtPhone.text != "") {
                        await provider
                            .verifyMembership("+${txtPhone.text}")
                            .then(
                          (value) {
                            if (value) {
                              showUserInfoSheet(provider.member.image,
                                  provider.member.name, provider.member.id);
                            } else {
                              showNotRegisteredSheet();
                            }
                          },
                        );
                      } else {
                        print("Enter 10 Digit");
                      }
                    },
                    child: Container(
                      width: _config.rW(26.6),
                      height: _config.rH(7),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          provider.verifying ? "Loading" : "Next",
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

  void showNotRegisteredSheet() {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Container(
          height: _config.rH(35),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          ),
          child: Column(
            children: [
              Expanded(
                child: Container(),
              ),
              Column(
                children: [
                  Text(
                    "Oops!",
                    style: headStyle,
                  ),
                  Text(
                    "We can't find you at the momement",
                    style: boldStyle,
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(_config.rWP(12)),
                child: Column(
                  children: [
                    Text(
                      "This may happen when you enter wrong number or not registered your mobile number in selected library\n\nKindly check that selected library and entered mobile number is not wrong",
                      style: latestSubtitle,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: _config.rWP(6),
                    right: _config.rWP(6),
                    bottom: _config.rWP(3)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Spacer(),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Ok",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  void showUserInfoSheet(String image, String name, String memberID) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Container(
          height: _config.rH(35),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CircleAvatar(
                backgroundColor: AppColors.primary,
                radius: _config.rH(6),
              ),
              Column(
                children: [
                  Text(
                    "$name",
                    style: boldStyle,
                  ),
                  Text(
                    "$memberID",
                    style: latestSubtitle,
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: _config.rWP(6), right: _config.rWP(6)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Cancel",
                        style: TextStyle(color: Colors.redAccent),
                      ),
                    ),
                    Consumer<LoginProvider>(
                      builder: (context, provider, child) {
                        return TextButton(
                          onPressed: () async {
                            var result =
                                await provider.verify("+${txtPhone.text}");
                            print(result);
                            if (result == "CODESENT") {
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => OTPSection(),
                                ),
                              );
                            }
                          },
                          child: Text(
                            provider.sendOTP ? "Loading" : "Confirm",
                            style: TextStyle(color: Colors.blue),
                          ),
                        );
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
