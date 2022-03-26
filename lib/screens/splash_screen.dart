// @dart=2.9
import 'dart:async';

import 'package:cryptocurrency/services/data_connection_check.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'package:splashscreen/splashscreen.dart';

class SplashScreenClass extends StatefulWidget {
  const SplashScreenClass({Key key}) : super(key: key);

  @override
  _SplashScreenClassState createState() => _SplashScreenClassState();
}

class _SplashScreenClassState extends State<SplashScreenClass> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
        seconds:3,
        navigateAfterSeconds:HomeScreen(),
        title:Text('Welcome',style: TextStyle(color: Colors.black,fontSize:38,fontWeight: FontWeight.bold),),
        image:  Image.asset('assets/images/btc.png'),
        styleTextUnderTheLoader:  TextStyle(),
        photoSize: 100.0,
        loaderColor: Colors.black,
        gradientBackground: LinearGradient(
          end: Alignment.bottomCenter,
          begin: Alignment.topCenter,
          colors: [ Color(0xFFEE3455),
            Color(0xFFE26685),]
        ),
    );
  }
}
