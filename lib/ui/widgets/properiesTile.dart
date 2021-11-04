import 'package:book_shelf/constants/styling.dart';
import 'package:book_shelf/ui/screens/navigation/navigation.dart';
import 'package:flutter/material.dart';

class PropertiesTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  PropertiesTile({Key key, this.icon, this.title, this.subtitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: appConfig.rW(10),
      decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.all(Radius.circular(6))),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.all(
              appConfig.rWP(1),
            ),
            child: Container(
              height: appConfig.rW(10),
              width: appConfig.rW(9),
              decoration: BoxDecoration(
                  color: Color.fromRGBO(219, 219, 219, 1), borderRadius: BorderRadius.all(Radius.circular(6))),
              child: Icon(
                icon,
                color: Colors.grey,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: Container(
                    width: appConfig.rW(30),
                    child: Text(
                      "${title.toString()}",
                      style: normalBoldStyle,
                      overflow: TextOverflow.fade,
                      maxLines: 1,
                      softWrap: false,
                    )),
              ),
              Flexible(
                child: Container(
                  width: appConfig.rW(30),
                  child: Text(
                    "$subtitle",
                    style: latestSubtitle,
                    overflow: TextOverflow.fade,
                    maxLines: 1,
                    softWrap: false,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
