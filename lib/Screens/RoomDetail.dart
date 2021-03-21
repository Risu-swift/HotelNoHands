import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../sharedPrefs.dart';

String stringValue;

class GetUserName extends StatefulWidget {
  _GetUserNameState createState() => new _GetUserNameState();
}

class _GetUserNameState extends State<GetUserName> {
  @override
  Widget build(BuildContext context) {
    //getStringValuesSF().then((v) => v = stringValue);
    stringValue = SharedPrefs().username;
    print(stringValue);
    return new StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Bookings')
            .doc(stringValue)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return new Text("Loading");
          }

          return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 300,
                ),
                Text(snapshot.data["UserMail"] ?? 'null'),
                Text(snapshot.data["Name"] ?? 'null'),
                Text(snapshot.data["Check_In_Date"] ?? 'null'),
                Text(snapshot.data["Check_Out_Date"] ?? 'null')
              ],
            ),
          );
        });
  }
}

Future<String> getStringValuesSF() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //Return String
  stringValue = prefs.getString('StringValue') ?? null;

  return stringValue;
}
