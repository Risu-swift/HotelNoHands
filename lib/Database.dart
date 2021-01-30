import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class DBFunctions {
  final String encryptId;
  final email;

  DBFunctions(this.encryptId, this.email);

  CollectionReference users = FirebaseFirestore.instance.collection('Bookings');

  Future<void> addUser() {
    // Call the user's CollectionReference to add a new user
    return users
        .add({
          'EncryptID': encryptId, // John Doe
          'UserMail': email, // Stokes and Sons
        })
        .then((value) => print("Booking Successful"))
        .catchError((error) => print("Failed to Book: $error"));
  }

  Future<dynamic> getData(String uemail) async {
    final DocumentReference document =
        FirebaseFirestore.instance.collection("Bookings").doc(uemail);

    await document.get().then<dynamic>((DocumentSnapshot snapshot) async {
      return snapshot;
    });
  }
}
