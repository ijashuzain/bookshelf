import 'package:book_shelf/constants/config.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingWidget extends StatelessWidget {
   LoadingWidget({Key key}) : super(key: key);
  
  Config appConfig;

  @override
  Widget build(BuildContext context) {
    appConfig = Config(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          height: appConfig.rH(10),
          width: appConfig.rW(30),
          child: Lottie.asset("assets/loading.json",)
        ),
      ),
    );
  }
}
