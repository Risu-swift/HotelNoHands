import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import './LoginScreen.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  User user;
  String uid;
  String uemail;

  _HomeState() {
    this.user = firebaseAuth.currentUser;
    this.uid = user.uid;
    this.uemail = user.email;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Text(uid),
          Text(uemail),
        ],
      ),
    );
  }

  getCurrentUser() async {
    final User user = firebaseAuth.currentUser;
    final uid = user.uid;
    final uemail = user.email;
  }
}
