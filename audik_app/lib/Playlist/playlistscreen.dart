import 'package:audik_app/other%20screens/screenplayingnow.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

class ScreenPlaylist extends StatefulWidget {
  const ScreenPlaylist({super.key});

  @override
  State<ScreenPlaylist> createState() => _ScreenPlaylistState();
}

class _ScreenPlaylistState extends State<ScreenPlaylist> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 21, 21, 21),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 370,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 0, 0, 0),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  children: [
                    Image.asset(
                      "assets/Music Brand and App Logo (1).png",
                      height: 280,
                      width: 280,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 15, 15, 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Playlist Name",
                            style: GoogleFonts.montserrat(
                                textStyle: const TextStyle(
                                    fontSize: 32,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700)),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                            child: FloatingActionButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) => playingNow())));
                              },
                              child: Icon(Icons.play_arrow),
                            ),
                          )

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
                  ],
                ),
              ),
              favoriteList()
            ],
          ),
        ),
      ),
    );
  }

  favoriteList() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 15,
        itemBuilder: ((context, index) {
          return ListTile(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: ((context) => playingNow())));
            },
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
              onPressed: (() {
                showModalBottomSheet(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(20))),
                  context: context,
                  builder: ((context) {
                    return SizedBox(
                      height: 120,
                      child: Column(
                        children: [
                          TextButton(
                            onPressed: (() {
                              Navigator.pop(context);
                            }),
                            child: Text("Add to Playlist"),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
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
}
