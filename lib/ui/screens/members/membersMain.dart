import 'package:book_shelf/constants/colors.dart';
import 'package:book_shelf/constants/config.dart';
import 'package:book_shelf/providers/membersProvider.dart';
import 'package:book_shelf/ui/widgets/normal_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MembersMain extends StatefulWidget {
  MembersMain({Key key}) : super(key: key);

  @override
  _MembersMainState createState() => _MembersMainState();
}

class _MembersMainState extends State<MembersMain> {
  TextEditingController txtName = TextEditingController();
  TextEditingController txtPhone = TextEditingController();
  TextEditingController txtAge = TextEditingController();
  TextEditingController txtBloodGroup = TextEditingController();
  TextEditingController txtGender = TextEditingController();
  TextEditingController txtMemberID = TextEditingController();
  TextEditingController txtHouse = TextEditingController();
  TextEditingController txtPlace = TextEditingController();

  Config _config;
  MembersProvider membersProvider;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      membersProvider = context.read<MembersProvider>();
      context.read<MembersProvider>().getMembers(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    membersProvider = context.read<MembersProvider>();
    _config = Config(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        backgroundColor: AppColors.primaryDark,
        child: Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
                title: Text("Add Member"),
                actions: [
                  TextButton(
                      onPressed: () async {
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
                        Navigator.pop(context);
                        await membersProvider.getMembers(context);
                      },
                      child: Text("Add")),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("Cancel"))
                ],
                content: Container(
                  height: _config.rW(100),
                  width: _config.rW(90),
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
                      )
                    ],
                  ),
                )),
          );
        },
      ),
      body: Consumer<MembersProvider>(
        builder: (context, provider, child) {
          if (provider.loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return memberList();
          }
        },
      ),
    );
  }

  Widget memberList() {
    return Consumer<MembersProvider>(
      builder: (context, provider, child) {
        return ListView.separated(
          physics: BouncingScrollPhysics(),
          separatorBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.only(left: 16, right: 16),
              color: Colors.grey[200],
              height: 0.5,
              width: _config.rW(100),
            );
          },
          itemCount: provider.memberList.length,
          itemBuilder: (context, index) {
            return ListTile(
              onTap: () {
                txtName.clear();
                txtMemberID.clear();
                txtPhone.clear();
                txtAge.clear();
                txtGender.clear();
                txtBloodGroup.clear();
                txtHouse.clear();
                txtPlace.clear();

                txtName.text = provider.memberList[index].name;
                txtMemberID.text = provider.memberList[index].id;
                txtPhone.text = provider.memberList[index].phone;
                txtAge.text = provider.memberList[index].age;
                txtGender.text = provider.memberList[index].gender;
                txtBloodGroup.text = provider.memberList[index].blood;
                txtHouse.text = provider.memberList[index].house;
                txtPlace.text = provider.memberList[index].place;
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                      title: Text("Update Member"),
                      actions: [
                        TextButton(
                            onPressed: () async {
                              await membersProvider.updateMember(
                                  context,
                                  txtName.text,
                                  txtMemberID.text,
                                  txtPhone.text,
                                  txtAge.text,
                                  txtGender.text,
                                  txtBloodGroup.text,
                                  txtHouse.text,
                                  txtPlace.text);
                              Navigator.pop(context);
                              await membersProvider.getMembers(context);
                            },
                            child: Text("Update")),
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("Cancel"))
                      ],
                      content: Container(
                        height: _config.rW(100),
                        width: _config.rW(90),
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
                            )
                          ],
                        ),
                      )),
                );
              },
              leading: CircleAvatar(
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
                backgroundColor: AppColors.primary,
                radius: 30,
              ),
              title: Text("${provider.memberList[index].name}"),
              subtitle: Text("${provider.memberList[index].id}"),
            );
          },
        );
      },
    );
  }
}
