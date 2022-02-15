import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shanbwrog/Settings/MySettings.dart';
import 'package:shanbwrog/ui/screens/user_Screen/User_Screen.dart';

class AlbumScreenSettings {
  //header settings
  static String title = 'Albums';
  static TextStyle title_Style = TextStyle(
    fontSize: 24,
    color: Colors.black87,
  );
  static Widget trailing(BuildContext context){
    return TextButton.icon(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
            return UserScreen();
          }));
        },
        icon: Icon(
          Icons.account_circle_outlined,
          color: Colors.black87,
          size: 24,
        ),
        label: Text('User',style: TextStyle(
          fontSize: 17,
          color: Colors.black87,
        ),));
  }
  }
