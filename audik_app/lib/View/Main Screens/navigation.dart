// ignore_for_file: camel_case_types

import 'package:audik_app/Controller/search_controller.dart';
import 'package:audik_app/View/Main%20Screens/search.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import 'home.dart';
import 'library.dart';

class navigationBar extends StatefulWidget {
  const navigationBar({super.key});

  @override
  State<navigationBar> createState() => _navigationBarState();
}

class _navigationBarState extends State<navigationBar> {
  int indexx = 0;

  final screen = [
    homeScreen(),
    ScreenSearch(),
    const librarySearch(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screen[indexx],
      bottomNavigationBar: GetBuilder<SearchController>(
          init: SearchController(),
          builder: (state) {
            return NavigationBarTheme(
              data: const NavigationBarThemeData(
                backgroundColor: Color.fromARGB(255, 0, 0, 0),
              ),
              child: NavigationBar(
                selectedIndex: indexx,
                onDestinationSelected: (indexx) => setState(() {
                  state.getAlbum();
                  this.indexx = indexx;
                }),
                height: 61,
                destinations: const [
                  NavigationDestination(
                    icon: Icon(
                      Icons.home_outlined,
                      color: Colors.white,
                    ),
                    label: '',
                  ),
                  NavigationDestination(
                    icon: Icon(
                      Icons.search_outlined,
                      color: Colors.white,
                    ),
                    label: '',
                  ),
                  NavigationDestination(
                    icon: Icon(
                      Icons.queue_music_outlined,
                      color: Colors.white,
                    ),
                    label: '',
                  )
                ],
              ),
            );
          }),
    );
  }
}
