// ignore_for_file: prefer_final_fields, prefer_const_constructors_in_immutables, non_constant_identifier_names, must_be_immutable

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audik_app/Controller/search_controller.dart';
import 'package:audik_app/Model/songModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../other screens/screenplayingnow.dart';

final TextEditingController searchController = TextEditingController();
final Sbox = SongBox.getInstance();
List<Songs> SdbSongs = SongBox.getInstance().values.toList();
List<Audio> SallSongs = [];

class ScreenSearch extends StatelessWidget {
  ScreenSearch({super.key});

  AssetsAudioPlayer _audioPlayer = AssetsAudioPlayer.withId('0');

  SearchController getxcontroller = Get.put(SearchController());

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
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: searchbar(context),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: searchHistory(),
            )
          ],
        ),
      ),
    );
  }

  searchbar(BuildContext context) {
    return GetBuilder<SearchController>(
      init: SearchController(),
      initState: (_) {},
      builder: (data) {
        return TextFormField(
          style: GoogleFonts.montserrat(
            textStyle: const TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
            ),
          ),
          onTap: () {},
          controller: searchController,
          onChanged: (value) => data.getSearch(value),
          decoration: InputDecoration(
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            border: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            prefixIcon: const Icon(
              Icons.search_outlined,
              color: Colors.white,
            ),
            focusColor: Colors.white,
            hintText: 'Search song, artist, album or playlist',
            hintStyle: GoogleFonts.montserrat(
              textStyle: const TextStyle(
                color: Color.fromARGB(113, 158, 158, 158),
              ),
            ),
            filled: true,
            fillColor: const Color.fromARGB(146, 50, 50, 50),
          ),
        );
      },
    );
  }

  searchHistory() {
    return GetBuilder<SearchController>(
      init: SearchController(),
      initState: (_) {},
      builder: (searchdata) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: searchdata.another.isEmpty
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
                  shrinkWrap: true,
                  itemCount: searchdata.another.length,
                  itemBuilder: ((context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: ListTile(
                        onTap: () {
                          _audioPlayer.open(
                              Playlist(audios: SallSongs, startIndex: index),
                              showNotification: true,
                              headPhoneStrategy:
                                  HeadPhoneStrategy.pauseOnUnplug,
                              loopMode: LoopMode.playlist);

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: ((context) => playingNow()),
                            ),
                          );
                        },
                        leading: QueryArtworkWidget(
                          artworkFit: BoxFit.cover,
                          id: searchdata.another[index].id!,
                          type: ArtworkType.AUDIO,
                          artworkQuality: FilterQuality.high,
                          size: 2000,
                          quality: 100,
                          artworkBorder: BorderRadius.circular(50),
                          nullArtworkWidget: ClipRRect(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(50),
                            ),
                            child: Image.asset(
                              'assets/Music Brand and App Logo (1).png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        title: SingleChildScrollView(
                          child: Text(
                            searchdata.another[index].songname!,
                            maxLines: 1,
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
      },
    );
  }
}
