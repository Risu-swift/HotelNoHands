import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class DBFunctions {
  final String encryptId;
  final String email;
  final String name;
  final String chdate;
  final String choutdate;

  DBFunctions(
      this.encryptId, this.email, this.name, this.chdate, this.choutdate);

  CollectionReference users = FirebaseFirestore.instance.collection('Bookings');

  Future<void> addUser() {
    // Call the user's CollectionReference to add a new user
    return users
        .add({
          'EncryptID': encryptId,
          'UserMail': email,
          'Name': name,
          'Check_In_Date': chdate,
          'Check_Out_Date': choutdate,
        })
        .then((value) => print("Booking Successful"))
        .catchError((error) => print("Failed to Book: $error"));
  }

  Future<dynamic> getData(String docId) async {
    final DocumentReference document =
        FirebaseFirestore.instance.collection("Bookings").doc(docId);

    await document.get().then<dynamic>((DocumentSnapshot snapshot) async {
      return snapshot;
    });
  }
}
