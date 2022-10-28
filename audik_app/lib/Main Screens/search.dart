import 'dart:ui';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audik_app/Main%20Screens/home.dart';
import 'package:audik_app/Main%20Screens/splash.dart';
import 'package:audik_app/Model/songModel.dart';
import 'package:audik_app/basic%20operations/searchfunction.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../other screens/screenplayingnow.dart';

class ScreenSearch extends StatefulWidget {
  const ScreenSearch({super.key});

  @override
  State<ScreenSearch> createState() => _ScreenSearchState();
}

class _ScreenSearchState extends State<ScreenSearch> {
  final TextEditingController searchController = TextEditingController();
  final box = SongBox.getInstance();
  late List<Songs> dbSongs;
  AssetsAudioPlayer _audioPlayer = AssetsAudioPlayer.withId('0');
  List<Audio> allSongs = [];

  @override
  void initState() {
    // TODO: implement initState
    dbSongs = box.values.toList();

    super.initState();
  }

  late List<Songs> another = List.from(dbSongs);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 21, 21, 21),
      body: SafeArea(
        child: /* child: */ Column(
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
                      "Search",
                      style: GoogleFonts.montserrat(
                          textStyle: const TextStyle(
                              fontSize: 32,
                              color: Colors.white,
                              fontWeight: FontWeight.w700)),
                    ),
                    /* IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.more_vert,
                    color: Colors.grey,
                  )),
                   */
                  ],
                ),
              ),
            ),
            Padding(padding: EdgeInsets.all(15), child: searchbar(context)),
            SizedBox(
              height: 20,
            ),
            Expanded(child: searchHistory())
          ],
        ),
      ),
    );
  }

  searchbar(BuildContext context) {
    return TextFormField(
      onTap: () {
        //showSearch(context: context, delegate: SearchLocation());
      },
      controller: searchController,
      onChanged: (value) => updateList(value),
      decoration: InputDecoration(
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        prefixIcon: Icon(
          Icons.search_outlined,
          color: Colors.white,
        ),
        focusColor: Colors.white,
        hintText: 'Search song, artist, album or playlist',
        hintStyle: GoogleFonts.montserrat(
            textStyle: TextStyle(color: Color.fromARGB(113, 158, 158, 158))),
        filled: true,
        fillColor: Color.fromARGB(146, 50, 50, 50),
      ),
    );
  }

  searchHistory() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: another.length == 0
          ? Center(
              child: Text(
              "No Songs Found",
              style: GoogleFonts.montserrat(
                textStyle: const TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.w500),
              ),
            ))
          : ListView.builder(
              //physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: another.length,
              itemBuilder: ((context, index) {
                return Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: ListTile(
                    onTap: () {
                      _audioPlayer.open(
                          Playlist(audios: allSongs, startIndex: index),
                          showNotification: true,
                          headPhoneStrategy: HeadPhoneStrategy.pauseOnUnplug,
                          loopMode: LoopMode.playlist);
                      setState(() {});
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: ((context) => playingNow()),
                        ),
                      );
                    },
                    leading: QueryArtworkWidget(
                      artworkFit: BoxFit.cover,
                      id: another[index].id!,
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
                        another[index].songname!,
                        style: GoogleFonts.montserrat(
                          textStyle: const TextStyle(
                              fontSize: 13.43,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
    );
  }

  void updateList(String value) {
    setState(() {
      another = dbSongs
          .where((element) =>
              element.songname!.toLowerCase().contains(value.toLowerCase()))
          .toList();
      for (var item in another) {
        allSongs.add(
          Audio.file(
            item.songurl.toString(),
            metas: Metas(
              artist: item.artist,
              title: item.songname,
              id: item.id.toString(),
            ),
          ),
        );
      }

      /* dbSongs
          .where((element) =>
              element.songname!.toLowerCase().contains(value.toLowerCase()))
          .toList(); */
    });
  }
}
