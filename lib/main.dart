import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shanbwrog/Settings/MySettings.dart';
import 'package:shanbwrog/providers/Albums_Provider.dart';
import 'package:shanbwrog/providers/Photos_Provider.dart';
import 'package:shanbwrog/ui/screens/albums_screen/Albums_Screen.dart';
import 'dart:io' show Platform;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => AlbumsProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => PhotosProvider(),
        ),
      ],
      child: Platform.isAndroid
          ? MaterialApp(
              initialRoute: AlbumsScreen.album_screen_ref,
              routes: MySettings.routes,
              theme: MySettings.theme,
              debugShowCheckedModeBanner: false,
              builder: MySettings.responsiveBuilder,
            )
          : CupertinoApp(
              initialRoute: AlbumsScreen.album_screen_ref,
              routes: MySettings.routes,
              debugShowCheckedModeBanner: false,
              builder: MySettings.responsiveBuilder,
            ),
    );
  }
}
