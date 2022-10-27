import 'dart:ui';

import 'package:audik_app/Main%20Screens/home.dart';
import 'package:audik_app/Model/songModel.dart';
import 'package:audik_app/basic%20operations/searchfunction.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:on_audio_query/on_audio_query.dart';

class ScreenSearch extends StatefulWidget {
  const ScreenSearch({super.key});

  @override
  State<ScreenSearch> createState() => _ScreenSearchState();
}

class _ScreenSearchState extends State<ScreenSearch> {
  final TextEditingController searchController = TextEditingController();

  //List<SongModel> display_list = List.from(main_songs_list);
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
            //Expanded(child: searchHistory())
          ],
        ),
      ),
    );
  }

  searchbar(BuildContext context) {
    return TextFormField(
      onTap: () {
        showSearch(context: context, delegate: SearchLocation());
      },
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
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 10,
        itemBuilder: ((context, index) {
          return ListTile(
            leading: const Image(
              image: AssetImage(
                "assets/Music Brand and App Logo (1).png",
              ),
              height: 32,
              width: 32,
            ),
            title: SingleChildScrollView(
              child: Text(
                "Song Name",
                style: GoogleFonts.montserrat(
                  textStyle: const TextStyle(
                      fontSize: 13.43,
                      color: Colors.white,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
            trailing: IconButton(
              onPressed: (() {}),
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

  void updateList(String) {}
}
