import 'package:book_shelf/models/library.dart';
import 'package:book_shelf/models/member.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserData{
  Library currentLibrary;
  Member currentMember;

  Future setData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var lib = prefs.get('library');
    var userphone = prefs.get('userphone');

    try {
      CollectionReference referance =
          FirebaseFirestore.instance.collection('libraries');
      DocumentReference libr = referance.doc(lib);
      DocumentSnapshot memlist =
          await libr.collection('members').doc(userphone).get();
      DocumentSnapshot libSnap = await libr.get();
      currentLibrary = Library.fromMap(libSnap.data());
      if (memlist.exists) {
        currentMember = Member.fromMap(memlist.data());
        print("user data fetched");
      } else {
        print("User getting failed : No User Found");
      }
    } catch (e) {
      print("Error : $e");
    }
  }
}
