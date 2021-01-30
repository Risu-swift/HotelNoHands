import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import '../Database.dart';

class AddUser extends StatelessWidget {
  final String fullName;
  final String company;
  final int age;

  AddUser(this.fullName, this.company, this.age);

  @override
  Widget build(BuildContext context) {
    // Create a CollectionReference called users that references the firestore collection
    CollectionReference users =
        FirebaseFirestore.instance.collection('Bookings');

    //DBFunctions db1 = DBFunctions("12355423", "redrizwan007@gmail.com");
    //dynamic data = db1.getData('PDu8DKtoQ5E0pl7GPAGx');

    return Scaffold(
      body: Column(
        children: [
          TextButton(
              //       child: Text("Add Rooms"),
              //       onPressed: () => db1.addUser(),
              ),
          //     Text(data['UserMail']),
        ],
      ),
    );
  }
}
