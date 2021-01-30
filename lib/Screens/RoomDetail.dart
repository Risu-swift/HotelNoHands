import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GetUserName extends StatefulWidget {
  final String documentId;
  GetUserName(this.documentId);
  _GetUserNameState createState() => new _GetUserNameState();
}

class _GetUserNameState extends State<GetUserName> {
  @override
  Widget build(BuildContext context) {
    CollectionReference users =
        FirebaseFirestore.instance.collection('Bookings');

    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Bookings').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Text('Data is still loading !!');
          return Column(
            children: <Widget>[Text(snapshot.data.docs[0]['UserMail'])],
          );
        },
      ),
    );
  }
}
