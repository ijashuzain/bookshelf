import 'package:book_shelf/constants/colors.dart';
import 'package:book_shelf/constants/config.dart';
import 'package:book_shelf/constants/styling.dart';
import 'package:book_shelf/providers/membersProvider.dart';
import 'package:book_shelf/ui/widgets/normal_textfield.dart';
import 'package:book_shelf/ui/widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddMemebr extends StatefulWidget {
  AddMemebr({Key key}) : super(key: key);

  @override
  _AddMemebrState createState() => _AddMemebrState();
}

class _AddMemebrState extends State<AddMemebr> {
  TextEditingController txtName = TextEditingController();
  TextEditingController txtPhone = TextEditingController();
  TextEditingController txtAge = TextEditingController();
  TextEditingController txtBloodGroup = TextEditingController();
  TextEditingController txtGender = TextEditingController();
  TextEditingController txtMemberID = TextEditingController();
  TextEditingController txtHouse = TextEditingController();
  TextEditingController txtPlace = TextEditingController();
  MembersProvider membersProvider;
  Config _config;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      membersProvider = context.read<MembersProvider>();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    membersProvider = context.read<MembersProvider>();
    _config = Config(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        centerTitle: true,
        title: Text(
          "Add Memebr",
          style: boldStyle,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(_config.rWP(5)),
        child: Container(
          child: Align(
            alignment: Alignment.center,
            child: ListView(
              children: [
                NormalTextfield(
                  controller: txtName,
                  hint: "Name",
                  icon: Icons.person,
                ),
                NormalTextfield(
                  controller: txtMemberID,
                  hint: "Member ID",
                  icon: Icons.article_sharp,
                ),
                NormalTextfield(
                  controller: txtPhone,
                  icon: Icons.phone,
                  hint: "Phone",
                ),
                NormalTextfield(
                  controller: txtAge,
                  icon: Icons.accessibility,
                  hint: "Age",
                ),
                NormalTextfield(
                  controller: txtGender,
                  icon: Icons.person,
                  hint: "Gender",
                ),
                NormalTextfield(
                  controller: txtBloodGroup,
                  icon: Icons.local_hospital_rounded,
                  hint: "Blood Group",
                ),
                NormalTextfield(
                  controller: txtHouse,
                  icon: Icons.home,
                  hint: "House Name",
                ),
                NormalTextfield(
                  controller: txtPlace,
                  icon: Icons.landscape,
                  hint: "Place",
                ),
                SizedBox(
                  height: _config.rH(5),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RoundedButton(
                      bgColor: AppColors.primary,
                      borderColor: AppColors.primary,
                      onTap: () {
                        Navigator.pop(context);
                      },
                      title: Text(
                        "Cancel",
                        style: smallStyleDark,
                      ),
                    ),
                    RoundedButton(
                      bgColor: AppColors.primary,
                      borderColor: AppColors.primary,
                      onTap: () async {
                        await membersProvider.addMember(
                            context,
                            txtName.text,
                            txtMemberID.text,
                            txtPhone.text,
                            txtAge.text,
                            txtGender.text,
                            txtBloodGroup.text,
                            txtHouse.text,
                            txtPlace.text);
                        await membersProvider.getMembers(context);
                        Navigator.pop(context);
                      },
                      title: Text(
                        "Add",
                        style: smallStyleDark,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
