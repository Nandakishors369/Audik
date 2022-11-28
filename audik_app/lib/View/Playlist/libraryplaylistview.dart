// ignore_for_file: camel_case_types, unused_local_variable, unnecessary_null_comparison

import 'package:audik_app/Bloc/favorite%20and%20playlist/playlist_bloc.dart';
import 'package:audik_app/Model/dbfunctions.dart';
import 'package:audik_app/View/Playlist/playlistscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:marquee/marquee.dart';

import '../../Model/playlistmodel.dart';

class playlistView extends StatefulWidget {
  const playlistView({super.key});

  @override
  State<playlistView> createState() => _playlistViewState();
}

class _playlistViewState extends State<playlistView> {
  // List<PlaylistSongs> playlist = [];
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(10, 5, 0, 0),
        ),
        BlocBuilder<PlaylistBloc, PlaylistState>(
          builder: (context, state) {
            return ValueListenableBuilder<Box<PlaylistSongs>>(
                valueListenable: playlistbox.listenable(),
                builder: (context, value, child) {
                  // List<PlaylistSongs> playlist = value.values.toList();
                  //----------------------------------------If songs are not there--------------------------------------------------
                  if (playlistbox.isEmpty) {
                    return const SizedBox.shrink();
                  }
                  //----------------------------------------If the list is null-----------------------------------------------------
                  if (playlistbox == null) {
                    /* return const Center(
                          child: CircularProgressIndicator(),
                        ); */
                  }

                  //----------------------------------------Showing songs in list tile--------------------------------------------------
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: SizedBox(
                          /*  height: height * 0.224, */
                          height: 220,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.all(19),
                            itemBuilder: ((context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: ((context) => ScreenPlaylist(
                                          allPlaylistSongs: state
                                              .playylist[index].playlistssongs!,
                                          playlistindex: index,
                                          playlistname: state
                                              .playylist[index].playlistname!)),
                                    ),
                                  );
                                },
                                child: Column(
                                  children: [
                                    Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 0, 0, 0),
                                        child: Container(
                                          child: Image.asset(
                                            "assets/Playlist.png",
                                          ),
                                          width: width * 0.306,
                                          height: width * 0.306,
                                          decoration: const BoxDecoration(
                                              gradient: LinearGradient(
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight,
                                                  colors: [
                                                    Color.fromARGB(
                                                        255, 0, 0, 255),
                                                    Color.fromARGB(
                                                        255, 31, 31, 255),
                                                    Color.fromARGB(
                                                        255, 73, 73, 255),
                                                    Color.fromARGB(
                                                        255, 120, 121, 255),
                                                    Color.fromARGB(
                                                        255, 163, 163, 255),
                                                    Color.fromARGB(
                                                        255, 191, 191, 255)
                                                    //
                                                  ]),
                                              color: Colors.green,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10))),
                                        )),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    SizedBox(
                                      height: 18,
                                      width: width * .28,
                                      child: Marquee(
                                        blankSpace: 20,
                                        velocity: 20,
                                        text: state
                                            .playylist[index].playlistname
                                            .toString(),
                                        style: GoogleFonts.montserrat(
                                            textStyle: const TextStyle(
                                                fontSize: 15,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500)),
                                      ),
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
                            itemCount: state.playylist.length,
                          ),
                        ),
                      ),
                    ],
                  );
                });
          },
        ),
      ],
    );
  }

  headings(String name) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 0, 0, 4),
      child: Row(
        children: [
          Text(
            name,
            style: GoogleFonts.montserrat(
                textStyle: const TextStyle(
                    fontSize: 23,
                    color: Colors.white,
                    fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }
}
