import 'package:book_shelf/constants/colors.dart';
import 'package:book_shelf/constants/config.dart';
import 'package:book_shelf/constants/styling.dart';
import 'package:book_shelf/ui/widgets/loading_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class BigCard extends StatelessWidget {
  final String image;

  BigCard({
    Key key,
    this.image,
  }) : super(key: key);

  Config appConfig;

  @override
  Widget build(BuildContext context) {
    appConfig = Config(context);
    return Container(
      height: appConfig.rW(30),
      width: appConfig.rW(20),
      decoration: BoxDecoration(
          color: AppColors.secondary,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [BoxShadow(color: Colors.grey[400], blurRadius: 5, spreadRadius: 2, offset: Offset(5, 5))]),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: image == null
            ? Image.asset(
                "assets/placeholder.jpeg",
                fit: BoxFit.contain,
              )
            : CachedNetworkImage(
                imageUrl: image,
                placeholder: (context, url) => Container(
                  child: Container(
                    color: Colors.white,
                    child: Center(
                      child: SizedBox(
                        height: appConfig.rW(15),
                        width: appConfig.rW(10),
                        child: LoadingWidget(),
                      ),
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
                fit: BoxFit.cover,
              ),
      ),
    );
  }
}
