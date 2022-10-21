import 'dart:async';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audik_app/Main%20Screens/home.dart';
import 'package:audik_app/Model/mostlyplayed_model.dart';
import 'package:audik_app/Model/songModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:video_player/video_player.dart';

import '../Model/dbfunctions.dart';
import 'navigation.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

final audioQuery = OnAudioQuery();
final box = SongBox.getInstance();

List<SongModel> fetchSongs = [];
List<SongModel> allSongs = [];
List<Audio> fullsongs = [];

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    requestStoragePermission();
    gotoHome();
    super.initState();
  }

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

  requestStoragePermission() async {
    bool permissionStatus = await audioQuery.permissionsStatus();
    if (!permissionStatus) {
      await audioQuery.permissionsRequest();

      fetchSongs = await audioQuery.querySongs();

      for (var element in fetchSongs) {
        if (element.fileExtension == "mp3") {
          allSongs.add(element);
        }
      }

      for (var element in allSongs) {
        mostplayedsongs.add(
          MostPlayed(
              songname: element.title,
              songurl: element.uri!,
              duration: element.duration!,
              artist: element.artist!,
              count: 0,
              id: element.id),
        );
      }

      allSongs.forEach((element) {
        box.add(Songs(
            songname: element.title,
            artist: element.artist,
            duration: element.duration,
            id: element.id,
            songurl: element.uri));
      });
    }
    setState(() {});
  }

  Future gotoHome() async {
    Timer(Duration(seconds: 5), (() {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => navigationBar()));
    }));
  }
}
