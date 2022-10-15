import 'package:audik_app/Playlist/addplaylist.dart';
import 'package:audik_app/other%20screens/favorite.dart';
import 'package:audik_app/Playlist/playlistscreen.dart';
import 'package:audik_app/other%20screens/screenplayingnow.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marquee/marquee.dart';

class librarySearch extends StatelessWidget {
  const librarySearch({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Container(
          height: 60,
          width: 500,
          color: Color.fromARGB(255, 0, 0, 0),
          child: playingCard()),
      backgroundColor: Color.fromARGB(255, 21, 21, 21),
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
                      "My Library",
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
            SizedBox(
              height: 15,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => ScreenFavorite())));
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Color.fromARGB(255, 0, 0, 0)),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.favorite_border,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Text("Favorite Tracks",
                                style: GoogleFonts.montserrat(
                                  textStyle: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700),
                                )),
                          ],
                        ),

                        /* SizedBox(
                          width: 190,
                        ), */
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                          size: 20,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            GestureDetector(
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: ((context) => addPlaylist()))),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    headings("Playlist"),
                    /*  SizedBox(
                      width: 265,
                    ), */
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                      size: 20,
                    )
                  ],
                ),
              ),
            ),
            play(),
            SizedBox(
              height: 10,
            ),
            headings("Folders"),
            play()
          ],
        ),
      )),
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

  //----------------------------------------Playlist--------------------------------------------------
  play() {
    String hello;
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
      child: SizedBox(
        height: 210,
        child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
            itemBuilder: ((context, index) {
              return playlistCard(context);
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

  //----------------------------------------PlayList Card--------------------------------------------------
  playlistCard(context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: ((context) => ScreenPlaylist())));
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
}

class playingCard extends StatefulWidget {
  const playingCard({super.key});

  @override
  State<playingCard> createState() => _playingCardState();
}

class _playingCardState extends State<playingCard> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: (() {
        Navigator.push(
            context, MaterialPageRoute(builder: ((context) => playingNow())));
      }),
      contentPadding: EdgeInsets.fromLTRB(5, 2, 5, 10),
      leading: Image.asset(
        'assets/Music Brand and App Logo (1).png',
        height: 50,
        width: 50,
      ),
      title: Marquee(
        text: "Working on it - User ",
        style: TextStyle(color: Colors.white),
        blankSpace: 80,
        pauseAfterRound: Duration(seconds: 2),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.skip_previous,
                color: Colors.white,
              )),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.play_arrow,
                color: Colors.white,
              )),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.skip_next,
                color: Colors.white,
              ))
        ],
      ),
    );

    /* Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: ((context) => playingNow())));
        },
        child: Container(
          height: 60,
          width: 400,
          decoration: BoxDecoration(color: Color.fromARGB(255, 0, 0, 0)),
          child: Row(
            children: [
              SizedBox(
                width: 20,
              ),
              Image.asset(
                "assets/Music Brand and App Logo (1).png",
                height: 40,
                width: 40,
              ),
              SizedBox(
                width: 15,
              ),
              Text(
                "Track Playing Now",
                style: GoogleFonts.montserrat(
                  textStyle: const TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.w700),
                ),
              ),
              SizedBox(
                width: 70,
              ),
              Row(
                children: [
                  IconButton(
                      onPressed: (() {}),
                      icon: Icon(
                        Icons.favorite_border,
                        color: Colors.white,
                      )),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.pause,
                        color: Colors.white,
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    ); */
  }
}
