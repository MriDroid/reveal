import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:permission_handler/permission_handler.dart';

// Screens
import './cam_screen.dart';
import './welcome_screen.dart';

class Permissions extends StatefulWidget {
  @override
  _PermissionState createState() => _PermissionState();
}

class _PermissionState extends State<Permissions> {
  startTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? firstTime = prefs.getBool("first_time");
    var _duration = new Duration(seconds: 1);

    if (firstTime != null && !firstTime) {
      //not the first time
      return new Timer(_duration, homePage);
    } else {
      //first time
      // prefs.setBool("first_time", false);
      askForPermissions();
      return new Timer(_duration, welpage);
    }
  }

  Future askForPermissions() async {
    await Permission.microphone.request();
  }

  void homePage() {
    Navigator.of(context).pushReplacementNamed(CamScreen.routeName);
  }

  void welpage() {
    Navigator.of(context).pushReplacementNamed(WelcomeScreen.routeName);
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.black,
    );
  }
}
