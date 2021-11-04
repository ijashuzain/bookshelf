import 'package:book_shelf/constants/config.dart';
import 'package:book_shelf/constants/styling.dart';
import 'package:book_shelf/providers/booksProvider.dart';
import 'package:book_shelf/ui/widgets/bigCard.dart';
import 'package:book_shelf/ui/widgets/properiesTile.dart';
import 'package:book_shelf/ui/widgets/reviewCard.dart';
import 'package:book_shelf/ui/widgets/reviewField.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookDetails extends StatefulWidget {
  BookDetails({Key key}) : super(key: key);

  @override
  BookDetailsState createState() => BookDetailsState();
}

class BookDetailsState extends State<BookDetails> {
  Config appConfig;

  @override
  Widget build(BuildContext context) {
    appConfig = Config(context);
    return Scaffold(
        backgroundColor: Colors.white,
        body: Consumer<BooksProvider>(
          builder: (context, provider, child) {
            return Container(
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: [

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        IconButton(
                            color: Colors.black54,
                            onPressed: (){
                          Navigator.pop(context);
                        }, icon: Icon(Icons.arrow_back),),
                        Expanded(child: Container())
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        height: appConfig.rW(50),
                        width: appConfig.rW(33),
                        child: BigCard(
                          image: '${provider.currentBook.image}',
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: appConfig.rWP(4),
                        ),
                        child: Container(
                          child: Text(
                            "${provider.currentBook.title}",
                            style: headStyle,
                          ),
                        ),
                      ),
                      Container(
                        child: Text(
                          "${provider.currentBook.subtitle}",
                          style: latestSubtitle,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(appConfig.rWP(4)),
                        child: Container(
                          height: appConfig.rW(25),
                          width: appConfig.rW(100),
                          child: GridView.count(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            crossAxisSpacing: 6,
                            mainAxisSpacing: 6,
                            crossAxisCount: 2,
                            childAspectRatio: 4,
                            children: [
                              PropertiesTile(
                                title: "${provider.currentBook.author}",
                                subtitle: "Author",
                                icon: Icons.person,
                              ),
                              PropertiesTile(
                                  title: "${provider.currentBook.qty}",
                                  subtitle: "Available Books",
                                  icon: Icons.book_rounded),
                              PropertiesTile(
                                title: "${provider.currentBook.date}",
                                subtitle: "Release Date",
                                icon: Icons.calendar_today,
                              ),
                              PropertiesTile(
                                  title: "${provider.currentBook.language}",
                                  subtitle: "Language",
                                  icon: Icons.translate)
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: appConfig.rWP(4), right: appConfig.rWP(4)),
                        child: _aboutSection(),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: appConfig.rWP(4),
                          right: appConfig.rWP(4),
                          top: appConfig.rWP(4),
                        ),
                        child: _reviewSection(),
                      ),
                      SizedBox(
                        height: appConfig.rW(5),
                      )
                    ],
                  ),
                ],
              ),
            );
          },
        ));
  }

  Widget _aboutSection() {
    return Consumer<BooksProvider>(
      builder: (context, provider, child) {
        return Container(
          child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "About",
                  style: boldStyle,
                ),
                Text(
                  "${provider.currentBook.description}",
                  style: latestDescription,
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _reviewSection() {
    return Container(
      width: appConfig.rW(100),
      child: Align(
        alignment: Alignment.centerLeft,
        child: ListView(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          children: [
            Text(
              "Reviews",
              style: boldStyle,
            ),
            SizedBox(
              height: appConfig.rWP(1),
            ),
            ReviewField(
              hint: "Enter your review about this book",
            ),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 3,
              itemBuilder: (context, index) {
                return ReviewCard();
              },
            ),
          ],
        ),
      ),
    );
  }
}
