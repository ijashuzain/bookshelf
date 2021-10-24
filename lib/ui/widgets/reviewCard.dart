import 'package:book_shelf/constants/styling.dart';
import 'package:book_shelf/ui/screens/navigation/navigation.dart';
import 'package:flutter/material.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(
        top: appConfig.rWP(4)
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.all(
            Radius.circular(6),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(appConfig.rWP(2)),
              child: Container(
                child: Row(
                  children: [
                    Container(
                      height: appConfig.rW(9),
                      width: appConfig.rW(9),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(219, 219, 219, 1),
                        borderRadius: BorderRadius.all(
                          Radius.circular(6),
                        ),
                      ),
                    ),
                    Padding(
                      padding:  EdgeInsets.only(
                        left: appConfig.rWP(1)
                      ),
                      child: Text(
                        "Faisal KP",
                        style: normalTitle,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "14-09-1998",
                      style: latestSubtitle,
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(appConfig.rWP(2)),
              child: Container(
                child: Text("My Review is written heresdfsdf sdf sd  sdf sdf  sdf  sd f sd f s df  sd f sd f sd f sd f sd f sd f s df sd f sdfsdf", style: reviewText),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
