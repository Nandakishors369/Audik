import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

class songtoPlaylist extends StatefulWidget {
  const songtoPlaylist({super.key});

  @override
  State<songtoPlaylist> createState() => _songtoPlaylistState();
}

class _songtoPlaylistState extends State<songtoPlaylist> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 21, 21, 21),
      body: SafeArea(
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
                      "Choose Playlist",
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
              height: 20,
            ),
            button(),
            Expanded(child: PlaylistList())
          ],
        ),
      ),
    );
  }

  //----------------------------------------BUTTON TO CREATE PLAYLIST--------------------------------------------------

  Widget button() {
    return ElevatedButton(onPressed: () {}, child: Text("Create"));
  }

  //----------------------------------------CHOOSE PLAYLIST LIST--------------------------------------------------
  PlaylistList() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 5,
        itemBuilder: ((context, index) {
          return ListTile(
            onTap: () {},
            leading: const Image(
              image: AssetImage(
                "assets/Music Brand and App Logo (1).png",
              ),
              height: 32,
              width: 32,
            ),
            title: SingleChildScrollView(
              child: Text(
                "Playlist Name",
                style: GoogleFonts.montserrat(
                  textStyle: const TextStyle(
                      fontSize: 13.43,
                      color: Colors.white,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
