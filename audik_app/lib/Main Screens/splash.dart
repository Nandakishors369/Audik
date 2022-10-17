import 'dart:async';

import 'package:audik_app/Main%20Screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:video_player/video_player.dart';

import 'navigation.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final OnAudioQuery _audioQuery = OnAudioQuery();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    songName() async {
      print("thudangi");
      List<SongModel> songlisting = await _audioQuery.querySongs();
      print("kayinj");
    }

    Timer(Duration(seconds: 3), (() {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => navigationBar()));
    }));
  }
  /* @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), (() {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => navigationBar()));
    }));
  } */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 0, 0),
      body: SafeArea(
          child: Center(
              child: Image.asset(
        'assets/Music Brand and App Logo (1).png',
        width: 320,
        height: 320,
      ))),
    );
  }
}
