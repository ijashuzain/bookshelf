import 'package:book_shelf/constants/colors.dart';
import 'package:book_shelf/constants/config.dart';
import 'package:book_shelf/constants/styling.dart';
import 'package:book_shelf/data/userdata.dart';
import 'package:book_shelf/providers/booksProvider.dart';
import 'package:book_shelf/providers/loginProvider.dart';
import 'package:book_shelf/ui/screens/book/bookDetails.dart';
import 'package:book_shelf/ui/screens/book/bookList.dart';
import 'package:book_shelf/ui/screens/members/membersMain.dart';
import 'package:book_shelf/ui/screens/onboarding/onBoardingMain.dart';
import 'package:book_shelf/ui/widgets/authorCard.dart';
import 'package:book_shelf/ui/widgets/categoryCard.dart';
import 'package:book_shelf/ui/widgets/latestCard.dart';
import 'package:book_shelf/ui/widgets/loading_widget.dart';
import 'package:book_shelf/ui/widgets/smallCard.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  LoginProvider loginProvider;
  BooksProvider booksProvider;
  UserData userData = UserData();
  Config appConfig;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      loginProvider = context.read<LoginProvider>();
      booksProvider = context.read<BooksProvider>();
      await loginProvider.getUserData();
      await booksProvider.getAllBooks();
    });
  }

  @override
  Widget build(BuildContext context) {
    appConfig = Config(context);
    loginProvider = context.read<LoginProvider>();
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: Consumer<LoginProvider>(
        builder: (context, provider, child) {
          if (provider.currentUser.type == "lib") {
            return Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton(
                  heroTag: "btnMemebers",
                  mini: true,
                  elevation: 3,
                  backgroundColor: AppColors.primaryDark,
                  child: Icon(Icons.person),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MembersMain()));
                  },
                ),
                SizedBox(
                  height: 5,
                ),
                FloatingActionButton(
                  heroTag: "btnBooks",
                  elevation: 3,
                  backgroundColor: AppColors.primaryDark,
                  child: Icon(Icons.add),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => BooksList()));
                  },
                ),
              ],
            );
          } else {
            return Container();
          }
        },
      ),
      body: Consumer<LoginProvider>(
        builder: (context, provider, child) {
          return provider.userLoading
              ? Center(
                  child: LoadingWidget(),
                )
              : Container(
                  child: Center(
                    child: RefreshIndicator(
                      onRefresh: () async {
                        await context.read<BooksProvider>().getAllBooks();
                      },
                      child: ListView(
                        physics: BouncingScrollPhysics(),
                        children: [
                          homeTopPart(context),
                          homeListPart(context),
                          Text("Library : ${provider.currentLibrary?.name}"),
                          Text("User : ${provider.currentUser?.name}"),
                        ],
                      ),
                    ),
                  ),
                );
        },
      ),
    );
  }

  Widget homeListPart(BuildContext context) {
    return Consumer<BooksProvider>(
      builder: (context, provider, child) {
        if (provider.loadingBooks) {
          return Container(
            height: appConfig.rH(80),
            width: appConfig.rW(100),
            child: Center(
              child: Container(
                  height: appConfig.rH(30),
                  width: appConfig.rW(30),
                  child: LoadingWidget()),
            ),
          );
        } else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    left: appConfig.rW(5), top: appConfig.rW(5)),
                child: Text(
                  "Latest Books",
                  style: boldStyle,
                ),
              ),
              Container(
                height: appConfig.rW(50),
                width: appConfig.rW(100),
                child: PageView.builder(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: provider.books.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: appConfig.rWP(4),
                          vertical: appConfig.rWP(1)),
                      child: LatestCard(
                        title: provider.books[index].title,
                        subtitle: provider.books[index].subtitle,
                        description: provider.books[index].description,
                        image: provider.books[index].image,
                      ),
                    );
                  },
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(
                      left: appConfig.rW(5),
                      top: appConfig.rW(5),
                      right: appConfig.rW(5)),
                  child: Row(
                    children: [
                      Text(
                        "Novels",
                        style: boldStyle,
                      ),
                      Expanded(
                        child: Container(),
                      ),
                      Text(
                        "View All",
                        style: normalTitle,
                      ),
                    ],
                  )),
              Container(
                height: appConfig.rW(45),
                width: appConfig.rW(100),
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: provider.books.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(
                          left: appConfig.rWP(5), top: appConfig.rWP(1)),
                      child: SmallCard(
                        onTap: () {
                          provider.setCurrentBook(index).then((value) {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> BookDetails()));
                          });
                        },
                        title: provider.books[index].title,
                        author: provider.books[index].author,
                        image: provider.books[index].image,
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: appConfig.rW(5),
                    top: appConfig.rW(5),
                    right: appConfig.rW(5)),
                child: Row(
                  children: [
                    Text(
                      "Short Stories",
                      style: boldStyle,
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    Text(
                      "View All",
                      style: normalTitle,
                    ),
                  ],
                ),
              ),
              Container(
                height: appConfig.rW(45),
                width: appConfig.rW(100),
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: provider.books.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(
                          left: appConfig.rWP(5), top: appConfig.rWP(1)),
                      child: SmallCard(
                        onTap: () {
                          provider.setCurrentBook(index).then((value) {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> BookDetails()));
                          });
                        },
                        title: provider.books[index].title,
                        author: provider.books[index].author,
                        image: provider.books[index].image,
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: appConfig.rW(5),
                    top: appConfig.rW(5),
                    right: appConfig.rW(5)),
                child: Row(
                  children: [
                    Text(
                      "Categories",
                      style: boldStyle,
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    Text(
                      "View All",
                      style: normalTitle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: appConfig.rW(5),
                    top: appConfig.rW(1),
                    right: appConfig.rW(5)),
                child: Container(
                  height: appConfig.rH(12),
                  width: appConfig.rW(100),
                  child: GridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: appConfig.rHP(1),
                    crossAxisSpacing: appConfig.rWP(2),
                    childAspectRatio: 5.0,
                    children: [
                      CategoryCard(
                        text: "Short Stories",
                        icon: Icons.person,
                      ),
                      CategoryCard(
                        text: "Novels",
                        icon: Icons.book,
                      ),
                      CategoryCard(
                        text: "History",
                        icon: Icons.mail_outline_sharp,
                      ),
                      CategoryCard(
                        text: "Science",
                        icon: Icons.person,
                      )
                    ],
                  ),
                ),
              )
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Container(
              //     height: appConfig.rW(40),
              //     width: appConfig.rW(100),
              //     child: ListView(
              //       scrollDirection: Axis.horizontal,
              //       children: [
              //         Padding(
              //           padding: EdgeInsets.only(
              //             left: appConfig.rW(3),
              //           ),
              //           child: AuthorCard(),
              //         ),
              //         Padding(
              //           padding: EdgeInsets.only(
              //             left: appConfig.rW(3),
              //           ),
              //           child: AuthorCard(),
              //         )
              //       ],
              //     ),
              //   ),
              // )
            ],
          );
        }
      },
    );
  }

  Widget homeTopPart(BuildContext context) {
    return Consumer<LoginProvider>(
      builder: (context, provider, child) {
        return Container(
          alignment: Alignment.bottomCenter,
          height: appConfig.rH(10),
          width: appConfig.rW(100),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(26),
              bottomRight: Radius.circular(26),
            ),
          ),
          child: Container(
            height: appConfig.rH(12),
            width: appConfig.rW(100),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(26),
                bottomRight: Radius.circular(26),
              ),
            ),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: appConfig.rWP(5)),
                  child: InkWell(
                    onTap: () async {
                      openDialog(context);
                    },
                    child: CircleAvatar(
                      backgroundColor: AppColors.primary,
                      radius: appConfig.rW(5),
                      // child: Container(
                      //   alignment: Alignment.center,
                      //   decoration: BoxDecoration(
                      //     shape: BoxShape.circle,
                      //     image: DecorationImage(
                      //         image: NetworkImage(
                      //             "https://res.cloudinary.com/codellaa/image/upload/v1627888215/sample.jpg"),
                      //         fit: BoxFit.cover),
                      //   ),
                      // ),
                    ),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(left: appConfig.rWP(3)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${provider.currentUser?.name}",
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize: 16,
                              fontFamily: "Mulish",
                              fontWeight: FontWeight.w900),
                        ),
                        Text(
                          "${provider.currentLibrary?.name} Library",
                          style: TextStyle(
                              color: AppColors.primaryDark,
                              fontSize: 12,
                              fontFamily: "Mulish",
                              fontWeight: FontWeight.w900),
                        ),
                      ],
                    )),
                Expanded(
                  child: Container(),
                ),
                IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OnboardingMain()));
                    },
                    icon: Icon(Icons.search))
              ],
            ),
          ),
        );
      },
    );
  }

  void openDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: Text(
          'Hi there,',
          style: Theme.of(context).textTheme.headline5,
        ),
        content:
            Text('App still under development. This feature will avail soon'),
        actions: [
          TextButton(
            child: Text('Cancel'),
            onPressed: () async {
              Navigator.pop(context);
            },
          ),
          TextButton(
            child: Text('Logout'),
            onPressed: () async {
              context.read<LoginProvider>().logout();
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }
}
