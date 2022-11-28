//import 'package:audik_app/Bloc/AllSongs/all_songs_bloc_bloc.dart';

import 'package:audik_app/Bloc/Recently%20Played/recently_played_bloc.dart';

import 'package:audik_app/Bloc/favorite%20and%20playlist/favorites_bloc.dart';
import 'package:audik_app/Bloc/now%20playing/now_playing_bloc.dart';
import 'package:audik_app/View/Main%20Screens/splash.dart';
import 'package:audik_app/Model/dbfunctions.dart';
import 'package:audik_app/Model/favoriteModel.dart';
import 'package:audik_app/Model/mostlyplayed_model.dart';
import 'package:audik_app/Model/playlistmodel.dart';
import 'package:audik_app/Model/recentlyplayed_model.dart';
import 'package:audik_app/Model/songModel.dart';
import 'package:audik_app/Model/userName.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';

import 'Bloc/All Songs/allsongs_bloc.dart';
import 'Bloc/favorite and playlist/playlist_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Hive.initFlutter();

  Hive.registerAdapter(SongsAdapter());
  await Hive.openBox<Songs>(boxname);

  Hive.registerAdapter(favSongsAdapter());
  opendb_fav();
  runApp(const MyApp());

  Hive.registerAdapter(PlaylistSongsAdapter());
  opendatabase();

  Hive.registerAdapter(nickNameAdapter());
  openname();

  Hive.registerAdapter(MostPlayedAdapter());
  openmostplayeddb();

  Hive.registerAdapter(RecentPlayedAdapter());

  openrecentlyplayedDb();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AllsongsBloc>(
          create: (context) => AllsongsBloc(),
        ),
        BlocProvider<RecentlyPlayedBloc>(
          create: (context) => RecentlyPlayedBloc(),
        ),
        BlocProvider<NowPlayingBloc>(
          create: (context) => NowPlayingBloc(),
        ),
        BlocProvider<FavoritesBloc>(
          create: (context) => FavoritesBloc(),
        ),
        BlocProvider<PlaylistBloc>(
          create: (context) => PlaylistBloc(),
        ),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Audik',
        home: const SplashScreen(),
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
      ),
    );
  }
}
