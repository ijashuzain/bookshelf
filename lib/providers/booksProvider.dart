import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as FS;
import 'package:book_shelf/models/book.dart';
import 'package:book_shelf/providers/loginProvider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BooksProvider extends ChangeNotifier {
  LoginProvider loginProvider = LoginProvider();
  bool loadingBooks = false;
  List<Book> books = [];
  Book currentBook;
  File pickedImage;
  bool updatingBook = false;
  bool updatingImage = false;

  Future getAllBooks() async {
    books = [];
    loadingBooks = true;
    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final library = prefs.getString('library');
    CollectionReference referance =
        FirebaseFirestore.instance.collection('libraries');
    DocumentReference docsnap = referance.doc(library);
    QuerySnapshot booksnap = await docsnap.collection('books').get();
    if (booksnap.docs.isNotEmpty) {
      booksnap.docs.forEach((element) {
        Book book = Book.fromMap(element.data());
        books.add(book);
      });
    } else {
      print("There are No Books Available");
    }
    print("book : ${books}");
    loadingBooks = false;
    notifyListeners();
  }

  setPickedImage(File image){
    pickedImage = image;
    notifyListeners();
  }

  removePickedImage(){
    pickedImage = null;
    print("Picked Image : $pickedImage");
    notifyListeners();
  }

  setUpdatingBook(bool val){
    updatingBook = val;
    notifyListeners();
  }
  setUpdatingImage(bool val){
    updatingImage = val;
    notifyListeners();
  }

  Future<String> uploadImage() async {
    setUpdatingImage(true);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final library = prefs.getString('library');
    String returnURL = '';
    if(pickedImage != null){
      FS.Reference storageReference = FS.FirebaseStorage.instance
          .ref().child('$library/books/${DateTime.now().toString()}');
      FS.UploadTask uploadTask = storageReference.putFile(pickedImage);
      await uploadTask.whenComplete(() async {
        print("Image Uploaded");
      });
      await storageReference.getDownloadURL().then((fileURL) {
        returnURL =  fileURL;
      });
    }
    setUpdatingImage(false);
    return returnURL;
  }

  Future updateBook(Book book, String type) async {
    print("type : $type");
    setUpdatingBook(true);
    if(pickedImage != null ){
      book.image = await uploadImage();
    }
    if(type == "OLD"){
      book.id = currentBook.id;
      book.image = currentBook.image;
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final library = prefs.getString('library');
    CollectionReference referance =
        FirebaseFirestore.instance.collection('libraries');
    DocumentReference docsnap = referance.doc(library);
    CollectionReference booksRef = docsnap.collection('books');
    DocumentReference bookDoc;
    if (type == "NEW") {
      bookDoc = booksRef.doc();
      book.id = bookDoc.id;
    } else {
      bookDoc = booksRef.doc(currentBook.id);
    }
    print("${book.id}");
    print("${bookDoc.id}");
    await bookDoc.set(book.toMap());
    await getAllBooks();
    setUpdatingBook(false);
  }

  Future setCurrentBook(int index) async {
    currentBook = books[index];
    notifyListeners();
  }
}
