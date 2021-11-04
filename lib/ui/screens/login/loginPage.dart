import 'package:book_shelf/constants/colors.dart';
import 'package:book_shelf/constants/config.dart';
import 'package:book_shelf/providers/loginProvider.dart';
import 'package:book_shelf/ui/widgets/loading_widget.dart';
import 'package:book_shelf/ui/widgets/rounded_button.dart';
import 'package:book_shelf/ui/widgets/rounded_textfiled.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginProvider loginProvider;
  Config _config;
  TextEditingController txtPhone = TextEditingController();
  TextEditingController txtotp = TextEditingController();
  int pageViewIndex;
  PageController _pgController = PageController(initialPage: 0, keepPage: true);
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String _verificationId;

  void showSnackbar(String message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (mounted)
        Provider.of<LoginProvider>(context, listen: false).getLibraries();
    });
  }

  @override
  Widget build(BuildContext context) {
    loginProvider = context.read<LoginProvider>();
    _config = Config(context);
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        body: Consumer<LoginProvider>(
          builder: (context, provider, child) {
            if (provider.libraryLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return ListView(
                children: [_topSection(), _middleSection(), _bottomSection()],
              );
            }
          },
        ));
  }

  Widget _topSection() {
    return Container(
      width: _config.rW(100),
      height: _config.rH(25),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(72),bottomRight: Radius.circular(72))
      ),
    );
  }

  Widget _middleSection() {
    return Container(
        width: _config.rW(100),
        height: _config.rH(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              child: SvgPicture.asset("assets/logo.svg"),
            ),
            Text(
              "BookShelf",
              style: TextStyle(
                  fontFamily: "Mulish",
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                  color: AppColors.primaryDark),
            )
          ],
        ));
  }

  Widget _bottomSection() {
    return Container(
        width: _config.rW(100),
        height: _config.rH(35),
        decoration: BoxDecoration(
          color: AppColors.primary,
        borderRadius: BorderRadius.only(topLeft : Radius.circular(72),topRight: Radius.circular(72))
        ),
        child: PageView(
          controller: _pgController,
          physics: NeverScrollableScrollPhysics(),
          children: [_phoneNumberSection(), _otpSection()],
        ));
  }

  Widget _phoneNumberSection() {
    return Consumer<LoginProvider>(
      builder: (context, provider, child) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 40,
              width: _config.rW(55),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  border: Border(
                    left: BorderSide(color: Colors.grey),
                    right: BorderSide(color: Colors.grey),
                    top: BorderSide(color: Colors.grey),
                    bottom: BorderSide(color: Colors.grey),
                  )),
              child: Padding(
                padding: EdgeInsets.all(_config.rWP(2)),
                child: Padding(
                  padding: EdgeInsets.only(left: _config.rWP(2)),
                  child: DropdownButton(
                  
                      value: provider.currentLibrary != null
                          ? provider.currentLibrary.name
                          : null,
                      hint: Text("Select Your Library"),
                      style:
                          TextStyle(color: AppColors.primaryDark, fontSize: 12),
                      isExpanded: true,
                      elevation: 1,
                      underline: Container(),
                      onChanged: (val) {
                        print("$val selected");
                        provider.libraries.forEach((element) {
                          print(element.name);
                          if (element.name == val) {
                            provider.setLibrary(element.id);
                          }
                        });
                      },
                      items: provider.libraries != null
                          ? provider.libraries.map((item) {
                              return DropdownMenuItem<String>(
                                value: item.name,
                                child: Text(item.name),
                              );
                            }).toList()
                          : []),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              height: 40,
              width: _config.rW(55),
              child: RoundedTextField(
                controller: txtPhone,
                hint: "10 Digit Phone Number",
              ),
            ),
            Container(
              margin: EdgeInsets.all(_config.rWP(2)),
              height: 35,
              width: _config.rW(30),
              child: RoundedButton(
                onTap: () async {
                  await provider.verifyMembership(txtPhone.text).then((value) {
                    if (value) {
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          title: Text(
                            'Is it you ?',
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          content: Container(
                            width: _config.rW(80),
                            height: _config.rW(10),
                            child: Center(
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    child: Icon(
                                      Icons.person,
                                      color: Colors.white,
                                    ),
                                    backgroundColor: AppColors.primary,
                                    radius: 30,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        provider.member.name,
                                        style: TextStyle(
                                            color: Colors.brown[900],
                                            fontFamily: "Mulish",
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18),
                                      ),
                                      Text(
                                        provider.member.id,
                                        style: TextStyle(
                                            color: AppColors.primaryDark,
                                            fontFamily: "Mulish",
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          actions: [
                            FlatButton(
                              child: Text(
                                'Yes',
                                style:
                                    TextStyle(color: AppColors.secondaryDark),
                              ),
                              onPressed: () async {
                                var result =
                                    await provider.verify("+${txtPhone.text}");
                                if (result == "SUCCESS") {}
                                if (result == "CODESENT") {
                                  pageViewIndex = 1;
                                  _pgController.animateToPage(
                                    pageViewIndex,
                                    duration: Duration(milliseconds: 500),
                                    curve: Curves.easeIn,
                                  );
                                  setState(() {});
                                }
                                Navigator.pop(context);
                              },
                            ),
                            FlatButton(
                              child: Text(
                                'No',
                                style: TextStyle(color: Colors.redAccent),
                              ),
                              onPressed: () async {
                                Navigator.pop(context);
                              },
                            )
                          ],
                        ),
                      );
                    } else {
                      showSnackbar("You are not a member in Library");
                    }
                  });
                },
                bgColor: AppColors.primaryDark,
                borderColor: Colors.transparent,
                title: provider.sendOTP == true
                    ? LoadingWidget()
                    : Text(
                        "Send OTP",
                        style: TextStyle(
                            color: AppColors.background,
                            fontFamily: "Mulish",
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
              ),
            ),
            Text(
              "Click here for instructions",
              style: TextStyle(
                  color: AppColors.secondary,
                  fontFamily: "Mulish",
                  fontSize: 12,
                  fontWeight: FontWeight.w400),
            ),
          ],
        );
      },
    );
  }

  Widget _otpSection() {
    return Consumer<LoginProvider>(
      builder: (context, provider, child) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 40,
              width: _config.rW(55),
              child: RoundedTextField(
                controller: txtotp,
                hint: "Enter OTP",
                type: TextInputType.number,
              ),
            ),
            Container(
              margin: EdgeInsets.all(_config.rWP(2)),
              height: 35,
              width: _config.rW(30),
              child: RoundedButton(
                onTap: () async {
                  var result = await provider.login(txtotp.text, txtPhone.text);
                  print("Result : $result");
                },
                bgColor: AppColors.primaryDark,
                borderColor: Colors.transparent,
                title: provider.logingIn == true
                    ? LoadingWidget()
                    : Text(
                        "Login",
                        style: TextStyle(
                            color: AppColors.background,
                            fontFamily: "Mulish",
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
              ),
            ),
            !provider.timeOut
                ? LoadingWidget()
                : IconButton(
                    splashRadius: 25,
                    iconSize: 30,
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: AppColors.primaryDark,
                      size: 30,
                    ),
                    onPressed: () {
                      provider.loadingChange();
                      pageViewIndex = 0;
                      _pgController.animateToPage(
                        pageViewIndex,
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeIn,
                      );
                    })
          ],
        );
      },
    );
  }
}
