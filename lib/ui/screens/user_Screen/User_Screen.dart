import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shanbwrog/Settings/MySettings.dart';
import 'dart:io' show File, Platform;
import 'package:shanbwrog/ui/screens/user_Screen/User_Screen_Settings.dart';

class UserScreen extends StatefulWidget {
  static const String user_screen_ref = 'userscreenref';

  const UserScreen({Key? key}) : super(key: key);

  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid
        ? Scaffold(
            appBar: AppBar(
              title: Text(
                UserScreenSettings.title,
                style: UserScreenSettings.title_Style,
              ),
                centerTitle: true
            ),
            body: BodyWidget(),
          )
        : CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              middle: Text(UserScreenSettings.title,
                  style: UserScreenSettings.title_Style),
            ),
            child: SafeArea(child: BodyWidget()),
          );
  }
}

class BodyWidget extends StatefulWidget {
  const BodyWidget({Key? key}) : super(key: key);

  @override
  State<BodyWidget> createState() => _BodyWidgetState();
}

class _BodyWidgetState extends State<BodyWidget> {
  final ImagePicker _picker = ImagePicker();
  XFile? _file;
  dynamic _pickImageError;

  void pickImage(ImageSource source) async {
    try {
      final pickedFile = await _picker.pickImage(
        source: source,
      );
      setState(() {
        _file = pickedFile;
      });
    } catch (e) {
      setState(() {
        _pickImageError = e;
      });
    }
  }

  Widget _previewImage(MediaQueryData mediaQueryData) {
    var deviceSize = mediaQueryData.size;
    var orientation = mediaQueryData.orientation;
    if (_file != null) {
      return Semantics(
        child: Image.file(
          File(_file!.path),
          width: mediaQueryData.size.width,
          height: orientation == Orientation.landscape
              ? deviceSize.height * .65
              : deviceSize.height * .3,
          fit: BoxFit.fill,
        ),
      );
    } else if (_pickImageError != null) {
      return Text(
        'Pick image error: $_pickImageError',
        textAlign: TextAlign.center,
      );
    } else {
      return Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Text(
            'You have not yet picked an image.',
            textAlign: TextAlign.center,
          )
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final devicesize = MediaQuery.of(context);
    return Padding(
      padding: EdgeInsets.all(15),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton.icon(
                    onPressed: () {
                      pickImage(ImageSource.camera);
                    },
                    icon: Icon(
                      Icons.add_a_photo,
                      size: 24,
                      color: MySettings.maincolor,
                    ),
                    label: Text('Camera')),
                TextButton.icon(
                    onPressed: () {
                      pickImage(ImageSource.gallery);
                    },
                    icon: Icon(
                      Icons.image,
                      size: 24,
                      color: MySettings.maincolor,
                    ),
                    label: Text('Gallery')),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            _previewImage(devicesize)
          ],
        ),
      ),
    );
  }
}
