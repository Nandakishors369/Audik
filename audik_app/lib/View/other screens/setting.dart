// ignore_for_file: prefer_final_fields, unused_local_variable, no_leading_underscores_for_local_identifiers

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audik_app/Model/dbfunctions.dart';
import 'package:audik_app/Model/userName.dart';
import 'package:audik_app/View/other%20screens/settingPopup.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:share_plus/share_plus.dart';
import 'package:switcher_button/switcher_button.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

bool musicNotif = true;

class _SettingScreenState extends State<SettingScreen> {
  AssetsAudioPlayer audioPlayer = AssetsAudioPlayer.withId('0');
  TextEditingController _textEditingController = TextEditingController();

  final formGlobalKey = GlobalKey<FormState>();
  late bool notification;
  @override
  Widget build(BuildContext context) {
    bool hello = audioPlayer.showNotification = true;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final OnAudioQuery _audioQuery = OnAudioQuery();
    return ValueListenableBuilder(
        valueListenable: nameBox.listenable(),
        builder: (context, value, child) {
          return Scaffold(
            backgroundColor: const Color.fromARGB(255, 21, 21, 21),
            body: SafeArea(
              child: SingleChildScrollView(
                physics: const ScrollPhysics(),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
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
                    /* Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Text(
                        "",
                        style: GoogleFonts.montserrat(
                            textStyle: const TextStyle(
                                fontSize: 32,
                                color: Colors.white,
                                fontWeight: FontWeight.w700)),
                      ),
                    ),
                    SizedBox(height: 0 //15,
                        ), */
                    Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: ListTile(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (builder) {
                                  return settingmenupopup(
                                      mdFilename: 'termsandconditons.md');
                                });
                          },
                          trailing: const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                          ),
                          title: Text(
                            "Terms And Conditions",
                            style: GoogleFonts.montserrat(
                                textStyle: const TextStyle(
                              fontSize: 20,
                              color: Colors
                                  .white, /* fontWeight: FontWeight.w700 */
                            )),
                          ),
                        )),
                    Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: ListTile(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (builder) {
                                  return settingmenupopup(
                                      mdFilename: 'privacypolicy.md');
                                });
                          },
                          trailing: const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                          ),
                          title: Text(
                            "Privacy Policy",
                            style: GoogleFonts.montserrat(
                                textStyle: const TextStyle(
                              fontSize: 20,
                              color: Colors
                                  .white, /* fontWeight: FontWeight.w700 */
                            )),
                          ),
                        )),
                    Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: ListTile(
                          trailing: const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                          ),
                          title: GestureDetector(
                            onTap: () async {
                              Share.share(
                                  "https://github.com/Nandakishors369/Audik",
                                  subject: "Git Repo Of The App");
                            },
                            child: Text(
                              "Share The App",
                              style: GoogleFonts.montserrat(
                                  textStyle: const TextStyle(
                                fontSize: 20,
                                color: Colors
                                    .white, /* fontWeight: FontWeight.w700 */
                              )),
                            ),
                          ),
                        )),
                    Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: ListTile(
                          onTap: () {
                            //recentlyplayedbox.clear();
                            showModalBottomSheet(
                              context: context,
                              builder: (context) => bottomSheet(context),
                            );
                          },
                          trailing: const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                          ),
                          title: Text(
                            "Nick Name",
                            style: GoogleFonts.montserrat(
                                textStyle: const TextStyle(
                              fontSize: 20,
                              color: Colors
                                  .white, /* fontWeight: FontWeight.w700 */
                            )),
                          ),
                        )),
                    Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: ListTile(
                          trailing: SwitcherButton(
                            value: true,
                            size: 27,
                            onChange: (value) {
                              audioPlayer.showNotification = musicNotif;
                            },
                          ),
                          title: Text(
                            "Notifications",
                            style: GoogleFonts.montserrat(
                                textStyle: const TextStyle(
                              fontSize: 20,
                              color: Colors
                                  .white, /* fontWeight: FontWeight.w700 */
                            )),
                          ),
                        )),
                    Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: ListTile(
                          trailing: const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                          ),
                          title: GestureDetector(
                            onTap: () {
                              aboutPopUp();
                            },
                            child: Text(
                              "About",
                              style: GoogleFonts.montserrat(
                                  textStyle: const TextStyle(
                                fontSize: 20,
                                color: Colors
                                    .white, /* fontWeight: FontWeight.w700 */
                              )),
                            ),
                          ),
                        )),
                    SizedBox(
                      height: height * 0.4356,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        "Version 1.0.1",
                        style: GoogleFonts.montserrat(
                            textStyle: const TextStyle(
                          fontSize: 15,
                          color: Color.fromARGB(62, 255, 255, 255),
                        )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget bottomSheet(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          height: width * 0.7,
          color: const Color.fromARGB(255, 24, 24, 24),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  child: Column(
                    children: [
                      Text(
                        "Enter a nick name ",
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
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 0, 0, 0))),
                            hintText: "Enter a name",
                            hintStyle: GoogleFonts.montserrat(
                                textStyle: const TextStyle(
                                    color: Color.fromARGB(255, 69, 69, 69))),
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Name is required';
                            }
                            if (value.trim().length > 5) {
                              return 'Nick name should be only 5 characters in length';
                            }
                            // Return null if the entered username is valid
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("cancel")),
                          ElevatedButton(
                              onPressed: () {
                                final isValid =
                                    formGlobalKey.currentState!.validate();
                                if (isValid) {
                                  nameBox.put(
                                      0,
                                      nickName(
                                          name: _textEditingController.text));
                                  Navigator.pop(context);
                                }
                              },
                              child: const Text("Ok"))
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  aboutPopUp() {
    showAboutDialog(
        context: context,
        applicationName: "Audik",
        applicationIcon: Image.asset(
          "assets/playlogo.png",
          height: 32,
          width: 32,
        ),
        applicationVersion: "1.0.1",
        children: [
          const Text(
              "Audik is an offline music player app which allows use to hear music from their storage and also do functions like add to favorites , create playlists , recently played , mostly played etc."),
          const SizedBox(
            height: 10,
          ),
          const Text("App developed by Nandakishor S.")
        ]);
  }
}
