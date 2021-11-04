import 'package:book_shelf/constants/colors.dart';
import 'package:book_shelf/constants/config.dart';
import 'package:book_shelf/constants/styling.dart';
import 'package:book_shelf/ui/screens/login/librarySelection.dart';
import 'package:book_shelf/ui/screens/onboarding/onBoardingOne.dart';
import 'package:book_shelf/ui/screens/onboarding/onBoardingThree.dart';
import 'package:book_shelf/ui/screens/onboarding/onBoardingTwo.dart';
import 'package:book_shelf/ui/widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnboardingMain extends StatefulWidget {
  OnboardingMain({Key key}) : super(key: key);

  @override
  _OnboardingMainState createState() => _OnboardingMainState();
}

class _OnboardingMainState extends State<OnboardingMain> {
  Config _config;
  PageController _controller = PageController(initialPage: 0);

  int currentPage = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    });
  }

  @override
  Widget build(BuildContext context) {
    _config = Config(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          _topPart(),
          _bottomPart(),
        ],
      ),
    );
  }

  Widget _topPart() {
    return Container(
      height: _config.rH(80),
      width: _config.rW(100),
      child: PageView(
        physics: BouncingScrollPhysics(),
        controller: _controller,
        children: [
          OnBoardingOne(),
          OnBoardingTwo(),
          OnBoardingThree(),
        ],
      ),
    );
  }

  Widget _bottomPart() {
    return Container(
      height: _config.rH(20),
      width: _config.rW(100),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(_config.rWP(5)),
            child: GestureDetector(
              onTap: () {
                if (_controller.page != 2.0) {
                  print("Page : ${_controller.page}");
                  _controller.nextPage(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.ease);
                } else {
                  print("Login");
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LibrarySelection()));
                }
              },
              child: CircleAvatar(
                radius: _config.rW(6),
                backgroundColor: AppColors.primaryDark,
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black54,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
