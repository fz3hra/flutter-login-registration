import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/app/models/user.dart' as model;

class AuthMethods{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot snap = await _firestore.collection('users').doc(currentUser.uid).get();
    return model.User.fromSnap(snap);
}

//  sign up user

Future<String> signUpUser({
  required String email,
  required String password,
  required String username,
  required String bio,
  // required Uint8List file
}) async {
    String res = "some error occured";
    try {
      if(email.isNotEmpty || password.isNotEmpty || username.isNotEmpty || bio.isNotEmpty)
        {
          // create user for user authentication in fire authentication
          UserCredential cred = await _auth.createUserWithEmailAndPassword(email: email, password: password);

          print(cred.user!.uid);
        //  add user to database
          model.User user = model.User(
              username: username,
              uid: cred.user!.uid,
              email: email,
              bio: bio,
              followers: [],
              following: []
          );

          await _firestore.collection('users').doc(cred.user!.uid).set(user.toJson());

          res = "success";
        }
    } catch(err){
      res = err.toString();
    }
    return res;
  }

//  login user
Future<String> signInUser({
  required String email,
  required String password
}) async {
  String res = "some error occured";
  try {
    if(email.isNotEmpty || password.isNotEmpty)
      {
       await _auth.signInWithEmailAndPassword(email: email, password: password);
       res="success";
      }
    else {
      res = "Please enter all the fields";
    }
  }catch(err){
    res = err.toString();
  }
  return res;
}

//sign out function
Future<void> signOut() async {
    await _auth.signOut();
}
}