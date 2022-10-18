import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audik_app/Main%20Screens/library.dart';
import 'package:audik_app/Model/songModel.dart';
import 'package:audik_app/Playlist/playlistscreen.dart';
import 'package:audik_app/Playlist/songtoplaylist.dart';
import 'package:audik_app/other%20screens/setting.dart';
import 'package:audik_app/Main%20Screens/search.dart';
import 'package:audik_app/basic%20operations/addtofavorites.dart';

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
  late bool isplaying;
  late bool playerVisibility;
  final box = SongBox.getInstance();
  List<Audio> convertAudios = [];
  final AssetsAudioPlayer _audioPlayer = AssetsAudioPlayer.withId('0');

  @override
  void initState() {
    // TODO: implement initState
    List<Songs> dbSongs = box.values.toList();

    for (var item in dbSongs) {
      convertAudios.add(Audio.file(item.songurl!,
          metas: Metas(
              title: item.songname,
              artist: item.artist,
              id: item.id.toString())));
    }
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 90,
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
                        "Hello User",
                        style: GoogleFonts.montserrat(
                          textStyle: const TextStyle(
                              fontSize: 32,
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
                      "Your DashBord",
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
              getAllSongs()
            ],
          ),
        ),
      ),
    );
  }

  //----------------------------------------FAVORITES-HOME-LIST-------------------------------------------
  favoritesHomeListing() {
    String hello;
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 5, 0, 0),
      child: SizedBox(
        height: 210,
        child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.all(10),
            itemBuilder: ((context, index) {
              return favoriteCard();
            }),
            separatorBuilder: ((context, index) {
              return const SizedBox(
                width: 10,
              );
            }),
            itemCount: 8),
      ),
    );
  }

  //----------------------------------------FAVORITE-CARD--------------------------------------------------
  favoriteCard() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: ((context) => const ScreenPlaylist()),
          ),
        );
      },
      child: Container(
        height: 10,
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
                  width: 132,
                ),
              ),
            ),
            const SizedBox(
              height: 15,
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
          Container(
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
          ),
          SizedBox(
            width: width * 0.03,
          ),
          Container(
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
            child: Text(
              '''Recently Played''',
              style: GoogleFonts.montserrat(
                textStyle: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

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
          if (allsongbox == null) {
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
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        const addtoFavorites();
                                      },
                                      child: const Text("Add to Favorites"))
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
  }
}

 




  /* hello() {
    FutureBuilder<List<SongModel>>(
      future: _audioQuery.querySongs(
        sortType: null,
        orderType: OrderType.ASC_OR_SMALLER,
        uriType: UriType.EXTERNAL,
        ignoreCase: true,
      ),
      builder: ((context, item) {
        if (item.data == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (item.data!.isEmpty) {
          return const Center(
            child: Text("No songs Found"),
          );
        }
        return ListView.builder(
            shrinkWrap: true,
            itemCount: 5, //item.data!.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(item.data![index].title),
                subtitle: Text(item.data![index].displayName),
                trailing: Icon(Icons.more_vert),
                leading: QueryArtworkWidget(
                    id: item.data![index].id, type: ArtworkType.AUDIO),
              );
            });
      }),
    );
  }
}
 */ 

/* IconButton(
              onPressed: (() {
                showModalBottomSheet(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
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
                                            songtoPlaylist())));
                              },
                              child: Text("Add to Playlist")),
                          SizedBox(
                            height: 10,
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                addtoFavorites();
                              },
                              child: Text("Add to Favorites"))
                        ],
                      ),
                    );
                  }),
                ); */
