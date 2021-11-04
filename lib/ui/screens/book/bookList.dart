import 'package:book_shelf/constants/config.dart';
import 'package:book_shelf/providers/booksProvider.dart';
import 'package:book_shelf/ui/screens/book/booksUpdate.dart';
import 'package:book_shelf/ui/widgets/loading_widget.dart';
import 'package:book_shelf/ui/widgets/smallCard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BooksList extends StatefulWidget {
  BooksList({Key key}) : super(key: key);
  @override
  _BooksListState createState() => _BooksListState();
}

class _BooksListState extends State<BooksList> {
  Config appConfig;
  BooksProvider booksProvider;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await context.read<BooksProvider>().getAllBooks();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    booksProvider = context.read<BooksProvider>();
    appConfig = Config(context);
    return Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => BooksUpdate(
                          type: "NEW",
                        )));
          },
          backgroundColor: Colors.grey,
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        body: Consumer<BooksProvider>(
          builder: (context, provider, child) {
            if (provider.loadingBooks) {
              return Center(
                child: LoadingWidget(),
              );
            } else {
              return Padding(
                padding: EdgeInsets.all(appConfig.rW(5)),
                child: Container(
                  height: appConfig.rH(100),
                  width: appConfig.rW(100),
                  child: ListView(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    children: [
                      SizedBox(
                        height: appConfig.rHP(1),
                      ),
                      Row(
                        children: [
                          GestureDetector(
                              onTap: (){
                                Navigator.pop(context);
                              },
                              child: Icon(Icons.arrow_back)),
                          SizedBox(
                            width: 20,
                          ),
                          Flexible(
                            child: Container(
                              height: appConfig.rH(4),
                              width: appConfig.rW(100),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(24),
                              ),
                              child: TextFormField(
                                cursorColor: Colors.grey,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(left: 30, bottom: 13),
                                  hintText: "Search Books",
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: appConfig.rHP(5),
                      ),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            childAspectRatio: appConfig.rHP(0.055),
                            mainAxisSpacing: appConfig.rHP(0.1),
                            crossAxisSpacing: appConfig.rWP(3)),
                        itemCount: provider.books.length,
                        itemBuilder: (context, index) {
                          return SmallCard(
                            author: provider.books[index].author,
                            image: provider.books[index].image,
                            title: provider.books[index].title,
                            onTap: () {
                              provider.setCurrentBook(index).then(
                                (value) {
                                  booksProvider.removePickedImage();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => BooksUpdate(type: "OLD",)),
                                  );
                                },
                              );
                            },
                          );
                        },
                      )
                    ],
                  ),
                ),
              );
            }
          },
        ));
  }
}
