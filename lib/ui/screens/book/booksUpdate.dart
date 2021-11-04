import 'dart:io';

import 'package:book_shelf/constants/colors.dart';
import 'package:book_shelf/constants/config.dart';
import 'package:book_shelf/models/book.dart';
import 'package:book_shelf/providers/booksProvider.dart';
import 'package:book_shelf/ui/widgets/bigCard.dart';
import 'package:book_shelf/ui/widgets/loading_widget.dart';
import 'package:book_shelf/ui/widgets/normal_textfield.dart';
import 'package:book_shelf/ui/widgets/reviewField.dart';
import 'package:book_shelf/ui/widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:image_picker/image_picker.dart';

class BooksUpdate extends StatefulWidget {
  final String type;
  BooksUpdate({Key key, this.type}) : super(key: key);

  @override
  _BooksUpdateState createState() => _BooksUpdateState();
}

class _BooksUpdateState extends State<BooksUpdate> {
  Config appConfig;
  BooksProvider booksProvider;
  TextEditingController title = TextEditingController();
  TextEditingController subtitle = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController author = TextEditingController();
  TextEditingController releaseDate = TextEditingController();
  TextEditingController language = TextEditingController();
  TextEditingController quantity = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      booksProvider = context.read<BooksProvider>();
      print("WORKED");
      if (widget.type == "OLD") {

        title.text = booksProvider.currentBook.title;
        subtitle.text = booksProvider.currentBook.subtitle;
        description.text = booksProvider.currentBook.description;
        author.text = booksProvider.currentBook.author;
        releaseDate.text = booksProvider.currentBook.date;
        language.text = booksProvider.currentBook.language;
        quantity.text = booksProvider.currentBook.qty.toString();
      }
    });
    super.initState();
  }

  final picker = ImagePicker();

  getImage(String type) async {
    var pickedFile;
    if (type == "camera") {
      pickedFile = await picker.getImage(source: ImageSource.camera);
    } else {
      pickedFile = await picker.getImage(source: ImageSource.gallery);
    }
    if (pickedFile != null) {
      booksProvider.setPickedImage(File(pickedFile.path));
    } else {
      print('No image selected.');
    }
  }

  @override
  Widget build(BuildContext context) {
    appConfig = Config(context);
    booksProvider = context.read<BooksProvider>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black87),
        title: Text(
          widget.type == "NEW" ? "Add New Book" : "Update Book Details",
          style: TextStyle(color: Colors.black87),
        ),
      ),
      backgroundColor: Colors.white,
      body: Consumer<BooksProvider>(
        builder: (context, provider, child) {
          return Stack(
            children: [
              Container(
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  children: [
                    SizedBox(
                      height: appConfig.rH(5),
                    ),
                    Column(
                      children: [
                        Container(
                          height: appConfig.rW(50),
                          width: appConfig.rW(33),
                          child: widget.type == "NEW"
                              ? Container(
                                  height: appConfig.rW(50),
                                  width: appConfig.rW(33),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color: Colors.grey[300],
                                  ),
                                  child: provider.pickedImage != null
                                      ? Container(
                                          height: appConfig.rW(30),
                                          width: appConfig.rW(20),
                                          decoration: BoxDecoration(
                                              color: AppColors.secondary,
                                              borderRadius: BorderRadius.all(Radius.circular(10)),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.grey[400],
                                                    blurRadius: 5,
                                                    spreadRadius: 2,
                                                    offset: Offset(5, 5))
                                              ]),
                                          child: ClipRRect(
                                              borderRadius: BorderRadius.circular(10),
                                              child: Image.file(
                                                provider.pickedImage,
                                                fit: BoxFit.cover,
                                              )),
                                        )
                                      : Center(
                                          child: IconButton(
                                            onPressed: () {
                                              showModalBottomSheet(
                                                context: context,
                                                builder: (context) {
                                                  return ClipRRect(
                                                    borderRadius: BorderRadius.only(
                                                      topLeft: Radius.circular(20),
                                                      topRight: Radius.circular(20),
                                                    ),
                                                    child: Container(
                                                      color: Colors.white,
                                                      height: appConfig.rH(15),
                                                      width: appConfig.rW(100),
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children: [
                                                          InkWell(
                                                            onTap: () {
                                                              getImage("camera");
                                                              Navigator.pop(context);
                                                            },
                                                            child: Container(
                                                              child: Text("Camera"),
                                                            ),
                                                          ),
                                                          Divider(),
                                                          InkWell(
                                                            onTap: () {
                                                              getImage("gallary");
                                                              Navigator.pop(context);
                                                            },
                                                            child: Container(
                                                              child: Text("Gallery"),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                            icon: Icon(Icons.add_a_photo_rounded),
                                            iconSize: appConfig.rW(10),
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                )
                              : BigCard(
                                  image: '${provider.currentBook.image}',
                                ),
                        ),
                        provider.pickedImage != null
                            ? GestureDetector(
                                onTap: () {
                                  provider.removePickedImage();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    child: Text(
                                      "Reset Image",
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontFamily: "Mulish",
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : Container(),
                        Container(
                            padding: EdgeInsets.only(
                              right: appConfig.rW(5),
                              top: appConfig.rW(5),
                              bottom: appConfig.rW(1),
                            ),
                            child: NormalTextfield(
                              controller: title,
                              hint: "Title",
                            )),
                        Container(
                            padding: EdgeInsets.only(
                              right: appConfig.rW(5),
                              bottom: appConfig.rW(1),
                            ),
                            child: NormalTextfield(
                              controller: subtitle,
                              hint: "Subtitle",
                            )),
                        Container(
                            padding: EdgeInsets.only(
                              left: appConfig.rW(10),
                              right: appConfig.rW(5),
                              bottom: appConfig.rW(1),
                            ),
                            child: ReviewField(
                              controller: description,
                              hint: "Description",
                            )),
                        Container(
                            padding: EdgeInsets.only(
                              right: appConfig.rW(5),
                              bottom: appConfig.rW(1),
                            ),
                            child: NormalTextfield(
                              controller: author,
                              hint: "Author",
                            )),
                        Container(
                            padding: EdgeInsets.only(
                              right: appConfig.rW(5),
                              bottom: appConfig.rW(1),
                            ),
                            child: NormalTextfield(
                              controller: releaseDate,
                              hint: "Release Date",
                            )),
                        Container(
                            padding: EdgeInsets.only(
                              right: appConfig.rW(5),
                              bottom: appConfig.rW(1),
                            ),
                            child: NormalTextfield(
                              controller: language,
                              hint: "Language",
                            )),
                        Container(
                            padding: EdgeInsets.only(
                              right: appConfig.rW(5),
                              bottom: appConfig.rW(1),
                            ),
                            child: NormalTextfield(
                              controller: quantity,
                              hint: "Quantity",
                            )),
                        Container(
                          padding: EdgeInsets.only(
                            right: appConfig.rW(5),
                            top: appConfig.rWP(5),
                            bottom: appConfig.rW(1),
                          ),
                          child: RoundedButton(
                            title: Text(widget.type == "NEW" ? "Create" : "Update"),
                            bgColor: Colors.grey[400],
                            borderColor: Colors.transparent,
                            onTap: () {
                              print(widget.type);
                              Book book = Book(
                                  title: title.text,
                                  subtitle: subtitle.text,
                                  description: description.text,
                                  author: author.text,
                                  date: releaseDate.text,
                                  language: language.text,
                                  qty: int.parse(quantity.text));
                              provider.updateBook(book, widget.type).then((value) {
                                Navigator.pop(context);
                              });
                            },
                            titleColor: Colors.black87,
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        )
                      ],
                    )
                  ],
                ),
              ),
              provider.updatingBook == true || provider.updatingImage == true
                  ? Container(
                      height: appConfig.rH(100),
                      width: appConfig.rW(100),
                      color: Color.fromRGBO(255, 255, 255, 0.5),
                      child: Center(
                        child: LoadingWidget(title: provider.updatingImage ? "Image Uploading" : provider.updatingBook ? "Book Uploading" : "Loading" ,),
                      ),
                    )
                  : Container(),
            ],
          );
        },
      ),
    );
  }
}
