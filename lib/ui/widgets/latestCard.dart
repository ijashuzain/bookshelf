import 'package:book_shelf/constants/colors.dart';
import 'package:book_shelf/constants/config.dart';
import 'package:book_shelf/constants/styling.dart';
import 'package:book_shelf/ui/widgets/loading_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class LatestCard extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;
  final String description;

  LatestCard({Key key, this.image, this.title, this.subtitle, this.description}) : super(key: key);

  Config appConfig;

  @override
  Widget build(BuildContext context) {
    appConfig = Config(context);
    return Container(
      height: appConfig.rW(40),
      width: appConfig.rW(100),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        // boxShadow: [
        //   BoxShadow(color: Colors.grey[200], blurRadius: 5, spreadRadius: 5)
        // ],
      ),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(left: appConfig.rWP(4)),
            child: Container(
              height: appConfig.rW(30),
              width: appConfig.rW(20),
              decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8)), boxShadow: [
                BoxShadow(color: Colors.grey[400], blurRadius: 5, spreadRadius: 2, offset: Offset(5, 5))
              ]),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                // child: Image.network(
                //   "$image",
                //   fit: BoxFit.cover,
                // )),
                child: image == null ? Image.asset("assets/placeholder.jpeg",fit: BoxFit.contain,)  : CachedNetworkImage(
                  imageUrl: image,
                  placeholder: (context, url) => Container(
                      child: Container(
                    color: Colors.white,
                    child: Center(
                        child: SizedBox(
                            height: appConfig.rW(15),
                            width: appConfig.rW(10),
                            child: LoadingWidget(
                            ))),
                  )),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: appConfig.rW(40) ?? null,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: Padding(
                padding: EdgeInsets.only(left: appConfig.rWP(4), top: appConfig.rWP(10), right: appConfig.rWP(2)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "$title",
                      style: latestTitle,
                    ),
                    subtitle != null && subtitle != ""
                        ? Text(
                            "$subtitle",
                            style: latestSubtitle,
                          )
                        : SizedBox.shrink(),
                    SizedBox(
                      height: appConfig.rWP(2),
                    ),
                    Text(
                      "$description",
                      style: latestDescription,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
