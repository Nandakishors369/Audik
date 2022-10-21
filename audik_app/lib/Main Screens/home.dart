import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audik_app/Favorite/addtofavorite.dart';
import 'package:audik_app/Model/dbfunctions.dart';
import 'package:audik_app/Recently%20and%20Mostly/mostlyPlayed.dart';
import 'package:audik_app/Recently%20and%20Mostly/recentlyPlayed.dart';
import 'package:audik_app/Main%20Screens/library.dart';
import 'package:audik_app/Model/songModel.dart';
import 'package:audik_app/Playlist/playlistscreen.dart';
import 'package:audik_app/Playlist/songtoplaylist.dart';
import 'package:audik_app/other%20screens/setting.dart';
import 'package:audik_app/Main%20Screens/search.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../basic operations/allSongsListing.dart';
import '../other screens/screenplayingnow.dart';

class homeScreen extends StatefulWidget {
  const homeScreen({super.key});

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      bottomSheet: playingCard(/* index: 0 */),
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
                    padding: const EdgeInsets.fromLTRB(20, 15, 15, 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          welcomeuser(),
                          style: GoogleFonts.montserrat(
                            textStyle: const TextStyle(
                                fontSize: 28,
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
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
                Padding(
                  padding: const EdgeInsets.fromLTRB(25, 20, 0, 0),
                  child: Row(
                    children: [
                      Text(
                        "Your Favorites",
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
                favoritesHomeListing(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(25, 5, 0, 4),
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
                  padding: const EdgeInsets.fromLTRB(25, 5, 0, 4),
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
                allSongsScreen()
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
    String hello;
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 5, 0, 0),
      child: SizedBox(
        height: height * 0.224,
        child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.all(10),
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
            }),
            separatorBuilder: ((context, index) {
              return SizedBox(
                width: width * 0.024,
              );
            }),
            itemCount: 8),
      ),
    );
  }

  //----------------------------------------FAVORITE-CARD--------------------------------------------------
  favoriteCard() {
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
  }

  //----------------------------------------Recents Card--------------------------------------------------
  recentsCard() {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(15.0),
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
                children: [
                  SizedBox(
                    height: height * .065,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '''Mostly Played ''',
                      style: GoogleFonts.montserrat(
                        textStyle: const TextStyle(
                            fontSize: 26,
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontWeight: FontWeight.bold),
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
                children: [
                  SizedBox(
                    height: height * 0.065,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '''Recently Played''',
                      style: GoogleFonts.montserrat(
                        textStyle: const TextStyle(
                            fontSize: 26,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
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

    return 'Good Night User !';
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