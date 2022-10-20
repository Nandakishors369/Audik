import 'package:audik_app/Main%20Screens/home.dart';
import 'package:audik_app/Main%20Screens/navigation.dart';
import 'package:audik_app/Main%20Screens/splash.dart';
import 'package:audik_app/Model/dbfunctions.dart';
import 'package:audik_app/Model/favoriteModel.dart';
import 'package:audik_app/Model/mostlyplayed_model.dart';
import 'package:audik_app/Model/playlistmodel.dart';
import 'package:audik_app/Model/recentlyplayed_model.dart';
import 'package:audik_app/Model/songModel.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(SongsAdapter());
  await Hive.openBox<Songs>(boxname);

  Hive.registerAdapter(favSongsAdapter());
  opendb_fav();
  runApp(const MyApp());

  Hive.registerAdapter(PlaylistSongsAdapter());
  opendatabase();

  Hive.registerAdapter(MostPlayedAdapter());
  openmostplayeddb();

  Hive.registerAdapter(RecentPlayedAdapter());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Audik',
      home: SplashScreen(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
