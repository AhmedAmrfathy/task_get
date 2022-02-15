import 'package:flutter/cupertino.dart';
import 'package:shanbwrog/Settings/MySettings.dart';
import 'package:shanbwrog/models/Album.dart';
import 'package:shanbwrog/server/dio.dart';
import 'package:shanbwrog/server/end_ponts.dart';

class AlbumsProvider with ChangeNotifier {
  List<Album> _albums = [];
  String? errorLoadingAlbums = null;
  bool _isLoadingAlbums = false;

  List<Album> get albums {
    return [..._albums];
  }

  bool get isLoadingAlbums => _isLoadingAlbums;

  Future<Map<String, dynamic>> getAlbums(BuildContext context) async {
    errorLoadingAlbums = null;
    Future.delayed(Duration(microseconds: 0), () {
      _isLoadingAlbums = true;
      notifyListeners();
    });

    Map<dynamic, dynamic> response = await dioNetWork(
        appLanguage: 'ar',
        methodType: 'get',
        netWorkWorking: MySettings.netWorkWorking(),
        url: EndPoints.baseurl + EndPoints.segments['albums']);
    if (response['status'] == false) {
      errorLoadingAlbums = response['msg'];
      _isLoadingAlbums = false;
      notifyListeners();
      return {'status': false, 'error': response['msg']};
    } else {
      _albums.clear();
      _albums =
          (response['data'] as List).map((e) => Album.fromJson(e)).toList();
      _isLoadingAlbums = false;
      notifyListeners();
      return {
        'status': true,
      };
    }
  }
}
