import 'package:audik_app/Model/dbfunctions.dart';
import 'package:audik_app/Recently%20and%20Mostly/mostlyPlayed.dart';
import 'package:audik_app/other%20screens/settingPopup.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:switcher_button/switcher_button.dart';

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
                padding: const EdgeInsets.all(0.0),
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
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                    ),
                    title: Text(
                      "Terms And Conditions",
                      style: GoogleFonts.montserrat(
                          textStyle: const TextStyle(
                        fontSize: 20,
                        color: Colors.white, /* fontWeight: FontWeight.w700 */
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
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                    ),
                    title: Text(
                      "Privacy Policy",
                      style: GoogleFonts.montserrat(
                          textStyle: const TextStyle(
                        fontSize: 20,
                        color: Colors.white, /* fontWeight: FontWeight.w700 */
                      )),
                    ),
                  )),
              Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: ListTile(
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                    ),
                    title: Text(
                      "Share The App",
                      style: GoogleFonts.montserrat(
                          textStyle: const TextStyle(
                        fontSize: 20,
                        color: Colors.white, /* fontWeight: FontWeight.w700 */
                      )),
                    ),
                  )),
              Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: ListTile(
                    onTap: () {
                      recentlyplayedbox.clear();
                    },
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                    ),
                    title: Text(
                      "clear rp",
                      style: GoogleFonts.montserrat(
                          textStyle: const TextStyle(
                        fontSize: 20,
                        color: Colors.white, /* fontWeight: FontWeight.w700 */
                      )),
                    ),
                  )),
              Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: ListTile(
                    trailing: SwitcherButton(
                      value: true,
                      size: 27,
                      onChange: (value) {},
                    ),
                    title: Text(
                      "Notifications",
                      style: GoogleFonts.montserrat(
                          textStyle: const TextStyle(
                        fontSize: 20,
                        color: Colors.white, /* fontWeight: FontWeight.w700 */
                      )),
                    ),
                  )),
              Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: ListTile(
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                    ),
                    title: Text(
                      "About",
                      style: GoogleFonts.montserrat(
                          textStyle: const TextStyle(
                        fontSize: 20,
                        color: Colors.white, /* fontWeight: FontWeight.w700 */
                      )),
                    ),
                  )),
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
}
