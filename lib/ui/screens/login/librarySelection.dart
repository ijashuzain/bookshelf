import 'package:book_shelf/constants/colors.dart';
import 'package:book_shelf/constants/config.dart';
import 'package:book_shelf/constants/styling.dart';
import 'package:book_shelf/providers/loginProvider.dart';
import 'package:book_shelf/ui/screens/login/phoneSelection.dart';
import 'package:book_shelf/ui/widgets/loading_widget.dart';
import 'package:book_shelf/ui/widgets/rounded_button.dart';
import 'package:book_shelf/ui/widgets/shadowedDropDown.dart';
import 'package:book_shelf/ui/widgets/shadowedTextField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class LibrarySelection extends StatefulWidget {
  LibrarySelection({Key key}) : super(key: key);

  @override
  _LibrarySelectionState createState() => _LibrarySelectionState();
}

class _LibrarySelectionState extends State<LibrarySelection> {
  Config _config;
  LoginProvider loginProvider;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (mounted)
        Provider.of<LoginProvider>(context, listen: false).getLibraries();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _config = Config(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<LoginProvider>(
        builder: (context, provider, child) {
          if (provider.libraryLoading) {
            return LoadingWidget();
          } else {
            return Container(
              child: Column(
                children: [
                  _topPart(),
                  Padding(
                    padding: EdgeInsets.all(_config.rWP(10)),
                    child: _middlePart(),
                  ),
                  Padding(
                    padding: EdgeInsets.all(_config.rWP(10)),
                    child: _bottomPart(),
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Widget _topPart() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(_config.rHP(2)),
            child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                )),
          ),
          Padding(
            padding:
                EdgeInsets.only(right: _config.rWP(40), left: _config.rWP(5)),
            child: Container(
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Welcome",
                    style: latestSubtitle,
                    textAlign: TextAlign.left,
                  )),
            ),
          ),
          Padding(
            padding:
                EdgeInsets.only(right: _config.rWP(5), left: _config.rWP(5)),
            child: Container(
              child: Text(
                "The only thing that you absolutely have to know is the location of library",
                style: headStyle,
                textAlign: TextAlign.left,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                right: _config.rWP(40),
                left: _config.rWP(5),
                top: _config.rWP(3)),
            child: Container(
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "- Albert Einstein",
                    style: latestSubtitle,
                    textAlign: TextAlign.left,
                  )),
            ),
          ),
        ],
      ),
    );
  }

  Widget _middlePart() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          child: Column(
        children: [
          Container(
            height: _config.rH(25),
            width: _config.rW(80),
            child: SvgPicture.asset("assets/library.svg"),
          )
        ],
      )),
    );
  }

  Widget _bottomPart() {
    return Consumer<LoginProvider>(
      builder: (context, provider, child) {
        return Container(
          width: _config.rW(100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: _config.rH(3),
              ),
              Text(
                "Select your Library",
                style: boldStyle,
              ),
              SizedBox(
                height: _config.rHP(1),
              ),
              ShadowedDropDown(
                hint: "Select your Library",
                value: provider.currentLibrary != null
                    ? provider.currentLibrary.name
                    : null,
                onChange: (val) {
                  print("$val selected");
                  provider.libraries.forEach(
                    (element) {
                      print(element.name);
                      if (element.name == val) {
                        provider.setLibrary(element.id);
                      }
                    },
                  );
                },
                items: provider.libraries != null
                    ? provider.libraries.map(
                        (item) {
                          return DropdownMenuItem<String>(
                            value: item.name,
                            child: Text(item.name),
                          );
                        },
                      ).toList()
                    : [],
              ),
              SizedBox(
                height: _config.rH(8),
              ),
              Center(
                child: Container(
                  height: 35,
                  child: RoundedButton(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PhoneSelection()));
                    },
                    bgColor: AppColors.primaryDark,
                    title: Text(
                      "Next",
                      style: boldStyle,
                    ),
                    titleColor: Colors.black,
                    borderColor: Colors.transparent,
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
