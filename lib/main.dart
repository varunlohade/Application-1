import 'package:News_App/constants.dart';
import 'package:News_App/screens/Welcome/welcome_screen.dart';
import 'package:News_App/views/home.dart';
import 'package:connectivity/connectivity.dart';
import 'package:News_App/splashscreen.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'constants.dart';
import 'package:flutter/services.dart';

import 'internet.dart';

void main() {
  runApp(MyApp());
}

final bool debugShowCheckedModeBanner = false;

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'My Application',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.black,
      ),
      home: counter == 0 ? WelcomeScreen() : SplashScreen(),
      routes: <String, WidgetBuilder>{
        // Set routes for using the Navigator.
        '/home': (BuildContext context) => new Home(),
      },
    );
  }
}

class homie extends StatefulWidget {
  @override
  _homieState createState() => _homieState();
}

class _homieState extends State<homie> {
  ConnectivityResult previous;
  @override
  void initState() {
    super.initState();
    try {
      InternetAddress.lookup('google.com').then((result) {
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => imageui(),
          ));
        } else {
          _showdialog();
        }
      }).catchError((error) {
        _showdialog();
      });
    } on SocketException catch (_) {
      // no internet
      _showdialog();
    }
    Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult connresult) {
      if (connresult == ConnectivityResult.none) {
      } else if (previous == ConnectivityResult.none) {
        // internet conn
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => imageui(),
        ));
      }

      previous = connresult;
    });
  }

  void _showdialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.black,
        title: Text(
          'ERROR',
          style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 20,
              fontFamily: 'Poppins',
              color: Colors.white),
        ),
        content: Text("No Internet Detected.",
            style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 17,
                fontFamily: 'PoppinsBold',
                color: Colors.white)),
        actions: <Widget>[
          FlatButton(
            color: Colors.black,
            // method to exit application programitacally
            onPressed: () =>
                SystemChannels.platform.invokeMethod('SystemNavigator.pop'),
            child: Text("Exit"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: Text("Checking Your Internet Connection."),
            ),
          ],
        ),
      ),
    );
  }
}
