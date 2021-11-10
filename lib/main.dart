import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_face_api_beta/face_api.dart' as Regula;
import 'package:updgme_app/helper/pref_manager.dart';
import 'package:updgme_app/networks/api_calls.dart';
import 'package:updgme_app/screens/home.dart';
import 'package:updgme_app/screens/login.dart';
import 'package:updgme_app/screens/punch_attendance.dart';

void main() => runApp(
    new MaterialApp(debugShowCheckedModeBanner: false, home: new MyApp()));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.blue));
    initialize();

  }

  initialize() async {
    ApiCalls.getInstance();
    await PrefManager.getInstance();
    Future.delayed(const Duration(milliseconds: 2000), () {
      if(PrefManager.prefManager==null||PrefManager.prefManager!.getId().isEmpty){
        Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
      }else{
        Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
      }
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Container(
            color: Colors.blue,
            padding: EdgeInsets.fromLTRB(0, 0, 0, 100),
            width: double.infinity,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'assets/logo.png',
                    height: 150,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'जन शक्ति',
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Directorate General of Medical\nEducation and Training U. P.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ])),
      );
}
