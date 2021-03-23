import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class DBRoomFunctions {
  /*final String roomNo;
  final String encryptID;
  final bool isAvailable;

  DBRoomFunctions(this.roomNo, this.isAvailable, this.encryptID);
*/
  CollectionReference rooms = FirebaseFirestore.instance.collection('Rooms');

  Future<void> updateRoomUser(
      String roomNo, bool isAvailable, String encryptID) {
    // Call the user's CollectionReference to add a new user
    return rooms
        .doc(roomNo)
        .set({
          'Availability': isAvailable,
          'EncryptID': encryptID,
        })
        .then((value) => print("Room Details updated Successful"))
        .catchError((error) => print("Failed to Update: $error"));
  }

  Future<dynamic> getRoomData(String docId) async {
    final DocumentReference document =
        FirebaseFirestore.instance.collection("Rooms").doc(docId);

    await document.get().then<dynamic>((DocumentSnapshot snapshot) async {
      return snapshot;
    });
  }

  Future<dynamic> checkAvailableRooms() async {
    final CollectionReference document =
        FirebaseFirestore.instance.collection("Rooms");

    await document.get().then((QuerySnapshot querySnapshot) => {
          querySnapshot.docs.forEach((docs) {
            if (docs.get("Availability")) {
              return docs.get("Availability");
            }
          })
        });
  }
}
