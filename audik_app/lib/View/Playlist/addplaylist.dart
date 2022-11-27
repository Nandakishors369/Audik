// ignore_for_file: camel_case_types, prefer_final_fields, non_constant_identifier_names, unused_local_variable

import 'package:audik_app/Bloc/bloc/playlist_bloc.dart';
import 'package:audik_app/Model/dbfunctions.dart';
import 'package:audik_app/Model/playlistmodel.dart';
import 'package:audik_app/View/Playlist/playlistscreen.dart';
import 'package:audik_app/View/other%20screens/screenplayingnow.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        child: const Icon(Icons.add),
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
    if (playlist.length == 0) {
      Padding(
        padding: const EdgeInsets.all(15.0),
        child: Align(
          heightFactor: 7.5,
          child: Center(
              child: Text(
            'No Playlist Created',
            style: GoogleFonts.montserrat(
              textStyle: const TextStyle(
                  fontSize: 20,
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontWeight: FontWeight.w500),
            ),
          )),
        ),
      );
    }
    return BlocBuilder<PlaylistBloc, PlaylistState>(
      builder: (context, state) {
        // List<PlaylistSongs> playlist = value.values.toList();

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: state.playylist.length, //playlist.length,
            itemBuilder: ((context, index) {
              if (playlistbox.isEmpty) {
                final controller = state.playylist[index]
                    .playlistname!; //playlist[index].playlistname!;
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
              if (state.playylist.isEmpty) {
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
                              allPlaylistSongs:
                                  state.playylist[index].playlistssongs!,
                              playlistname:
                                  state.playylist[index].playlistname!,
                              playlistindex: index,
                              /* allPlaylistSongs:
                                      playlist[index].playlistssongs!,
                                  playlistindex: index,
                                  playlistname:
                                      playlist[index].playlistname! */
                            )))),
                leading: const Image(
                  image: AssetImage(
                    "assets/Music Brand and App Logo (1).png",
                  ),
                  height: 32,
                  width: 32,
                ),
                title: SingleChildScrollView(
                  child: Text(
                    state.playylist[index].playlistname!,
                    //playlist[index].playlistname.toString(),
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
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.grey,
                        )),
                    IconButton(
                      onPressed: (() {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text("Delete Playlist"),
                              content: const Text("Are You Sure"),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text("Cancel")),
                                TextButton(
                                    onPressed: () {
                                      playlistbox.deleteAt(index);
                                      BlocProvider.of<PlaylistBloc>(context)
                                          .add(PlaylistEvent.started());
                                      Navigator.pop(context);
                                    },
                                    child: const Text("Delete"))
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
      },
    );
  }

  //----------------------------------------ADD PLAYLIST POP UP--------------------------------------------------

  Widget bottomSheet(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          height: 423 * 0.7,
          color: const Color.fromARGB(255, 24, 24, 24),
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
          color: const Color.fromARGB(255, 24, 24, 24),
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
                  textStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500)),
            ),
            const SizedBox(
              height: 20,
            ),
            Form(
              key: formGlobalKey,
              child: TextFormField(
                controller: _textEditingController,
                cursorHeight: 25,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color.fromARGB(199, 255, 255, 255),
                  border: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 0, 0, 0))),
                  hintText: "Enter a name",
                  hintStyle: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                          color: Color.fromARGB(255, 69, 69, 69))),
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
            const SizedBox(
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
            child: const Text("cancel")),
        ElevatedButton(
            onPressed: () {
              final isValid = formGlobalKey.currentState!.validate();
              if (isValid) {
                playlistbox.add(PlaylistSongs(
                    playlistname: _textEditingController.text,
                    playlistssongs: []));
                BlocProvider.of<PlaylistBloc>(context)
                    .add(PlaylistEvent.started());
                Navigator.pop(context);
              }
            },
            child: const Text("Create"))
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
                  textStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500)),
            ),
            const SizedBox(
              height: 20,
            ),
            Form(
              key: formGlobalKey1,
              child: TextFormField(
                controller: controller,
                cursorHeight: 25,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color.fromARGB(199, 255, 255, 255),
                  border: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 0, 0, 0))),
                  hintText: "Enter a name",
                  hintStyle: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                          color: Color.fromARGB(255, 69, 69, 69))),
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
            const SizedBox(
              height: 20,
            ),
            formButtonsedit(context, index)
          ],
        ),
      ),
    );
  }

  Row formButtonsedit(BuildContext context, int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("cancel")),
        ElevatedButton(
            onPressed: () {
              final isValid = formGlobalKey1.currentState!.validate();
              if (isValid) {
                playlistbox.putAt(
                    index,
                    PlaylistSongs(
                        playlistname: controller.text, playlistssongs: []));
                BlocProvider.of<PlaylistBloc>(context)
                    .add(PlaylistEvent.started());
                Navigator.pop(context);
              }
            },
            child: const Text("Create"))
      ],
    );
  }
}
