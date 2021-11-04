import 'package:book_shelf/constants/config.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingWidget extends StatelessWidget {

  final String title;

   LoadingWidget({Key key, this.title}) : super(key: key);
  
  Config appConfig;

  @override
  Widget build(BuildContext context) {
    appConfig = Config(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: title != null ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                height: appConfig.rH(10),
                width: appConfig.rW(30),
                child: Lottie.asset("assets/loading.json",)
            ),
            Text("$title",style: TextStyle(
              color: Colors.black54,
              fontFamily: "Mulish",
              fontSize: 12
            ),)
          ],
        ) :  Container(
            height: appConfig.rH(10),
            width: appConfig.rW(30),
            child: Lottie.asset("assets/loading.json",)
        ),
      ),
    );
  }
}
