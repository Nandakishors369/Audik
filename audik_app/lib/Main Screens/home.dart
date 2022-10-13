import 'package:audik_app/Main%20Screens/library.dart';
import 'package:audik_app/Playlist/playlistscreen.dart';
import 'package:audik_app/Playlist/songtoplaylist.dart';
import 'package:audik_app/other%20screens/setting.dart';
import 'package:audik_app/Main%20Screens/search.dart';
import 'package:audik_app/basic%20operations/addtofavorites.dart';

import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import '../other screens/screenplayingnow.dart';

class homeScreen extends StatefulWidget {
  const homeScreen({super.key});

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Container(
          height: 60,
          width: MediaQuery.of(context).size.width,
          color: Colors.black,
          child: playingCard()),
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
                              builder: ((context) => SettingScreen()),
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
                      "Mostly Played",
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
              mostlyPlayed(),
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
              allSongs()
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
            builder: ((context) => ScreenPlaylist()),
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

  //----------------------------------------MOSTLY-PLAYED-LIST-------------------------------------------
  mostlyPlayed() {
    String hello;
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 5, 0, 0),
      child: SizedBox(
        height: 210,
        child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.all(10),
            itemBuilder: ((context, index) {
              return mostlyPlayedCard();
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

  //----------------------------------------MOSTLY-PLAYED-CARD--------------------------------------------------
  mostlyPlayedCard() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: ((context) => playingNow()),
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

  //----------------------------------------ALL-SONGS-LISTING--------------------------------------------------

  allSongs() {
    Image leadimage;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 5,
        itemBuilder: ((context, index) {
          return ListTile(
            onTap: (() {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: ((context) => playingNow()),
                ),
              );
            }),
            leading: CircleAvatar(
              backgroundImage:
                  AssetImage("assets/Music Brand and App Logo (1).png"),
            ),
            title: SingleChildScrollView(
              child: Text(
                'working on it',
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
                );
              }),
              icon: const Icon(
                Icons.more_vert,
                color: Colors.grey,
              ),
            ),
          );
        }),
      ),
    );
  }

  String formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');

    final hours = twoDigits(duration.inHours);

    final minutes = twoDigits(duration.inMinutes.remainder(60));

    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return [
      if (duration.inHours > 0) hours,
      minutes,
      seconds,
    ].join(':');
  }
}



  /* void requestStoragePermission() async {
    if (!kIsWeb) {
      bool permissionStatus = await _audioQuery.permissionsStatus();
      if (!permissionStatus) {
        await _audioQuery.permissionsRequest();
      }
      setState(() {});
    }
  }

  hello() {
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