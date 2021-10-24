import 'package:book_shelf/models/library.dart';
import 'package:book_shelf/models/member.dart';
import 'package:book_shelf/providers/loginProvider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MembersProvider extends ChangeNotifier {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;
  LoginProvider loginProvider;

  bool loading = false;
  List<Member> memberList = [];

  Future getMembers(BuildContext context) async {
    Library currentLibrary =
        Provider.of<LoginProvider>(context, listen: false).currentLibrary;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var lib = prefs.get('library');
    memberList = [];
    loading = true;
    notifyListeners();
    CollectionReference referance = FirebaseFirestore.instance
        .collection('libraries')
        .doc(lib)
        .collection("members");
    QuerySnapshot snap = await referance.get();
    if (snap.docs.isNotEmpty) {
      snap.docs.forEach((element) {
        Member library = Member.fromMap(element.data());
        memberList.add(library);
      });
    } else {
      print("No Members");
    }
    loading = false;
    notifyListeners();
  }

  Future addMember(
      BuildContext context,
      String name,
      String memberID,
      String phone,
      String age,
      String gender,
      String blood,
      String house,
      String place) async {
    Library currentLibrary =
        Provider.of<LoginProvider>(context, listen: false).currentLibrary;
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
    var library = prefs.get('library');
      CollectionReference reference =
          FirebaseFirestore.instance.collection('libraries');
      DocumentReference lib = reference.doc(library);
      await lib.collection('members').doc(phone).set({
        'name': name,
        'phone': phone,
        'id': memberID,
        'age': age,
        'gender': gender,
        'blood': blood,
        'house': house,
        'place': place
      });
      print("Member added successfully");
    } catch (e) {
      print("Error While adding Member :$e ");
    }
  }
  Future updateMember(
      BuildContext context,
      String name,
      String memberID,
      String phone,
      String age,
      String gender,
      String blood,
      String house,
      String place) async {
    Library currentLibrary =
        Provider.of<LoginProvider>(context, listen: false).currentLibrary;
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
    var library = prefs.get('library');
      CollectionReference reference =
          FirebaseFirestore.instance.collection('libraries');
      DocumentReference lib = reference.doc(library);
      await lib.collection('members').doc(phone).update({
        'name': name,
        'phone': phone,
        'id': memberID,
        'age': age,
        'gender': gender,
        'blood': blood,
        'house': house,
        'place': place
      });
      print("Member updated successfully");
    } catch (e) {
      print("Error While updating Member :$e ");
    }
  }
}
