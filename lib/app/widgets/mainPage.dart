import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/app/data/Providers/providers.dart';
import 'package:flutter_login/app/data/resources/auth_methods.dart';
import 'package:flutter_login/app/pages/loginPage.dart';
import 'package:flutter_login/app/pages/registrationPage.dart';
import 'package:provider/provider.dart';
import 'package:flutter_login/app/models/user.dart' as model;

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String username = "";

  @override
  void initState(){
    super.initState();
    getUsername();
    // addData();
  }

  // void addData() async {
  //   UserProvider _userProvider = Provider.of(context, listen: false);
  //   await _userProvider.refreshUser();
  // }

  void getUsername() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    setState(() {
      username = (snap.data() as Map<String, dynamic>)['username'];
    });
  }
  
  void signOut() async {
    await AuthMethods().signOut();
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    model.User user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            Container(child: Text('Main screen'),),
            GestureDetector(
              onTap: signOut,
                child: Padding(
                  padding: const EdgeInsets.only(top: 32.0),
                  child: Container(
                    child: Text('Logout', style: TextStyle(color: Colors.black),),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: const ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(4),
                          ),
                        ),
                        color: Colors.white
                    ),
                  ),
                )
            )
          ],
        ),
      ),
    );
  }
}
