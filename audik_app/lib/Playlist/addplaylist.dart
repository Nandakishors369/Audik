import 'package:audik_app/Playlist/playlistscreen.dart';
import 'package:audik_app/other%20screens/screenplayingnow.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

class addPlaylist extends StatefulWidget {
  const addPlaylist({super.key});

  @override
  State<addPlaylist> createState() => _addPlaylistState();
}

class _addPlaylistState extends State<addPlaylist> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          createPlaylist(context);
        },
        child: Icon(Icons.add),
      ),
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
                        "Playlist",
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
              PlaylistList()
            ],
          ),
        ),
      ),
    );
  }

  //----------------------------------------LIST OF PLAYLISTS--------------------------------------------------
  PlaylistList() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 15,
        itemBuilder: ((context, index) {
          return ListTile(
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: ((context) => ScreenPlaylist()))),
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
            trailing: IconButton(
              onPressed: (() {
                Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => playingNow())));
              }),
              icon: const Icon(
                Icons.play_arrow,
                color: Colors.grey,
              ),
            ),
          );
        }),
      ),
    );
  }

  //----------------------------------------ADD PLAYLIST POP UP--------------------------------------------------

  Future createPlaylist(context) async {
    return showDialog(
        context: context,
        builder: ((context) => AlertDialog(
              insetPadding: EdgeInsets.symmetric(vertical: 340),
              backgroundColor: Colors.black,
              content: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                    child: TextFormField(
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        prefixIcon: Icon(
                          Icons.abc,
                          color: Colors.white,
                        ),
                        focusColor: Colors.white,
                        hintText: 'Enter a name for the Playlist',
                        hintStyle: GoogleFonts.montserrat(
                            textStyle: TextStyle(
                                color: Color.fromARGB(113, 158, 158, 158))),
                        filled: true,
                        fillColor: Color.fromARGB(146, 50, 50, 50),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("Create Playlist"))
                ],
              ),
            )));
  }
}
