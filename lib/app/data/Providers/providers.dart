//user providers

// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_login/app/data/resources/auth_methods.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'package:flutter_login/app/models/user.dart';

class UserProvider with ChangeNotifier{
  User? _user;
  final AuthMethods _authMethods = AuthMethods();

  User get getUser => _user!;

  Future<void> refreshUser() async {
    User user = await _authMethods.getUserDetails();
    _user = user;
    notifyListeners();
  }

}