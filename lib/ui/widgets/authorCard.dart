import 'package:book_shelf/constants/colors.dart';
import 'package:book_shelf/constants/config.dart';
import 'package:book_shelf/constants/styling.dart';
import 'package:flutter/material.dart';

class AuthorCard extends StatelessWidget {
  AuthorCard({Key key}) : super(key: key);

  Config appConfig;

  @override
  Widget build(BuildContext context) {
    appConfig = Config(context);
    return Container(
      width: appConfig.rW(30),
      height: appConfig.rW(40),
      decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Column(
        children: [
          SizedBox(
            height: appConfig.rWP(5),
          ),
          CircleAvatar(
            radius: appConfig.rWP(7),
            backgroundColor: AppColors.primaryDark,
          ),
          Padding(
            padding: EdgeInsets.all(
              appConfig.rWP(2),
            ),
            child: Text(
              "Vikom Muhammed Basheer",
              style: latestDescription,
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: appConfig.rWP(1),
                right: appConfig.rWP(6),
                left: appConfig.rWP(6)),
            child: Material(
              borderRadius: BorderRadius.all(Radius.circular(16)),
              child: InkWell(
                onTap: () {},
                child: Container(
                  height: appConfig.rW(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(16),
                    ),
                    border: Border.all(color: Colors.black),
                  ),
                  child: Center(
                    child : Text("View",style: latestDescription,)
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
