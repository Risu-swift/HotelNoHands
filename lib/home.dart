import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import './LoginScreen.dart';
import './Screens/MyProfile.dart';
import 'Screens/QRScan.dart';
import 'Screens/Room.dart';
import 'Screens/RoomDetail.dart';
import 'Screens/SearchInns.dart';
import 'Screens/SearhInn.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

final Color primaryColor = Color(0xff2A2A2A);
final Color navBarColor = Color(0xff333333);
final Color secondaryColor = Color(0xff02FDB5);
final Color whiteIcons = Color(0xffEBEBEB);

class _HomeState extends State<Home> {
  User user;
  String uid;
  String uemail;

  _HomeState() {
    this.user = firebaseAuth.currentUser;
    this.uid = user.uid;
    this.uemail = user.email;
  }

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
    MyHomePage(),
    AddUser('Rizwan', 'Blah', 12),
    QRScan(),
    GetUserName(),
    myProfile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: navBarColor,
        unselectedFontSize: 10,
        selectedFontSize: 12,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Search Inns',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.conciergeBell),
            label: 'Room',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.qrcode),
            label: 'QR Scan',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.infoCircle),
            label: 'Room Detail',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.userCircle),
            label: 'My Profile',
          )
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: secondaryColor,
        unselectedItemColor: whiteIcons,
        onTap: _onItemTapped,
      ),
    );
  }
}

getCurrentUser() async {
  final User user = firebaseAuth.currentUser;
  if (user != null) {
    final uid = user.uid;
    final uemail = user.email;
  }
  return user;
}
