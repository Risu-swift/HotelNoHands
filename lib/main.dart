import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import './LoginScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Color primaryColor = Color(0xff2A2A2A);
  Color secondaryColor = Color(0xff02FDB5);
  Color logoWhite = Color(0xffF3F3F3);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          //We take the image from the assets
          Image.asset(
            'assets/splash-image.png',
          ),
          //Texts and Styling of them
          Text(
            'Welcome to Internet-Of-Inns',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 28),
          ),
          SizedBox(height: 20),
          Text(
            'Hassle-Free Hotel Stays with IO-Inns ',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          SizedBox(
            height: 30,
          ),
          //Our MaterialButton which when pressed will take us to a new screen named as
          //LoginScreen
          Container(
              width: 200,
              child: MaterialButton(
                minWidth: 20,
                elevation: 0,
                height: 50,
                onPressed: () => Navigator.push(
                    context, MaterialPageRoute(builder: (_) => LoginScreen())),
                color: secondaryColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Get Started',
                        style: TextStyle(color: Colors.white, fontSize: 25)),
                    Icon(Icons.arrow_forward_ios)
                  ],
                ),
                textColor: Colors.white,
              ))
        ],
      ),
    );
  }
}
