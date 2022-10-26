import 'dart:ui';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audik_app/Favorite/addtofavorite.dart';
import 'package:audik_app/Model/dbfunctions.dart';
import 'package:audik_app/Recently%20and%20Mostly/mostlyPlayed.dart';
import 'package:audik_app/Recently%20and%20Mostly/recentlyPlayed.dart';
import 'package:audik_app/Main%20Screens/library.dart';
import 'package:audik_app/Model/songModel.dart';
import 'package:audik_app/Playlist/playlistscreen.dart';
import 'package:audik_app/Playlist/songtoplaylist.dart';
import 'package:audik_app/basic%20operations/favlisting_home.dart';
import 'package:audik_app/other%20screens/setting.dart';
import 'package:audik_app/Main%20Screens/search.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../Model/favoriteModel.dart';
import '../basic operations/allSongsListing.dart';
import '../other screens/screenplayingnow.dart';

class homeScreen extends StatefulWidget {
  const homeScreen({super.key});

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  bool mp = false;

  @override
  void initState() {
    setState(() {});
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      bottomSheet: playingCard(),
      /* Container(
            height: 60,
            width: MediaQuery.of(context).size.width,
            color: Colors.black,
            child: const playingCard()), */
      backgroundColor: const Color.fromARGB(255, 21, 21, 21),
      body: SafeArea(
        child: CupertinoScrollbar(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: height * .096,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 0, 0, 0),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20, 15, 15, 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          welcomeuser(),
                          style: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                                fontSize: width * 0.066,
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            mp = true;
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: ((context) => const SettingScreen()),
                              ),
                            );
                          },
                          icon: const Icon(
                            Icons.more_vert,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                favHome(),
                /* favoritesHomeListing(), */
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      width * 0.05903, 0, 0, height * 0.0094),
                  child: Row(
                    children: [
                      Text(
                        "Your Dashboard",
                        style: GoogleFonts.montserrat(
                          textStyle: const TextStyle(
                              fontSize: 23,
                              color: Colors.white,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                ),
                recentsCard(),
                Padding(
                  padding: EdgeInsets.fromLTRB(width * 0.059, 5, 0, 4),
                  child: Row(
                    children: [
                      Text(
                        "Your Songs",
                        style: GoogleFonts.montserrat(
                          textStyle: const TextStyle(
                              fontSize: 23,
                              color: Colors.white,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                ),
                allSongsScreen(),
                SizedBox(
                    height: 80,
                    width: width,
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        "End of songs...",
                        style: GoogleFonts.notoSansOldItalic(
                            textStyle: TextStyle(color: Colors.grey)),
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  //----------------------------------------FAVORITES-HOME-LIST-------------------------------------------
  favoritesHomeListing() {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.fromLTRB(width * 0.0188, height * 0.0106, 0, 0),
      child: SizedBox(
        /*  height: height * 0.224, */
        height: 200,
        child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.all(10),
            itemBuilder: ((context, index) {
              return GestureDetector(
                onTap: () {
                  /* Navigator.push(
            context,
            MaterialPageRoute(
              builder: ((context) => const ScreenPlaylist()),
            ),
          ); */
                },
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, height * 0.0106, 0, 0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.asset(
                          "assets/Music Brand and App Logo (1).png",
                          width: width * 0.306,
                          height: width * 0.306,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "hello",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                              fontSize: width * 0.0317,
                              color: Colors.white,
                              fontWeight: FontWeight.w500)),
                    )
                  ],
                ),
              );
            }),
            separatorBuilder: ((context, index) {
              return SizedBox(
                width: width * 0.024,
              );
            }),
            itemCount: 10),
      ),
    );
  }

  //----------------------------------------FAVORITE-CARD--------------------------------------------------
  /* favoriteCard() {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        /* Navigator.push(
          context,
          MaterialPageRoute(
            builder: ((context) => const ScreenPlaylist()),
          ),
        ); */
      },
      child: Container(
        height: height * 0.011,
        // width: 132,
        color: const Color.fromARGB(0, 3, 128, 230),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  "assets/Music Brand and App Logo (1).png",
                  width: width * 0.312,
                ),
              ),
            ),
            SizedBox(
              height: height * 0.016,
            ),
            Text(
              "Name here",
              style: GoogleFonts.montserrat(
                  textStyle: const TextStyle(
                      fontSize: 13.43,
                      color: Colors.white,
                      fontWeight: FontWeight.w500)),
            )
          ],
        ),
      ),
    );
  } */

  //----------------------------------------Recents Card--------------------------------------------------
  recentsCard() {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.all(width * 0.035),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => mostlyPlayed(),
                  ));
            },
            child: Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color.fromARGB(255, 0, 0, 255),
                        Color.fromARGB(255, 31, 31, 255),
                        Color.fromARGB(255, 73, 73, 255),
                        Color.fromARGB(255, 120, 121, 255),
                        Color.fromARGB(255, 163, 163, 255),
                        Color.fromARGB(255, 191, 191, 255)
                      ]),
                  color: Colors.green,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              width: width * 0.449,
              height: height * 0.16,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  /*  SizedBox(
                    height: height * .045,
                  ), */
                  Padding(
                    padding: EdgeInsets.fromLTRB(height * 0.0106, 0, 0, 0),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        '''Mostly''',
                        style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                              fontSize: width * 0.065,
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        height * 0.0106, 0, 0, height * 0.016),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        '''Played ''',
                        style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                              fontSize: width * 0.065,
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: width * 0.03,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => recentlyPlayed(),
                  ));
            },
            child: Container(
              width: width * 0.449,
              height: height * 0.16,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color.fromARGB(255, 0, 0, 255),
                        Color.fromARGB(255, 31, 31, 255),
                        Color.fromARGB(255, 73, 73, 255),
                        Color.fromARGB(255, 120, 121, 255),
                        Color.fromARGB(255, 163, 163, 255),
                        Color.fromARGB(255, 191, 191, 255)
                        //
                      ]),
                  color: Colors.green,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  /*  SizedBox(
                    height: height * .045,
                  ), */
                  Padding(
                    padding: EdgeInsets.fromLTRB(height * 0.0106, 0, 0, 0),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        '''Recently''',
                        style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                              fontSize: width * 0.065,
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        height * 0.0106, 0, 0, height * 0.016),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        '''Played ''',
                        style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                              fontSize: width * 0.065,
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String welcomeuser() {
    var hour = DateTime.now().hour;

    if (hour < 12) {
      return 'Good Morning User !';
    }
    if (hour < 16) {
      return 'Good Afternoon User !';
    }
    if (hour < 21) {
      return 'Good Evening User !';
    }
    if (hour < 4) {
      return 'Good Night User !';
    }

    return 'Good Night User !';
  }

  tryCard() {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    if (mp == false) {
      return SizedBox.shrink();
    }
    return Padding(
      padding: EdgeInsets.all(width * 0.035),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => mostlyPlayed(),
                  ));
            },
            child: Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color.fromARGB(255, 0, 0, 255),
                        Color.fromARGB(255, 31, 31, 255),
                        Color.fromARGB(255, 73, 73, 255),
                        Color.fromARGB(255, 120, 121, 255),
                        Color.fromARGB(255, 163, 163, 255),
                        Color.fromARGB(255, 191, 191, 255)
                      ]),
                  color: Colors.green,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              width: width * 0.449,
              height: height * 0.16,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  /*  SizedBox(
                    height: height * .045,
                  ), */
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        height * 0.0106, 0, 0, height * 0.016),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        '''Mostly Played ''',
                        style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                              fontSize: width * 0.065,
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: width * 0.03,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => recentlyPlayed(),
                  ));
            },
            child: Container(
              width: width * 0.449,
              height: height * 0.16,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color.fromARGB(255, 0, 0, 255),
                        Color.fromARGB(255, 31, 31, 255),
                        Color.fromARGB(255, 73, 73, 255),
                        Color.fromARGB(255, 120, 121, 255),
                        Color.fromARGB(255, 163, 163, 255),
                        Color.fromARGB(255, 191, 191, 255)
                        //
                      ]),
                  color: Colors.green,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  /*  SizedBox(
                    height: height * .045,
                  ), */
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        height * 0.0106, 0, 0, height * 0.016),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        '''Recently Played ''',
                        style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                              fontSize: width * 0.065,
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

 




  




//!!!!!!!!!!!!!!!!!! DONT REMOVE !!!!!!!!!!!!!!!!!!//


/*


Future initill() async {
    List<Songs> dbSongs = box.values.toList();

    for (var item in dbSongs) {
      convertAudios.add(Audio.file(item.songurl!,
          metas: Metas(
              title: item.songname,
              artist: item.artist,
              id: item.id.toString())));
    }
  }


 late bool isplaying;
  late bool playerVisibility;
  final box = SongBox.getInstance();
  List<Audio> convertAudios = [];
  final AssetsAudioPlayer _audioPlayer = AssetsAudioPlayer.withId('0');
   //----------------------------------------All Songs Listing From DB--------------------------------------------------
  getAllSongs() {
    return ValueListenableBuilder<Box<Songs>>(
        valueListenable: box.listenable(),
        builder: (context, Box<Songs> allsongbox, child) {
          List<Songs> allDbSongs = allsongbox.values.toList();
          //----------------------------------------If songs are not there--------------------------------------------------
          if (allDbSongs.isEmpty) {
            return Center(child: CircularProgressIndicator());
          }
          //----------------------------------------If the list is null--------------------------------------------------
          if (allDbSongs == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          //----------------------------------------Showing songs in list tile--------------------------------------------------
          return ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: allDbSongs.length,
              itemBuilder: (context, index) {
                Songs songs = allDbSongs[index];
                return Padding(
                  padding: const EdgeInsets.fromLTRB(0, 5, 0, 2),
                  child: ListTile(
                    onTap: (() {
                      print("varunnnn");
                      print(_audioPlayer.getCurrentAudioTitle);
                      print("vnailaaa");
                      _audioPlayer.open(
                          Playlist(audios: convertAudios, startIndex: index),
                          showNotification: true,
                          headPhoneStrategy: HeadPhoneStrategy.pauseOnUnplug,
                          loopMode: LoopMode.playlist);
                      setState(() {
                        playerVisibility = true;
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: ((context) => playingNow()),
                        ),
                      );
                    }),
                    //----------------------------------------Displaying The Song Image--------------------------------------------------
                    leading: QueryArtworkWidget(
                      artworkFit: BoxFit.cover,
                      id: songs.id!,
                      type: ArtworkType.AUDIO,
                      artworkQuality: FilterQuality.high,
                      size: 2000,
                      quality: 100,
                      artworkBorder: BorderRadius.circular(50),
                      nullArtworkWidget: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(50)),
                        child: Image.asset(
                          'assets/Music Brand and App Logo (1).png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    title: SingleChildScrollView(
                      child: Text(
                        songs.songname!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.montserrat(
                          textStyle: const TextStyle(
                              fontSize: 13.43,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    trailing: IconButton(
                      onPressed: (() {
                        showModalBottomSheet(
                          backgroundColor: Colors.black,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(20),
                            ),
                          ),
                          context: context,
                          builder: ((context) {
                            return SizedBox(
                              height: 120,
                              child: Column(
                                children: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: ((context) =>
                                                    const songtoPlaylist())));
                                      },
                                      child: const Text("Add to Playlist")),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  addToFavorite(
                                    index: index,
                                  )
                                  /* TextButton(
                                      onPressed: () {},
                                      child: const Text("Add to Favorites")) */
                                ],
                              ),
                            );
                          }),
                        );
                      }),
                      icon: const Icon(
                        Icons.more_vert,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                );
              });
        });
  } */