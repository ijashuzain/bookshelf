import 'package:book_shelf/constants/colors.dart';
import 'package:book_shelf/constants/config.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final IconData icon;
  final String text;

  CategoryCard({Key key, this.icon, this.text}) : super(key: key);

  Config appConfig;

  @override
  Widget build(BuildContext context) {
    appConfig = Config(context);
    return Container(
      height: appConfig.rH(4),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.all(appConfig.rWP(1)),
            child: Container(
              height: appConfig.rH(4),
              width: appConfig.rH(3),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.all(Radius.circular(6)),
              ),
              child: Icon(
                icon,
                color: AppColors.primary,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(appConfig.rWP(1)),
            child: Text("$text"),
          )
        ],
      ),
    );
  }
}
