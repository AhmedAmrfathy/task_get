import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shanbwrog/Settings/MySettings.dart';
import 'package:shanbwrog/models/Album.dart';
import 'package:shanbwrog/providers/Albums_Provider.dart';
import 'package:shanbwrog/ui/screens/albums_screen/Album_Screen_Settings.dart';
import 'package:shanbwrog/ui/screens/photos_screen/Photos_Screen.dart';
import 'package:shanbwrog/ui/widgets/error_message.dart';
import 'package:shanbwrog/ui/widgets/my_loading.dart';
import 'dart:io' show Platform;

class AlbumsScreen extends StatefulWidget {
  static const String album_screen_ref = 'albumscreenref';

  const AlbumsScreen({Key? key}) : super(key: key);

  @override
  _AlbumsScreenState createState() => _AlbumsScreenState();
}

class _AlbumsScreenState extends State<AlbumsScreen> {
  void fetchAlbums() {
    Future.delayed(Duration(seconds: 0), () {
      setState(() {
        Provider.of<AlbumsProvider>(context, listen: false).getAlbums(context);
      });
    });
  }

  @override
  void initState() {
    fetchAlbums();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid
        ? Scaffold(
            appBar: AppBar(
              title: Text(
                AlbumScreenSettings.title,
                style: AlbumScreenSettings.title_Style,
              ),
              centerTitle: true,
              actions: [AlbumScreenSettings.trailing(context)],
            ),
            body: AlbumList(fetchAlbums),
          )
        : CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              middle: Text(AlbumScreenSettings.title,
                  style: AlbumScreenSettings.title_Style),
              trailing: AlbumScreenSettings.trailing(context),
            ),
            child: SafeArea(child: AlbumList(fetchAlbums)),
          );
  }
}

class AlbumList extends StatelessWidget {
  final Function fetchAlbums;

  AlbumList(this.fetchAlbums);

  @override
  Widget build(BuildContext context) {
    return Consumer<AlbumsProvider>(
      builder: (ctx, data, ch) {
        return data.isLoadingAlbums
            ? Center(
                child: myLoadingWidget(context, MySettings.maincolor),
              )
            : data.errorLoadingAlbums != null
                ? ErrorMessage(
                    errorMessage: data.errorLoadingAlbums!,
                    onReload: () {
                      fetchAlbums();
                    })
                : ListView.builder(
                    itemCount: data.albums.length,
                    itemBuilder: (ctx, index) {
                      return AlbumListItem(data.albums[index]);
                    },
                    padding: EdgeInsets.all(20),
                  );
      },
    );
  }
}

class AlbumListItem extends StatelessWidget {
  final Album album;

  AlbumListItem(this.album);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
          return PhotosScreen(
            albumId: album.id,
          );
        }));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black26),
            borderRadius: BorderRadius.circular(10)),
        child: Text(
          album.title ?? '',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
