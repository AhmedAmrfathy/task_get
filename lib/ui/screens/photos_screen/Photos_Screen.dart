import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shanbwrog/Settings/MySettings.dart';
import 'package:shanbwrog/models/Photo.dart';
import 'package:shanbwrog/providers/Albums_Provider.dart';
import 'package:shanbwrog/providers/Photos_Provider.dart';
import 'package:shanbwrog/ui/screens/albums_screen/Album_Screen_Settings.dart';
import 'package:shanbwrog/ui/widgets/error_message.dart';
import 'package:shanbwrog/ui/widgets/image_preview.dart';
import 'package:shanbwrog/ui/widgets/my_loading.dart';
import 'dart:io' show Platform;

import 'Photos_Screen_Settings.dart';

class PhotosScreen extends StatefulWidget {
  static const String photos_screen_ref = 'photoscreenref';
  final int? albumId;

  PhotosScreen({this.albumId});

  @override
  _PhotosScreenState createState() => _PhotosScreenState();
}

class _PhotosScreenState extends State<PhotosScreen> {
  void fetchPhotos() {
    Future.delayed(Duration(seconds: 0), () {
      setState(() {
        Provider.of<PhotosProvider>(context, listen: false)
            .getPhotos(context, widget.albumId ?? 0);
      });
    });
  }

  @override
  void initState() {
    fetchPhotos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid
        ? Scaffold(
            appBar: AppBar(
              title: Text(
                PhotoScreenSettings.title,
                style: PhotoScreenSettings.title_Style,
              ),
              centerTitle: true,
            ),
            body: PhotosList(fetchPhotos),
          )
        : CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              middle: Text(PhotoScreenSettings.title,
                  style: PhotoScreenSettings.title_Style),
            ),
            child: SafeArea(child: PhotosList(fetchPhotos)),
          );
  }
}

class PhotosList extends StatelessWidget {
  final Function fetchPhotos;

  PhotosList(this.fetchPhotos);

  @override
  Widget build(BuildContext context) {
    return Consumer<PhotosProvider>(
      builder: (ctx, data, ch) {
        return data.isLoadingPhotos
            ? Center(
                child: myLoadingWidget(context, MySettings.maincolor),
              )
            : data.errorLoadingPhotos != null
                ? ErrorMessage(
                    errorMessage: data.errorLoadingPhotos!,
                    onReload: () {
                      fetchPhotos();
                    })
                : ListView.builder(
                    itemCount: data.photos.length,
                    itemBuilder: (ctx, index) {
                      return PhotoListItem(data.photos[index]);
                    },
                    padding: EdgeInsets.all(20),
                  );
      },
    );
  }
}

class PhotoListItem extends StatelessWidget {
  Photo photo;

  PhotoListItem(this.photo);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black26),
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            Text(
              photo.title ?? '',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 15,
            ),
            ImagePreview(
                photo.thumbnailUrl ?? 'http://via.placeholder.com/200x150'),
          ],
        ));
  }
}
