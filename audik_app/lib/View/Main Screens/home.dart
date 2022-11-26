// ignore_for_file: camel_case_types, prefer_const_constructors, must_be_immutable

import 'package:audik_app/Model/dbfunctions.dart';
import 'package:audik_app/Model/userName.dart';
import 'package:audik_app/View/Recently%20and%20Mostly/mostlyPlayed.dart';
import 'package:audik_app/View/Recently%20and%20Mostly/recentlyPlayed.dart';
import 'package:audik_app/View/Main%20Screens/library.dart';

import 'package:audik_app/View/basic%20operations/favlisting_home.dart';
import 'package:audik_app/View/other%20screens/setting.dart';

import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:hive_flutter/adapters.dart';

import '../basic operations/allSongsListing.dart';

class homeScreen extends StatelessWidget {
  homeScreen({super.key});

  bool mp = false;

  late List<nickName> userName;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return ValueListenableBuilder(
      valueListenable: nameBox.listenable(),
      builder: (context, value, child) {
        userName = nameBox.values.toList();
        return Scaffold(
          bottomSheet: playingCard(),
          backgroundColor: const Color.fromARGB(255, 21, 21, 21),
          body: SafeArea(
            child: CupertinoScrollbar(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: height * .096,
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
                              welcomeuser(),
                              style: GoogleFonts.montserrat(
                                textStyle: TextStyle(
                                    fontSize: width * 0.066,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                mp = true;
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: ((context) =>
                                        const SettingScreen()),
                                  ),
                                );
                              },
                              icon: const Icon(
                                Icons.more_vert,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const favHome(),
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                          width * 0.05903, 0, 0, height * 0.0094),
                      child: Row(
                        children: [
                          Text(
                            "Your Dashboard",
                            style: GoogleFonts.montserrat(
                              textStyle: const TextStyle(
                                  fontSize: 23,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ],
                      ),
                    ),
                    recentsCard(context),
                    Padding(
                      padding: EdgeInsets.fromLTRB(width * 0.059, 5, 0, 4),
                      child: Row(
                        children: [
                          Text(
                            "Your Songs",
                            style: GoogleFonts.montserrat(
                              textStyle: const TextStyle(
                                  fontSize: 23,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ],
                      ),
                    ),
                    allSongsScreen(),
                    SizedBox(
                      height: 80,
                      width: width,
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Text(
                          "End of songs...",
                          style: GoogleFonts.notoSansOldItalic(
                            textStyle: const TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  //----------------------------------------Recents Card--------------------------------------------------
  recentsCard(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.all(width * 0.035),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const mostlyPlayed(),
                ),
              );
            },
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color.fromARGB(255, 0, 0, 255),
                    Color.fromARGB(255, 31, 31, 255),
                    Color.fromARGB(255, 73, 73, 255),
                    Color.fromARGB(255, 120, 121, 255),
                    Color.fromARGB(255, 163, 163, 255),
                    Color.fromARGB(255, 191, 191, 255)
                  ],
                ),
                color: Colors.green,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              width: width * 0.449,
              height: height * 0.16,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(height * 0.0106, 0, 0, 0),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        '''Mostly''',
                        style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                              fontSize: width * 0.065,
                              color: const Color.fromARGB(255, 255, 255, 255),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        height * 0.0106, 0, 0, height * 0.016),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        '''Played ''',
                        style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                              fontSize: width * 0.065,
                              color: const Color.fromARGB(255, 255, 255, 255),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: width * 0.03,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => recentlyPlayed(),
                ),
              );
            },
            child: Container(
              width: width * 0.449,
              height: height * 0.16,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color.fromARGB(255, 0, 0, 255),
                    Color.fromARGB(255, 31, 31, 255),
                    Color.fromARGB(255, 73, 73, 255),
                    Color.fromARGB(255, 120, 121, 255),
                    Color.fromARGB(255, 163, 163, 255),
                    Color.fromARGB(255, 191, 191, 255)
                    //
                  ],
                ),
                color: Colors.green,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(height * 0.0106, 0, 0, 0),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        '''Recently''',
                        style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                              fontSize: width * 0.065,
                              color: const Color.fromARGB(255, 255, 255, 255),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        height * 0.0106, 0, 0, height * 0.016),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        '''Played ''',
                        style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                              fontSize: width * 0.065,
                              color: const Color.fromARGB(255, 255, 255, 255),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String welcomeuser() {
    var hour = DateTime.now().hour;
    String name = userName[0].name!;

    if (hour < 12) {
      return 'Good Morning $name !';
    }
    if (hour < 16) {
      return 'Good Afternoon $name !';
    }
    if (hour < 21) {
      return 'Good Evening $name !';
    }
    if (hour < 4) {
      return 'Good Night $name !';
    }

    return 'Good Night $name !';
  }

  tryCard(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    if (mp == false) {
      return const SizedBox.shrink();
    }
    return Padding(
      padding: EdgeInsets.all(width * 0.035),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const mostlyPlayed(),
                ),
              );
            },
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color.fromARGB(255, 0, 0, 255),
                    Color.fromARGB(255, 31, 31, 255),
                    Color.fromARGB(255, 73, 73, 255),
                    Color.fromARGB(255, 120, 121, 255),
                    Color.fromARGB(255, 163, 163, 255),
                    Color.fromARGB(255, 191, 191, 255)
                  ],
                ),
                color: Colors.green,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              width: width * 0.449,
              height: height * 0.16,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        height * 0.0106, 0, 0, height * 0.016),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        '''Mostly Played ''',
                        style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                              fontSize: width * 0.065,
                              color: const Color.fromARGB(255, 255, 255, 255),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: width * 0.03,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => recentlyPlayed(),
                ),
              );
            },
            child: Container(
              width: width * 0.449,
              height: height * 0.16,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color.fromARGB(255, 0, 0, 255),
                        Color.fromARGB(255, 31, 31, 255),
                        Color.fromARGB(255, 73, 73, 255),
                        Color.fromARGB(255, 120, 121, 255),
                        Color.fromARGB(255, 163, 163, 255),
                        Color.fromARGB(255, 191, 191, 255)
                        //
                      ]),
                  color: Colors.green,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        height * 0.0106, 0, 0, height * 0.016),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        '''Recently Played ''',
                        style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                              fontSize: width * 0.065,
                              color: const Color.fromARGB(255, 255, 255, 255),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
