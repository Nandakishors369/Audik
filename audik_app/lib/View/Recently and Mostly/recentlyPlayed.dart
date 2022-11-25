// ignore_for_file: file_names, camel_case_types, unused_local_variable, non_constant_identifier_names

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audik_app/Bloc/Recently%20Played/recently_played_bloc.dart';
import 'package:audik_app/View/Favorite/addtofavorite.dart';
import 'package:audik_app/Model/dbfunctions.dart';
import 'package:audik_app/Model/recentlyplayed_model.dart';
import 'package:audik_app/View/Playlist/createPlaylist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../Model/mostlyplayed_model.dart';

class recentlyPlayed extends StatelessWidget {
  recentlyPlayed({super.key});

  AssetsAudioPlayer player = AssetsAudioPlayer.withId("0");

  @override
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
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
                        "Recently Played",
                        style: GoogleFonts.montserrat(
                            textStyle: const TextStyle(
                                fontSize: 32,
                                color: Colors.white,
                                fontWeight: FontWeight.w700)),
                      ),
                    ],
                  ),
                ),
              ),
              Recentlist()
            ],
          ),
        ),
      ),
    );
  }

  Recentlist() {
    return BlocConsumer<RecentlyPlayedBloc, RecentlyPlayedState>(
      listener: (context, state) => recentlyplayedbox,
      builder: (context, state) {
        return ValueListenableBuilder<Box<RecentPlayed>>(
            valueListenable: recentlyplayedbox.listenable(),
            builder: (context, Box<RecentPlayed> recentsongs, _) {
              final height = MediaQuery.of(context).size.height;
              final width = MediaQuery.of(context).size.width;
              List<RecentPlayed> rsongs =
                  recentsongs.values.toList().reversed.toList();

              if (rsongs.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Align(
                    heightFactor: 7.5,
                    child: Center(
                      child: Text(
                        "You haven't played anything ! Try playing something.",
                        style: GoogleFonts.montserrat(
                            textStyle: const TextStyle(color: Colors.white)),
                      ),
                    ),
                  ),
                );
              }
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: rsongs.length,
                  itemBuilder: ((context, index) {
                    List<MostPlayed> allmostplayedsongs =
                        mostplayedsongs.values.toList();
                    MostPlayed msongs = allmostplayedsongs[index];
                    return ListTile(
                      leading: QueryArtworkWidget(
                        artworkFit: BoxFit.cover,
                        id: rsongs[index].id!,
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
                          rsongs[index].songname!,
                          maxLines: 1,
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
                                height: 130,
                                child: Column(
                                  children: [
                                    AddToPlalistbutton(songindex: index),
                                    SizedBox(
                                      height: height * 0.011,
                                    ),
                                    addToFavorite(
                                      index: index,
                                    )
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
            });
      },
    );
  }
}
