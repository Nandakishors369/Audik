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
  TextEditingController controller = TextEditingController();
  final formGlobalKey = GlobalKey<FormState>();
  final formGlobalKey1 = GlobalKey<FormState>();

  List<PlaylistSongs> playlist = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) =>
                                  bottomSheetedit(context, index),
                            );
                          },
                          icon: Icon(
                            Icons.edit,
                            color: Colors.grey,
                          )),
                      IconButton(
                        onPressed: (() {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text("Delete Playlist"),
                                content: Text("Are You Sure"),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text("Cancel")),
                                  TextButton(
                                      onPressed: () {
                                        playlistbox.deleteAt(index);
                                        Navigator.pop(context);
                                      },
                                      child: Text("Delete"))
                                ],
                              );
                            },
                          );
                        }),
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          );
        });
  }

  //----------------------------------------ADD PLAYLIST POP UP--------------------------------------------------

  Widget bottomSheet(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          height: 423 * 0.7,
          color: Color.fromARGB(255, 24, 24, 24),
          child: Column(
            children: [playlistform(context)],
          ),
        ),
      ),
    );
  }

  Widget bottomSheetedit(BuildContext context, int index) {
    return SingleChildScrollView(
      child: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          height: 423 * 0.7,
          color: Color.fromARGB(255, 24, 24, 24),
          child: Column(
            children: [editBottom(context, index)],
          ),
        ),
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
            Form(
              key: formGlobalKey,
              child: TextFormField(
                controller: _textEditingController,
                cursorHeight: 25,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color.fromARGB(199, 255, 255, 255),
                  border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 0, 0, 0))),
                  hintText: "Enter a name",
                  hintStyle: GoogleFonts.montserrat(
                      textStyle:
                          TextStyle(color: Color.fromARGB(255, 69, 69, 69))),
                ),
                validator: (value) {
                  List<PlaylistSongs> values = playlistbox.values.toList();

                  bool isAlreadyAdded = values
                      .where((element) => element.playlistname == value!.trim())
                      .isNotEmpty;

                  if (value!.trim() == '') {
                    return 'Name required';
                  }
                  if (value.trim().length > 10) {
                    return 'Enter Characters below 10 ';
                  }

                  if (isAlreadyAdded) {
                    return 'Name Already Exists';
                  }
                  return null;
                },
              ),
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
              final isValid = formGlobalKey.currentState!.validate();
              if (isValid) {
                playlistbox.add(PlaylistSongs(
                    playlistname: _textEditingController.text,
                    playlistssongs: []));
                Navigator.pop(context);
              }
            },
            child: Text("Create"))
      ],
    );
  }

  Widget editBottom(BuildContext context, int index) {
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        child: Column(
          children: [
            Text(
              "Edit Playlist ",
              style: GoogleFonts.montserrat(
                  textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500)),
            ),
            SizedBox(
              height: 20,
            ),
            Form(
              key: formGlobalKey1,
              child: TextFormField(
                controller: controller,
                cursorHeight: 25,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Color.fromARGB(199, 255, 255, 255),
                  border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 0, 0, 0))),
                  hintText: "Enter a name",
                  hintStyle: GoogleFonts.montserrat(
                      textStyle:
                          TextStyle(color: Color.fromARGB(255, 69, 69, 69))),
                ),
                validator: (value) {
                  List<PlaylistSongs> values = playlistbox.values.toList();

                  bool isAlreadyAdded = values
                      .where((element) => element.playlistname == value!.trim())
                      .isNotEmpty;

                  if (value!.trim() == '') {
                    return 'Name Required';
                  }
                  if (value.trim().length > 10) {
                    return 'Enter Characters below 10 ';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            formButtonsedit(context, index)
          ],
        ),
      ),
    ); /* Padding(
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 10),
      child: Container(
        height: width * .7,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
          color: Color.fromARGB(255, 23, 23, 24),
        ),
        child: TextFormField(
          autofocus: true,
          controller: controller,
          cursorHeight: 25,
          decoration: InputDecoration(
            hintText: 'Playlist name',
            //hintStyle: text18,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide.none),
            fillColor: Colors.white,
            filled: true,
          ),
          validator: (value) {
            List<PlaylistSongs> values = playlistbox.values.toList();

            bool isAlreadyAdded = values
                .where((element) => element.playlistname == value!.trim())
                .isNotEmpty;

            if (value!.trim() == '') {
              return 'Name Required';
            }
            if (isAlreadyAdded) {
              return 'This Name Already Exist';
            }
            return null;
          },
        ),
      ),
    ); */
  }

  Row formButtonsedit(BuildContext context, int index) {
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
              final isValid = formGlobalKey1.currentState!.validate();
              if (isValid) {
                playlistbox.putAt(
                    index,
                    PlaylistSongs(
                        playlistname: controller.text, playlistssongs: []));
                Navigator.pop(context);
              }
            },
            child: Text("Create"))
      ],
    );
  }
}
