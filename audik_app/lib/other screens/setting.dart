import 'package:audik_app/Model/dbfunctions.dart';
import 'package:audik_app/Recently%20and%20Mostly/mostlyPlayed.dart';
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
  @override
  Widget build(BuildContext context) {
    final OnAudioQuery _audioQuery = OnAudioQuery();
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 21, 21, 21),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: ScrollPhysics(),
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
                    GestureDetector(
                      onTap: () {
                        mostplayedsongs.clear();
                      },
                      child: Text(
                        "clear mp",
                        style: GoogleFonts.montserrat(
                            textStyle: const TextStyle(
                          fontSize: 20,
                          color: Colors.white, /* fontWeight: FontWeight.w700 */
                        )),
                      ),
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
                    GestureDetector(
                      onTap: () {
                        recentlyplayedbox.clear();
                      },
                      child: Text(
                        "clear rp",
                        style: GoogleFonts.montserrat(
                            textStyle: const TextStyle(
                          fontSize: 20,
                          color: Colors.white, /* fontWeight: FontWeight.w700 */
                        )),
                      ),
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



 





       /*  recentlyplayedbox.clear();
                            mostplayedsongs.clear(); */