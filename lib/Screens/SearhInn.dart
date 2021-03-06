import 'package:HotelNoHands/Database.dart';
import 'package:HotelNoHands/LoginScreen.dart';
import '../sharedPrefs.dart';
import '../RoomDatabse.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:random_string/random_string.dart';
import 'dart:math' show Random;
import '../home.dart';
import 'package:shared_preferences/shared_preferences.dart';

Color primaryColor = Color(0xff2A2A2A);
Color secondaryColor = Color(0xff02FDB5);
Color logoWhite = Color(0xffF3F3F3);
String name;
String chdate;
String choutdate;
String uid;
String uemail;
String encryptId;

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 100.0),
        itemBuilder: (BuildContext context, int index) {
          if (index % 2 == 0) {
            return _buildCarousel(context, index ~/ 2);
          } else {
            return Divider();
          }
        },
      ),
    );
  }

  Widget _buildCarousel(BuildContext context, int carouselIndex) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text('Alappuzha',
            textAlign: TextAlign.left,
            style: GoogleFonts.comfortaa(
              fontSize: 30.0,
              color: secondaryColor,
            )),
        SizedBox(
          // you may want to use an aspect ratio here for tablet support
          height: 300.0,
          child: PageView.builder(
            // store this controller in a State to save the carousel scroll position
            controller: PageController(viewportFraction: 0.6),
            itemBuilder: (BuildContext context, int itemIndex) {
              return _buildCarouselItem(context, carouselIndex, itemIndex);
            },
          ),
        )
      ],
    );
  }

  Widget _buildCarouselItem(
      BuildContext context, int carouselIndex, int itemIndex) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 6.0),
      child: RaisedButton(
        onPressed: () => _openPopup(context),
        child: Column(
          children: [
            Expanded(
              child: Image.asset(
                './assets/room.jpg',
              ),
            ),
            Container(
              child: Text('Hotel Ninhao', textAlign: TextAlign.center),
            )
          ],
        ),
      ),
    );
  }

  _openPopup(context) {
    Alert(
        context: context,
        style: AlertStyle(
            titleStyle: TextStyle(color: Colors.white),
            backgroundColor: primaryColor,
            alertBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0),
                side: BorderSide(color: secondaryColor))),
        title: "Book your Inn",
        content: Column(
          children: <Widget>[
            TextField(
              onChanged: (value) {
                name = value;
              },
              decoration: InputDecoration(
                  icon: Icon(
                    Icons.account_circle,
                    color: secondaryColor,
                  ),
                  labelText: 'Name',
                  labelStyle: TextStyle(color: Colors.white)),
            ),
            TextField(
              onChanged: (value) {
                chdate = value;
              },
              obscureText: false,
              decoration: InputDecoration(
                  icon: Icon(
                    Icons.calendar_today,
                    color: secondaryColor,
                  ),
                  labelText: 'Check-In Date',
                  labelStyle: TextStyle(color: Colors.white)),
            ),
            TextField(
              onChanged: (value) {
                choutdate = value;
              },
              obscureText: false,
              decoration: InputDecoration(
                  icon: Icon(
                    Icons.calendar_today,
                    color: secondaryColor,
                  ),
                  labelText: 'Check-Out Date',
                  labelStyle: TextStyle(color: Colors.white)),
            ),
          ],
        ),
        buttons: [
          DialogButton(
            color: secondaryColor,
            onPressed: () => booknow(context),
            child: Text(
              "BOOK NOW",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
  }

  void booknow(context) {
    //bool isUserFound = await getCurrentUser();
    encryptId = randomAlphaNumeric(12).toString();
    encryptId += "md01";
    //dynamic roomdb = DBRoomFunctions();
    //String roomNo = roomdb.checkAvailabilty() ?? null;

    //if (roomNo != null) {
    getCurrentUser().then((isUserCompleter) {
      dynamic db1 = DBFunctions(encryptId, uemail, name, chdate, choutdate);
      db1.addUser();
      SharedPrefs().init();
    });
    print(encryptId);
    SharedPrefs().username = encryptId;
    print(SharedPrefs().username);
    Navigator.pop(context);
    //}
  }

  Future<String> getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    final stringValue = prefs.getString('StringValue') ?? null;

    return stringValue;
  }

  Future<bool> getCurrentUser() async {
    final User user = await FirebaseAuth.instance.currentUser;
    bool isUserComplete = false;
    uid = user.uid;
    uemail = user.email;

    if (uid != null && uemail != null)
      isUserComplete = true;
    else
      isUserComplete = false;
    print(uemail);
    return isUserComplete;
  }

  addStringToSF() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('StringValue', encryptId) ?? null;
  }
}
