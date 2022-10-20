import 'package:audik_app/Model/dbfunctions.dart';
import 'package:audik_app/Model/playlistmodel.dart';
import 'package:audik_app/Playlist/playlistscreen.dart';
import 'package:audik_app/other%20screens/screenplayingnow.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import '../Main Screens/library.dart';

class addPlaylist extends StatefulWidget {
  const addPlaylist({super.key});

  @override
  State<addPlaylist> createState() => _addPlaylistState();
}

class _addPlaylistState extends State<addPlaylist> {
  TextEditingController _textEditingController = TextEditingController();
  List<PlaylistSongs> playlist = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: playingCard(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => bottomSheet(context),
          );
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
    return ValueListenableBuilder<Box<PlaylistSongs>>(
        valueListenable: playlistbox.listenable(),
        builder: (context, value, child) {
          List<PlaylistSongs> playlist = value.values.toList();
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: playlist.length,
              itemBuilder: ((context, index) {
                if (playlistbox.isEmpty) {
                  Center(
                    child: Text(
                      "Playlist Not Created",
                      style: GoogleFonts.montserrat(
                        textStyle: const TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  );
                }
                if (playlist.isEmpty) {
                  Center(
                    child: Text(
                      "Playlist Not Created",
                      style: GoogleFonts.montserrat(
                        textStyle: const TextStyle(
                            fontSize: 13.43,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  );
                }
                return ListTile(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => ScreenPlaylist(
                              allPlaylistSongs: playlist[index].playlistssongs!,
                              playlistindex: index,
                              playlistname: playlist[index].playlistname!)))),
                  leading: const Image(
                    image: AssetImage(
                      "assets/Music Brand and App Logo (1).png",
                    ),
                    height: 32,
                    width: 32,
                  ),
                  title: SingleChildScrollView(
                    child: Text(
                      playlist[index].playlistname.toString(),
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
                      playlistbox.deleteAt(index);
                      /* Navigator.push(context,
                      MaterialPageRoute(builder: ((context) => playingNow()))); */
                    }),
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.grey,
                    ),
                  ),
                );
              }),
            ),
          );
        });
  }

  //----------------------------------------ADD PLAYLIST POP UP--------------------------------------------------

  Widget bottomSheet(BuildContext context) {
    return Container(
      height: 423 * 0.7,
      color: Color.fromARGB(255, 24, 24, 24),
      child: Column(
        children: [playlistform(context)],
      ),
    );
  }

  Padding playlistform(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        child: Column(
          children: [
            Text(
              "Create Playlist ",
              style: GoogleFonts.montserrat(
                  textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500)),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: _textEditingController,
              cursorHeight: 25,
              decoration: InputDecoration(
                  hintText: "enter a name",
                  hintStyle: TextStyle(color: Color.fromARGB(255, 72, 72, 72))),
              validator: (value) {
                List<PlaylistSongs> values = playlistbox.values.toList();

                bool isAlreadyAdded = values
                    .where((element) => element.playlistname == value!.trim())
                    .isNotEmpty;

                if (value!.trim() == '') {
                  return 'Name required';
                }

                if (isAlreadyAdded) {
                  return 'Name Already Exists';
                }
                return null;
              },
            ),
            SizedBox(
              height: 20,
            ),
            formButtons(context)
          ],
        ),
      ),
    );
  }

  Row formButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("cancel")),
        ElevatedButton(
            onPressed: () {
              playlistbox.add(PlaylistSongs(
                  playlistname: _textEditingController.text,
                  playlistssongs: []));
              Navigator.pop(context);
            },
            child: Text("Create"))
      ],
    );
  }
}
