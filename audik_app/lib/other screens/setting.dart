import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final OnAudioQuery _audioQuery = OnAudioQuery();
  songName() async {
    List<SongModel> songlisting = await _audioQuery.querySongs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 138, 138, 138),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              favoritesHomeListing(),
              FutureBuilder<List<SongModel>>(
                future: _audioQuery.querySongs(
                  sortType: null,
                  orderType: OrderType.ASC_OR_SMALLER,
                  // uriType: UriType.EXTERNAL,
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
                  return Container(
                    child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: item.data!.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(item.data![index].displayNameWOExt),
                            subtitle: Text("${item.data![index].artist}"),
                            trailing: Icon(Icons.more_vert),
                            leading: QueryArtworkWidget(
                                id: item.data![index].id,
                                type: ArtworkType.AUDIO),
                          );
                        }),
                  );
                }),
              ),
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
      /* onTap: () {
        Navigator.push(
          context,
          /* MaterialPageRoute(
            builder: ((context) => ScreenPlaylist()),
          ), */
        );
      }, */
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
}


/* Column(
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
                      "Settings",
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
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "App Settings",
                style: GoogleFonts.montserrat(
                    textStyle: const TextStyle(
                        fontSize: 32,
                        color: Colors.white,
                        fontWeight: FontWeight.w700)),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Terms And Conditions",
                    style: GoogleFonts.montserrat(
                        textStyle: const TextStyle(
                      fontSize: 20,
                      color: Colors.white, /* fontWeight: FontWeight.w700 */
                    )),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                    size: 20,
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "About Us",
                    style: GoogleFonts.montserrat(
                        textStyle: const TextStyle(
                      fontSize: 20,
                      color: Colors.white, /* fontWeight: FontWeight.w700 */
                    )),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                    size: 20,
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Rate The App",
                    style: GoogleFonts.montserrat(
                        textStyle: const TextStyle(
                      fontSize: 20,
                      color: Colors.white, /* fontWeight: FontWeight.w700 */
                    )),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                    size: 20,
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Share This App",
                    style: GoogleFonts.montserrat(
                        textStyle: const TextStyle(
                      fontSize: 20,
                      color: Colors.white, /* fontWeight: FontWeight.w700 */
                    )),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                    size: 20,
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Notifications",
                    style: GoogleFonts.montserrat(
                        textStyle: const TextStyle(
                      fontSize: 20,
                      color: Colors.white, /* fontWeight: FontWeight.w700 */
                    )),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                    size: 20,
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Equalizer",
                    style: GoogleFonts.montserrat(
                        textStyle: const TextStyle(
                      fontSize: 20,
                      color: Colors.white, /* fontWeight: FontWeight.w500 */
                    )),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                    size: 20,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 410,
            ),
            Text(
              "Version 1.0.1",
              style: GoogleFonts.montserrat(
                  textStyle: const TextStyle(
                fontSize: 15,
                color: Color.fromARGB(62, 255, 255, 255),
              )),
            ),
          ],
        ), */