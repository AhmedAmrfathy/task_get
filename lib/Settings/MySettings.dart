import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:shanbwrog/ui/screens/albums_screen/Albums_Screen.dart';
import 'package:shanbwrog/ui/screens/photos_screen/Photos_Screen.dart';
import 'package:shanbwrog/ui/screens/user_Screen/User_Screen.dart';

class MySettings {
  static const Color maincolor = Color.fromRGBO(6, 109, 186, 1);
  static const Color secondarycolor = Color.fromRGBO(118, 191, 203, 1);
  static ThemeData  theme=ThemeData(fontFamily: 'Cairo');

  static Map<String, WidgetBuilder> routes = {
    AlbumsScreen.album_screen_ref: (ctx) => AlbumsScreen(),
    PhotosScreen.photos_screen_ref: (ctx) => PhotosScreen(),
    UserScreen.user_screen_ref: (ctx) => UserScreen(),
  };
  static List<ResponsiveBreakpoint> appBreakPoints = [
    ResponsiveBreakpoint.resize(480, name: MOBILE),
    ResponsiveBreakpoint.autoScale(800, name: TABLET),
    ResponsiveBreakpoint.resize(1000, name: DESKTOP)
  ];

  static TransitionBuilder responsiveBuilder = (context, widget) {
    return ResponsiveWrapper.builder(
      widget,
      maxWidth: 1200,
      minWidth: 480,
      defaultScale: true,
      breakpoints: appBreakPoints,
      background: Container(color: Color(0xFFF5F5F5)),
    );
  };

  static Future<bool> netWorkWorking() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      return true;
    } else {
      return false;
    }
  }
}
