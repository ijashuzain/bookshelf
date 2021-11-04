import 'package:book_shelf/models/library.dart';
import 'package:book_shelf/services/authentication_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:book_shelf/models/member.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginProvider extends ChangeNotifier {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;
  String _verificationId;
  bool codeSent = false;
  bool sendOTP = false;
  bool logingIn = false;
  bool timeOut = false;
  bool userLoading = false;
  bool verifying = false;
  bool sendingotp = false;
  List<Library> libraries = [];
  Member member = Member();
  Member currentUser = Member();
  List<Member> members = [];
  bool libraryLoading = false;
  Library currentLibrary;
  String phonenumber;

  Future<bool> verifyMembership(String phone) async {
    verifying = true;
    members = [];
    notifyListeners();
    CollectionReference referance =
        FirebaseFirestore.instance.collection('libraries');
    DocumentReference lib = referance.doc(currentLibrary.id);
    // DocumentSnapshot memlist = await lib.collection('members').doc(phone).get();
    QuerySnapshot memlist = await lib.collection('members').get();
    memlist.docs.forEach((element) {
      Member mem = Member.fromMap(element.data());
      members.add(mem);
    });
    verifying = false;
    notifyListeners();

    if (members.isNotEmpty) {
      final index = members.indexWhere((element) => element.phone == phone);
      if (index >= 0) {
        member = members.elementAt(index);
        notifyListeners();
        return true;
      } else {
        print("User not found");
        return false;
      }
    } else {
      print("No data");
      print("Current Library : ${currentLibrary.id}");
      return false;
    }
  }

  Future setLibrary(String id) {
    libraries.forEach((element) {
      if (id == element.id) {
        currentLibrary = element;
        notifyListeners();
      }
    });
    print("Library : ${currentLibrary.id}");
  }

  Future getLibraries() async {
    libraryLoading = true;
    notifyListeners();
    libraries = [];
    CollectionReference referance =
        FirebaseFirestore.instance.collection('libraries');
    QuerySnapshot snap = await referance.get();
    if (snap.docs.isNotEmpty) {
      snap.docs.forEach((element) {
        Library library = Library.fromMap(element.data());
        libraries.add(library);
      });
    }
    libraryLoading = false;
    notifyListeners();
  }

  Future<String> verify(String phoneNumber) async {
    phonenumber = phoneNumber;
    sendingotp = true;
    codeSent = false;
    timeOut = false;
    sendOTP = true;
    notifyListeners();
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          var result = await AuthenticationService(_auth).logIn(credential);
          if (result == "SUCCESS") {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString('library', currentLibrary.id);
            prefs.setString('userphone', member.phone);
            var logged = await loggedInBefore(phoneNumber);
            if (logged) {
              print("User already registered");
              getUserData();
            } else {
              print("No registered");
              await addUser();
            }
          }
          sendingotp = false;
          sendOTP = false;
          notifyListeners();
          return "SUCCESS";
        },
        verificationFailed: (FirebaseAuthException e) {
          sendOTP = false;
          notifyListeners();
        },
        codeSent: (String verificationId, int resendToken) {
          _verificationId = verificationId;
          codeSent = true;
          notifyListeners();
          print("Code Send");
          return "CODESENT";
        },
        codeAutoRetrievalTimeout: (String time) {
          sendOTP = false;
          timeOut = true;
          print("timeOut");
          notifyListeners();
          return "TIMEOUT";
        },
      );
      return "CODESENT";
    } catch (e) {
      sendingotp = false;
      sendOTP = false;
      notifyListeners();
      return e.code;
    }
  }

  Future addUser() async {
    print("trying to register");
    try {
      CollectionReference reference =
          FirebaseFirestore.instance.collection('libraries');
      DocumentReference lib = reference.doc(currentLibrary.id);
      await lib
          .collection('members')
          .doc(member.phone)
          .update({'registered': true});
      print("registered successfully");
    } catch (e) {
      print("Error While adding user :$e ");
    }
    await getUserData();
    notifyListeners();
  }

  Future<bool> loggedInBefore(String phone) async {
    CollectionReference reference =
        FirebaseFirestore.instance.collection('libraries');
    DocumentReference lib = reference.doc(currentLibrary.id);
    DocumentSnapshot curUser = await lib.collection('members').doc(phone).get();
    if (curUser.exists) {
      if (curUser.data()['registered'] == true) {
        currentUser = Member.fromMap(curUser.data());
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  Future getUserData() async {
    userLoading = true;
    notifyListeners();
    print("trying to get user data");
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final library = prefs.getString('library');
      final userPhone = prefs.getString('userphone');
      print("Shared Pref Library : $library");
      print("Shared Pref Phone : $userPhone");
      CollectionReference referance =
          FirebaseFirestore.instance.collection('libraries');
      DocumentReference lib = referance.doc(library);
      DocumentSnapshot memlist =
          await lib.collection('members').doc(userPhone).get();
      DocumentSnapshot libr = await lib.get();
      currentLibrary = Library.fromMap(libr.data());
      notifyListeners();
      if (memlist.exists) {
        currentUser = Member.fromMap(memlist.data());
        notifyListeners();
        print("user data fetched");
      } else {
        print("User getting failed : No User Found");
      }
    } catch (e) {
      userLoading = false;
      notifyListeners();
      print("Error While getting user data : $e");
    }
    userLoading = false;
    notifyListeners();
  }

  Future<String> login(String smsCode, String phone) async {
    print(smsCode);
    print(phone);
    logingIn = true;
    notifyListeners();
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: _verificationId, smsCode: smsCode);
      var result = await AuthenticationService(_auth).logIn(credential);
      if (result == "SUCCESS") {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('library', currentLibrary.id);
        prefs.setString('userphone', member.phone);
        var gg = prefs.get('library');
        print("gg : $gg");
        var logged = await loggedInBefore(phone);
        if (logged) {
          print("User already registereeeeed");
        } else {
          print("User not registereeeeeed");
          await addUser();
        }
      }
      logingIn = false;
      notifyListeners();
      return result;
    } catch (e) {
      logingIn = true;
      notifyListeners();
      return e.toString();
    }
  }

  Future logout() async {
    codeSent = false;
    notifyListeners();
    try {
      await AuthenticationService(_auth).signOut();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.clear();
      print("Prefs : ${prefs.get('library')}");
    } catch (e) {
      print(e.code.toString());
    }
  }

  loadingChange() {
    sendOTP = false;
    logingIn = false;
    codeSent = false;
    notifyListeners();
  }
}
